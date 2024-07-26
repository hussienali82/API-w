const { notifyMessage } = require("../utils/notification");
const { pool, client } = require("../db/index");

const Approval_destination = {};

Approval_destination.all = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT 
    id, 
    destination, 
    role_type, 
    approval_part,
    precedence, 
    send_sms
	  FROM approval_destination
    order by id;`;
    
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(
            false,
            "Approval_destination Not Get Successfly",
            "",
            error
          )
        );
      return resolve(
        notifyMessage(
          true,
          "Approval_destination  Get Successfly",
          result.rows,
          
          ""
         
        )
      );
    });
  });
};

Approval_destination.byid = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT * 
     FROM Approval_destination WHERE Approval_destination.id=${id};`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(
            false,
            "Approval_destination Not Get Successfly",
            "",
            error
          )
        );
      return resolve(
        notifyMessage(
          true,
          "Approval_destination  Get Successfly",
          result.rows,
          ""
        )
      );
    });
  });
};

    Approval_destination.update = (Body,id) => {
    return new Promise((resolve, reject) => {
        let sql = `update approval_destination set 
                   destination='${Body.destination}',
                   role_type=${Body.role_type},
                   approval_part=${Body.approval_part},
                   precedence=${Body.precedence},
                   send_sms=${Body.send_sms}
                   where id=${id}`
                   console.log("sql",sql)

        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Approval_destination was not read', '', err))
            return resolve(notifyMessage(true, "Approval_destination updated successfully", result.rows, {}));
            
        });
    });
};


Approval_destination.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      let sql = `INSERT INTO approval_destination (destination,role_type,approval_part, precedence, send_sms) VALUES ('${body.destination}',${body.role_type},${body.approval_part},${body.precedence},${body.send_sms});`;
      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "approval_destination Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "approval_destination  Insert Successfly", result.rows, "")
        );
      });
    });
  };


Approval_destination.delete = (id) => {
  return new Promise((resolve, reject) => {
    let sql = ` DELETE FROM Approval_destination
        WHERE  id=${id};`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(
            false,
            "Approval_destination Not Update Successfly",
            "",
            error
          )
        );
      return resolve(
        notifyMessage(
          true,
          "Approval_destination  Update Successfly",
          result.rows,
          ""
        )
      );
    });
  });
};

module.exports = Approval_destination;
