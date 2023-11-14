const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'Pe_Uta_Main',
  password: 'nacho',
  port: 5432, // El puerto predeterminado de PostgreSQL
});

module.exports = pool;
