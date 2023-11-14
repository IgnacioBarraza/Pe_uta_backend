function validarRut(rut) {
  // Formato del RUT: 12345678-9
  const rutRegex = /^\d{7,8}-[\dkK]$/;

  if (!rut.match(rutRegex)) {
    return false; // El formato no coincide
  }

  // Extraer el número y el dígito verificador
  const rutNumeros = rut.slice(0, -2);
  const rutDV = rut.slice(-1).toUpperCase();

  // Calcular el dígito verificador esperado
  let suma = 0;
  let multiplicador = 2;

  for (let i = rutNumeros.length - 1; i >= 0; i--) {
    suma += parseInt(rutNumeros[i]) * multiplicador;

    multiplicador = multiplicador === 7 ? 2 : multiplicador + 1;
  }

  const digitoVerificadorEsperado = (11 - (suma % 11)).toString();

  if (digitoVerificadorEsperado === '10') {
    return rutDV === 'K'; // RUT válido
  } else if (digitoVerificadorEsperado === '11') {
    return rutDV === '0'; // RUT válido
  } else if (digitoVerificadorEsperado === rutDV) {
    return true; // RUT válido
  }

  return false; // Dígito verificador incorrecto
}
module.exports = validarRut;