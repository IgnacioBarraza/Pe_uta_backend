require('dotenv').config();
const { Pool } = require('pg');

const pool = new Pool({
  user: process.env.userdb,
  host: process.env.host,
  database: process.env.database,
  password: process.env.passdb,
  port: process.env.portdb, 
});


module.exports = pool;
