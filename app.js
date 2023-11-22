const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const bcrypt = require('bcrypt');
const { Pool } = require('pg');
const pool = require('./database');
const validarRut = require('./rutValidator');
const cors = require('cors');
const ExcelJS = require('exceljs');
require('dotenv').config();
const jwt = require('jsonwebtoken');

// Crear una instancia de Express
const app = express();

// Configuración de middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({ secret: 'your-secret-key', resave: false, saveUninitialized: true }));
app.use(cors());

app.post('/evaluaciones', async (req, res) => {
  try {
    // Extraer los datos de la evaluación desde el cuerpo de la solicitud
    const { rut, grupo_id, puntuaciones, } = req.body;

    // Verificar si el usuario ya ha evaluado el grupo específico
    const evaluacionExistente = await pool.query('SELECT * FROM evaluaciones WHERE users_id = (SELECT id FROM users WHERE rut = $1) AND grupo_id = $2', [rut, grupo_id]);

    if (evaluacionExistente.rows.length > 0) {
      // El usuario ya ha evaluado este grupo
      return res.status(400).json({ mensaje: 'Ya has evaluado este grupo anteriormente' });
    }

    // El usuario no ha evaluado este grupo, proceder con la evaluación

    // Verificar si el usuario existe en la base de datos
    const usuarioExistente = await pool.query('SELECT * FROM users WHERE rut = $1', [rut]);

    let userId;

    if (usuarioExistente.rows.length > 0) {
      // Si el usuario existe, obtener su ID
      userId = usuarioExistente.rows[0].id;
    }

    // Insertar las evaluaciones en la base de datos
    for (let i = 0; i < puntuaciones.length; i++) {
      const puntuacion = puntuaciones[i];
      const criterio_id = i+1;

      await pool.query('INSERT INTO evaluaciones (users_id, grupo_id, criterio_id, puntuacion) VALUES ($1, $2, $3, $4)', [userId, grupo_id, criterio_id, puntuacion]);
    }

    // Enviar una respuesta exitosa
    res.status(201).json({ mensaje: 'Evaluación realizada con éxito' });
  } catch (error) {
    console.error('Error al realizar la evaluación', error);
    res.status(500).json({ mensaje: 'Error interno del servidor' });
  }
});

// Ruta para obtener información de evaluaciones, usuarios, grupos y criterios
app.post('/export', async (req, res) => {
  try {
    const tipo = req.body.tipo;

    // Verificar si el tipo es igual a 1
    if (tipo === 1) {
      // Consultar la información de evaluaciones, usuarios, grupos y criterios
      const resultado = await pool.query(
        'SELECT ' +
        'grupos.nombre AS nombre_grupo, ' +
        'AVG(CASE WHEN criterios.id = 1 THEN evaluaciones.puntuacion ELSE NULL END) AS avg_criterio_1, ' +
        'AVG(CASE WHEN criterios.id = 2 THEN evaluaciones.puntuacion ELSE NULL END) AS avg_criterio_2, ' +
        'AVG(CASE WHEN criterios.id = 3 THEN evaluaciones.puntuacion ELSE NULL END) AS avg_criterio_3, ' +
        'AVG(CASE WHEN criterios.id = 4 THEN evaluaciones.puntuacion ELSE NULL END) AS avg_criterio_4, ' +
        'AVG(CASE WHEN criterios.id = 5 THEN evaluaciones.puntuacion ELSE NULL END) AS avg_criterio_5, ' +
        'AVG(evaluaciones.puntuacion) AS avg_total ' +
        'FROM evaluaciones ' +
        'JOIN grupos ON evaluaciones.grupo_id = grupos.id ' +
        'JOIN criterios ON evaluaciones.criterio_id = criterios.id ' +
        'GROUP BY grupos.nombre'
      );

      // Crear un nuevo libro de Excel y configurar la hoja de trabajo
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Evaluaciones');

      // Definir encabezados
      worksheet.addRow(['Nombre del Grupo', 'Promedio Criterio 1', 'Promedio Criterio 2', 'Promedio Criterio 3', 'Promedio Criterio 4', 'Promedio Criterio 5', 'Promedio Total']);

      // Llenar el archivo Excel con los datos
      resultado.rows.forEach(row => {
        worksheet.addRow([
          row.nombre_grupo,
          row.avg_criterio_1,
          row.avg_criterio_2,
          row.avg_criterio_3,
          row.avg_criterio_4,
          row.avg_criterio_5,
          row.avg_total
        ]);
      });

      // Configurar la respuesta para descargar el archivo Excel
      res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      res.setHeader('Content-Disposition', 'attachment; filename=evaluaciones.xlsx');

      // Enviar el archivo Excel como respuesta
      await workbook.xlsx.write(res);
      res.end();
    } else {
      // Si el tipo no es igual a 1, enviar una respuesta indicando que el tipo no es válido
      res.status(400).json({ mensaje: 'Tipo no válido' });
    }

  } catch (error) {
    console.error('Error al obtener la información de evaluaciones, usuarios, grupos y criterios', error);
    res.status(500).json({ mensaje: 'Error interno del servidor' });
  }
});

// Ruta para obtener información de grupos y asignaturas
app.get('/grupos-asignaturas', async (req, res) => {
  try {
    // Consultar la información de grupos y asignaturas
    const resultado = await pool.query(
      `SELECT
      grupos.id AS id_grupo,
      grupos.nombre AS nombre_grupo,
      asignaturas.id AS id_asignatura,
      asignaturas.nombre AS nombre_asignatura,
      grupos.imagen_url,
      grupos.descripcion
    FROM grupos
    JOIN asignaturas ON grupos.asignatura_id = asignaturas.id;
    `);

    // Enviar el resultado como respuesta
    res.status(200).json(resultado.rows);
  } catch (error) {
    console.error('Error al obtener la información de grupos y asignaturas', error);
    res.status(500).json({ mensaje: 'Error interno del servidor' });
  }
});

app.post('/registro-o-inicio-sesion', async (req, res) => {
  const { rut, password } = req.body;

  // Verificar si el usuario ya existe en la base de datos
  const usuarioExistente = await pool.query('SELECT * FROM users WHERE rut = $1', [rut]);

  if (usuarioExistente.rows.length > 0) {
    // Si el usuario ya existe, intentar iniciar sesión
    const usuario = usuarioExistente.rows[0];

    // Comparar la contraseña ingresada con la contraseña hasheada en la base de datos
    const match = await bcrypt.compare(password, usuario.password);

    if (match) {
      // Crea un token para almacenar y manejar la sesion del usuario en el front
      const token = jwt.sign({
          userRut: usuario.rut,
          tipoId: usuario.tipo_id,
          userID: usuario.id
        },
        'LKNNIAJ90QE209JQNIOASD0820J1390HIOASDVI',
        { expiresIn: "2h" }
      );  
      // Credenciales válidas, permitir el inicio de sesión
      req.session.usuario = usuario;
      const gruposEvaluados = await pool.query('SELECT DISTINCT grupo_id FROM evaluaciones WHERE users_id = $1', [usuario.id]);
      return res.status(200).json({
          mensaje: 'Inicio de sesión exitoso',
          token: token,
          rut: usuario?.rut,
          userID: usuario?.id,
          gruposEvaluados: gruposEvaluados.rows
        });
    } else {
      // Contraseña incorrecta
      return res.status(401).json({ mensaje: 'Credenciales incorrectas' });
    }
  } else {
    // Si el usuario no existe, validar el formato del RUT y calcular el dígito verificador
    if (!validarRut(rut)) {
      return res.status(400).json({ mensaje: 'RUT inválido' });
    }

    // Generar un hash de la contraseña antes de almacenarla en la base de datos
    const hashedPassword = await bcrypt.hash(password, 10);
    /* 
      Insertar el nuevo usuario en la base de datos con la contraseña hasheada
      rut: es el rut que se ingresa en el front
      tipo_id:
      1 = admin user
      2 = normal user
      hashedPassword: contraseña hasheada para mas seguridad
    */
    await pool.query('INSERT INTO users (rut, tipo_id, password) VALUES ($1, $2, $3)', [rut, 1, hashedPassword]);

    // Obtener el usuario recién registrado
    const usuarioRegistrado = await pool.query('SELECT * FROM users WHERE rut = $1', [rut]);
    const nuevoUsuario = usuarioRegistrado.rows[0];

    // Establecer la sesión del usuario recién registrado
    req.session.usuario = nuevoUsuario;

    if (nuevoUsuario) {
      const token = jwt.sign({
          userRut: nuevoUsuario.rut,
          tipoId: nuevoUsuario.tipo_id,
          userID: nuevoUsuario.id
        },
        'LKNNIAJ90QE209JQNIOASD0820J1390HIOASDVI',
        { expiresIn: "2h" }
      ); 
      res.status(201).json({ 
        mensaje: 'Usuario registrado con éxito y sesión iniciada',
        token: token,
        rut: nuevoUsuario?.rut,
        userID: nuevoUsuario?.id,
        gruposEvaluados: []
      });
    }
  }
});

app.get('/usuarios', async (req, res) => {
  // Consultar la lista de usuarios desde la base de datos
  const usuarios = await pool.query('SELECT * FROM users');

  res.status(200).json(usuarios.rows);
});

app.get('/asignaturas', async (req, res) => {
  // Consultar la lista de usuarios desde la base de datos
  const asignaturas = await pool.query('SELECT * FROM asignaturas');

  res.status(200).json(asignaturas.rows);
});

app.get('/grupo-por-id/:id', async (req, res) => {
  const {id} = req.params
  // Consultar la lista de grupos y devuelve la información del grupo que corresponda la id
  const grupo = await pool.query('SELECT grupos.*, asignaturas.nombre AS nombre_asignatura FROM grupos JOIN asignaturas ON grupos.asignatura_id = asignaturas.id WHERE grupos.id = $1', [id]);

  res.status(200).json(grupo.rows);
});

app.get('/integrantes-grupo/:id', async (req, res) => {
  const {id} = req.params
  // Consultar la lista de integrantes y devuelve la información de los integrantes que correspondan a la id del grupo
  const grupo = await pool.query('SELECT * FROM integrantes WHERE grupo_id = $1', [id]);

  res.status(200).json(grupo.rows);
});

app.get('/integrantes', async (req, res) => {
  // Consultar la lista de integrantes desde la base de datos
  const usuarios = await pool.query('SELECT * FROM integrantes');

  res.status(200).json(usuarios.rows);
});


const PORT = process.env.port;
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});
