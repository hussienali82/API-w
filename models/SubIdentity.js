const { notifyMessage } = require("../utils/notification");
const { pool, client } = require("../db/index");

const SubIdentity = {};

SubIdentity.all = () => {
    return new Promise((resolve, reject) => {
        let sql = `SELECT *	FROM subidentity  order by sudid;`;
        pool.query(sql, (error, result) => {
            console.log("result:", result);
            if (error)
                return reject(
                    notifyMessage(false, "subidentity Not Get Successfly", "", error)
                );
            return resolve(
                notifyMessage(true, "subidentity  Get Successfly", result.rows, "")
            );
        });
    });
};
SubIdentity.byid = (id) => {
    return new Promise((resolve, reject) => {
        let sql = `SELECT * FROM subidentity WHERE subidentity.sudid=${id};`;
        pool.query(sql, (error, result) => {
            if (error)
                return reject(
                    notifyMessage(false, "subidentity Not Get Successfly", "", error)
                );
            return resolve(
                notifyMessage(true, "subidentity  Get Successfly", result.rows, "")
            );
        });
    });
};


SubIdentity.update = (Body, id) => {
    return new Promise((resolve, reject) => {
        let sql = `update subidentity set 
        sudname='${Body.sudname}', 
        sudrultype=${Body.sudrultype},
        validity=${Body.validity},
        send_sms=${Body.send_sms} 
        where sudid=${id}`

        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'SubIdentity was not read', '', err))
            return resolve(notifyMessage(true, "SubIdentity updated successfully", result.rows, {}));

        });
    });
};

SubIdentity.insert = (body) => {
    return new Promise((resolve, reject) => {
        // solve problem
        let sql = `INSERT INTO subidentity VALUES (default,'${body.sudname}',${body.sudrultype},${body.validity},${body.send_sms}  );`;
        pool.query(sql, (error, result) => {
            if (error)
                return reject(
                    notifyMessage(false, "subidentity Not Insert Successfly", "", error)
                );
            return resolve(
                notifyMessage(true, "subidentity  Insert Successfly", result.rows, "")
            );
        });
    });
};

SubIdentity.delete = (id) => {
    return new Promise((resolve, reject) => {
        let sql = ` DELETE FROM subidentity WHERE sudid=${id};`
        pool.query(sql, (error, result) => {
            if (error) return reject(notifyMessage(false, "SubIdentity Not Update Successfly", '', error))
            return resolve(notifyMessage(true, 'SubIdentity  Update Successfly', result.rows, ''))
        }
        )
    })
}

module.exports = SubIdentity;
