const {Sequelize} = require('sequelize');
require('dotenv').config();

const db = process.env.DB;
const username = process.env.USERNAME;
const password = process.env.PASSWORD;
const host = process.env.HOST;

const sequelize = new Sequelize(db, username, password, {
    host: host,
    dialect: 'mysql',
    logging: false
});

module.exports = sequelize;