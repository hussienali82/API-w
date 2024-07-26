
const { notifyMessage } = require('../utils/notification')
const { pool, client } = require('../db/index')

const biometric = {}

biometric.all = () => {
    return new Promise((resolve, reject) => {

        let sql = `SELECT * FROM biometric;`
        pool.query(sql, (error, result) => {

            if (error) return reject(notifyMessage(false, "biometric Not Get Successfly", '', error))
            console.log('error', error)
            return resolve(notifyMessage(true, 'biometric  Get Successfly', result.rows, ''))

        })
    })
}
biometric.byid = (id) => {
    return new Promise((resolve, reject) => {

        let sql = `SELECT * FROM biometric WHERE biometric.id=${id};`
        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "biometric Not Get Successfly", '', error))
            return resolve(notifyMessage(true, 'biometric  Get Successfly', result.rows, ''))

        })
    })
}

biometric.byReqDetID = (id) => {
    return new Promise((resolve, reject) => {

        let sql = `select requests_details.*,
        biometric.pict, biometric.iris, biometric.fing_dat, biometric.fing_xml, biometric.note
        from requests_details left join biometric on requests_details.biometric_id = biometric.id
        where requests_details.id ='${id}';`
        pool.query(sql, (error, result) => {

            if (error) return reject(notifyMessage(false, "biometric Not Get Successfly", '', error))
            return resolve(notifyMessage(true, 'biometric  Get Successfly', result.rows, ''))

        })
    })
}

biometric.update = (body) => {
    return new Promise((resolve, reject) => {

        let sql = `Update biometric set
        fing_dat= '${body.fing_dat}',
        fing_xml='${body.fing_xml}',
        updated_at = default,
        updated_by=${body.updated_by}
         WHERE biometric.id='${body.id}';`
        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "biometric Not Update Successfly", '', error))
            return resolve(notifyMessage(true, 'biometric  Update Successfly', result.rows, ''))
        }
        )

    })
}

            // if (error) return reject(notifyMessage(false, "biometric Not Get Successfly", '', error))
            // return resolve(notifyMessage(true, 'biometric  Get Successfly', result.rows, ''))

biometric.insert = (body) => {
    return new Promise((resolve, reject) => {
        let sql = `INSERT INTO biometric VALUES (
            default,
         '${body.pict}',
            default,
            default,
            default,
            default,
            default,
         ${body.created_by},
            default,
            default )
            RETURNING id;`
            console.log("sql",sql);
        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "biometric Not Insert Successfly", '', error))
            return resolve(notifyMessage(true, 'biometric  Insert Successfly', result.rows, ''))
        })
    }
    )
}
module.exports = biometric