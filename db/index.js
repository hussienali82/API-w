// const oracledb = require('oracledb');
const dotenv = require('dotenv');
dotenv.config();


const { Pool, Client } = require('pg')

const pool = new Pool({
    user: process.env.PG_USER,
    host: process.env.PG_HOST,
    database: process.env.PG_DATABASE,
    password: process.env.PG_PASSWORD,
    port: process.env.PG_PORT,
})

const poolPublic = new Pool({
    user: process.env.PG_USER_PUBLIC,
    host: process.env.PG_HOST_PUBLIC,
    database: process.env.PG_DATABASE_PUBLIC,
    password: process.env.PG_PASSWORD_PUBLIC,
    port: process.env.PG_PORT_PUBLIC,
})

// pool.query('SELECT NOW()', (err, res) => {
//     console.log(err, res)
//     pool.end()
// })

const client = new Client({
    user: process.env.PG_USER,
    host: process.env.PG_HOST,
    database: process.env.PG_DATABASE,
    password: process.env.PG_PASSWORD,
    port: process.env.PG_PORT,
})


// client.connect()




// //create connection
// async function initialize() {

//     await oracledb.createPool({
//         username: process.env.DB_USERNAME,
//         password: process.env.DB_PASSWORD,
//         connectString: `${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_CONTAINER}`,
//         poolMin: 10,
//         poolMax: 10,
//         poolIncrement: 0
//     })
//     console.warn('INFO: db pool created.')
// }


//export connection
// module.exports.initialize = initialize()

module.exports = { pool,poolPublic, client }

