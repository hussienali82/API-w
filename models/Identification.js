
const { notifyMessage } = require('../utils/notification')
const { pool, client } = require('../db/index')

const moment = require("moment-timezone");




//////////////////////////////////
const text1 = '2972867785,aa,vv,dd'
// const text1 = '297'




try {
    //     const keyData = `-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+7GydcXJ4Xe8OU+ZDdbmoKOMWXKMRHw15cmp2S5LLtzatL+kpR5/89H4Zwn6cPjCO0YSTfoWXgM+3BONbHqm5gQUc3YrHkUFUROYI4lJY6W1SaNohSwf6MpNOJ8d9t6+3LSF3Bgb96tYy2UpYCZX0s+DsJp8XkAhhvjceMWKqQIDAQAB-----END PUBLIC KEY-----`


    //     let key = new NodeRSA(keyData, 'pkcs8-public');


    //     const encrypted1 = key.encrypt(text1.toString().trim()); //, 'base64'
    //     const e1ncryptedBase64 = encrypted1.toString('base64');

    //     console.log(e1ncryptedBase64);
    //     console.log(key);

    // const publicKey = key.exportKey("pkcs8-public");//"public"
    // var sp= publicKey.split('-----');
    // console.log("sp: ", sp[2]); //pkcs8-public
    // console.log("publicKey: ", publicKey); //pkcs8-public

} catch (error) {
    console.log("EEEEE ", error);
}





const identification = {}

identification.all = () => {
    return new Promise((resolve, reject) => {

        let sql = `SELECT *	FROM identification;`
        pool.query(sql, (error, result) => {

            if (error) return reject(notifyMessage(false, "identification Not Get Successfly", '', error))
            return resolve(notifyMessage(true, 'identification  Get Successfly', result.rows, ''))

        })
    })
}
identification.isPrint = (is_print) => {
    return new Promise((resolve, reject) => {
        let sql = `SELECT 
    identification.id, 
      req_det_id,
      printtime, 
      identification.idnum, 
      expdate, 
      permdate,
      identification.note as noteprint, 
      is_print,
      license_id, 
      approval_role, 
     ( name1 || ' ' ||            
      name2 || ' ' ||
      name3|| ' ' ||
      name4|| ' ' ||
      surname ) as fullname,
      category.cat,
      gender_type, 
      cat_id, 
      birdate, 
      (monam1 || ' ' || 
      monam2 || ' ' || 
      monam3)as fullmonam, 
      iss_1, 
      issdat1, 
      natnum, 
      iss_2, 
      issdat2, 
      pro_id, 
      addresses, 
      nearplace, 
      mahala, 
      zuqaq, 
      dar, 
      djp, 
      numdet, 
      datedet, 
      phone, 
      weapname_id, 
      weapnum,  
      wea_hold_per, 
      margin_app, 
      completed, 
      requests_details.note , 
      identification.created_at, 
      identification.created_by, 
      identification.updated_at, 
      identification.updated_by
      FROM identification left join requests_details on identification.req_det_id = requests_details.
      id
      inner join category on requests_details.cat_id = category.id`
        if (is_print < 3) {
            sql = sql + ` where is_print= '${is_print}';`
        }
        console.log('sqlm7md', sql)
        pool.query(sql, (error, result) => {

            if (error) return reject(notifyMessage(false, "identification Not Get Successfly", '', error))
            return resolve(notifyMessage(true, 'identification  Get Successfly', result.rows, ''))

        })
    })
}
//search
identification.issearchPrint = (is_print, date1, date2) => {
    return new Promise((resolve, reject) => {
        let sql = `SELECT 
    identification.id, 
      req_det_id,
      printtime, 
      identification.idnum, 
      expdate, 
      permdate,
      identification.note as noteprint, 
      is_print,
      license_id, 
      approval_role, 
     ( name1 || ' ' ||            
      name2 || ' ' ||
      name3|| ' ' ||
      name4|| ' ' ||
      surname ) as fullname,
      category.cat,
      gender_type, 
      cat_id, 
      birdate, 
      (monam1 || ' ' || 
      monam2 || ' ' || 
      monam3)as fullmonam, 
      iss_1, 
      issdat1, 
      natnum, 
      iss_2, 
      issdat2, 
      pro_id, 
      addresses, 
      nearplace, 
      mahala, 
      zuqaq, 
      dar, 
      djp, 
      numdet, 
      datedet, 
      phone, 
      weapname_id, 
      weapnum,  
      wea_hold_per, 
      margin_app, 
      completed, 
      requests_details.note , 
      identification.created_at, 
      identification.created_by, 
      identification.updated_at, 
      identification.updated_by
      FROM identification left join requests_details on identification.req_det_id = requests_details.id
      inner join category on requests_details.cat_id = category.id`
        if (is_print < 3 && date1 !== null && date2 !== null) {
            sql = sql + ` where is_print= '${is_print}' AND printtime BETWEEN '${date1}' AND '${date2}'`
        } else {
            sql = sql + ` where printtime BETWEEN '${date1}' AND '${date2}'`
        }

        console.log('sqlm7md', sql)
        pool.query(sql, (error, result) => {

            if (error) return reject(notifyMessage(false, "identification Not Get Successfly", '', error))
            return resolve(notifyMessage(true, 'identification  Get Successfly', result.rows, ''))

        })
    })
}
identification.byid = (id) => {
    return new Promise((resolve, reject) => {

        let sql = `SELECT *	FROM identification WHERE identification.req_det_id='${id}' ORDER BY updated_by desc ;`
        pool.query(sql, (error, result) => {

            if (error) return reject(notifyMessage(false, "identification Not Get Successfly", '', error))
            return resolve(notifyMessage(true, 'identification  Get Successfly', result.rows, ''))

        })
    })
}

identification.StopPrint = (id) => {
    return new Promise((resolve, reject) => {

        let sql = `SELECT * FROM identification WHERE identification.req_det_id='${id}'
                    and is_print = 0;`
        console.log("sql", sql);
        pool.query(sql, (error, result) => {

            if (error) return reject(notifyMessage(false, "identification Not Get Successfly", '', error))
            return resolve(notifyMessage(true, 'identification  Get Successfly', result.rows, ''))

        })
    })
}

identification.update = (body) => {
    return new Promise((resolve, reject) => {

        let sql = `Update identification set
req_det_id=N${body.req_det_id},
printtime=N${body.printtime},
idnum=N${body.idnum},
expdate=N${body.expdate},
permdate=N${body.permdate},
note=N${body.note},
created_at=N${body.created_at},
created_by=N${body.created_by},
updated_at=N${body.updated_at},
updated_by=N${body.updated_by}
FROM identification WHERE identification.id=${id};`
        console.log("sql", sql);
        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "identification Not Update Successfly", '', error))
            return resolve(notifyMessage(true, 'identification  Update Successfly', result.rows, ''))
        }
        )

    })
}


identification.insert = (body) => {
    return new Promise((resolve, reject) => {

        // console.log('body', body)
        let sql = `INSERT INTO identification VALUES(
                    default,
                    '${body.id}',
                    CURRENT_DATE,
                    '${body.idnum}',
                     CURRENT_DATE + interval '2 years',
                     CURRENT_DATE,
                     default,
                     default,
                     ${body.created_by},
                     default,
                     ${body.updated_by},
                     0,
                     '${body.qr_code}',
                     default,
                     default,
                     cast(0 as bit ),
                     default,
                     default,
                     '${body.img_print}');`
        // console.log('sql', sql)
        console.log('sqlinPOST', sql)

        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "identification Not Insert Successfly", '', error))
            return resolve(notifyMessage(true, 'identification  Insert Successfly', result.rows, ''))
        })
    }

    )
}

identification.updateQuality = (body) => {
    console.log('body', body)
    return new Promise((resolve, reject) => {
        let sql = body?.quality === 1 ? `Update identification set
                quality='${body.quality}',
                quality_note='${body.quality_note}',
                updated_at=default,
                updated_by=${body.updated_by}
                WHERE identification.id='${body.id_identification}';`
                    : `Update identification set
                is_print=3,
                quality='${body.quality}',
                quality_note='${body.quality_note}',
                updated_at=default,
                updated_by=${body.updated_by}
                WHERE identification.id='${body.id_identification}';`
        console.log("sql", sql);

        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "identification Not Quality Updated Successfly", '', error))
            return resolve(notifyMessage(true, 'identification Quality Updated Successfly', result.rows, ''))
        }
        )

    })
}

identification.updateRecieve = (body) => {
    return new Promise((resolve, reject) => {
        console.log('bodym7md', body);
        let sql = `Update identification set
        is_receive=cast(1 AS bit),
        updated_at=default,
        updated_by=${body.updated_by}
        WHERE identification.req_det_id='${body.id}' and identification.quality =CAST(${body.quality} AS bit);`
        console.log("sql", sql);
        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "identification Not Recive Update Successfly", '', error))
            return resolve(notifyMessage(true, 'identification Quality Recieve Successfly', result.rows, ''))
        }
        )

    })
}

identification.updateRePrint = (body, is_print) => {
    return new Promise((resolve, reject) => {

        let sql = `Update identification set
        is_print = ${is_print},
        updated_at = default,
        updated_by=${body.updated_by}
        WHERE identification.id='${body.id_identification}';`
        // console.log("sql", sql);
        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "identification Not Recive Update Successfly", '', error))
            return resolve(notifyMessage(true, 'identification Quality Recieve Successfly', result.rows, ''))
        }
        )

    })
}

identification.oldwid = (idnum) => {
    return new Promise((resolve, reject) => {

        let sql = `SELECT 
        identification.id, 
        identification.idnum as id_license, 
        requests_details.idnum,
        is_print,
        is_receive,
        requests_details.note
        FROM identification left join requests_details on identification.req_det_id = requests_details.id
        inner join category on requests_details.cat_id = category.id
        where requests_details.idnum = '${idnum}' and is_receive = '1';`
        pool.query(sql, (error, result) => {

            if (error) return reject(notifyMessage(false, "identification id Not Get Successfly", '', error))
            return resolve(notifyMessage(true, 'identification id  Get Successfly', result.rows, ''))

        })
    })
}


module.exports = identification