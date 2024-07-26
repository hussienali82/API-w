const { notifyMessage } = require("../utils/notification");
const { pool, client, poolPublic } = require("../db/index");

const Province = {};

Province.all = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT 
    id, 
    pro_name
	FROM province
  order by id;`;
    pool.query(sql, (error, result) => {
      console.log("result:", result);
      if (error)
        return reject(
          notifyMessage(false, "province Not Get Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "province  Get Successfly", result.rows, "")
      );
    });
  });
};
Province.byid = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT  
    pro_name  
    updated_by FROM province WHERE province.id=${id};`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "province Not Get Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "province  Get Successfly", result.rows, "")
      );
    });
  });
};


// Province.update = (Body,id) => {
//   return new Promise((resolve, reject) => {
//       let sql = `update province set 
//                  pro_name='${Body.pro_name}'
//                  where id=${id}`
//                  console.log("sql",sql)
//       pool.query(sql, (err, result) => {
//           if (err) return reject(notifyMessage(false, 'Province was not read', '', err))
//           return resolve(notifyMessage(true, "Province updated successfully", result.rows, {}));
          
//       });
//   });
// };

Province.update = (Body,id) => {
  return new Promise((resolve, reject) => {
      let sql = `update province set 
                 pro_name='${Body.pro_name}'
                 where id=${id}`

      let sql1 = `update province set 
                 pro='${Body.pro_name}'
                 where id=${id}`
                 console.log("sql",sql)
                 console.log("sql1",sql1)
      pool.query(sql, (err, result) => {
          if (err) return reject(notifyMessage(false, 'Province was not read', '', err))
          return resolve(notifyMessage(true, "Province Delete successfully", result.rows, {}));
          
      });
      poolPublic.query(sql1, (err, result) => {
        if (err) return reject(notifyMessage(false, 'Province Public was not read', '', err))
        return resolve(notifyMessage(true, "Province Public Delete successfully", result.rows, {}));
        
    });
  });
};

// Province.insert = (body) => {
//   return new Promise((resolve, reject) => {
//     // solve problem
//     let sql = `INSERT INTO province(pro_name) VALUES ('${body.pro_name}');`;
//     pool.query(sql, (error, result) => {
//       if (error)
//         return reject(
//           notifyMessage(false, "province Not Insert Successfly", "", error)
//         );
//       return resolve(
//         notifyMessage(true, "province  Insert Successfly", result.rows, "")
//       );
//     });
//   });
// };

Province.insert = (body) => {
  return new Promise((resolve, reject) => {
    // solve problem
    let sql = `INSERT INTO province(pro_name) VALUES ('${body.pro_name}');`;

    let sql1 = `INSERT INTO province(pro) VALUES ('${body.pro_name}');`;
    console.log("sql",sql);
    console.log("sql1",sql1);
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "province Not Insert Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "province  Insert Successfly", result.rows, "")
      );
    });

    poolPublic.query(sql1, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "province public Not Insert Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "province public  Insert Successfly", result.rows, "")
      );
    });
  });
};


// Province.delete=(id)=>{return new Promise((resolve,reject)=>{

//   let sql=` DELETE FROM province
// WHERE  id=${id};`
//   pool.query(sql,(error,result)=>{
//       if(error) return reject(notifyMessage(false,"Province Not Update Successfly",'',error))
//       return resolve(notifyMessage(true,'Province  Update Successfly',result.rows,''))
//   }
//   )
  
//   })}

Province.delete=(id)=>{return new Promise((resolve,reject)=>{

  let sql=` DELETE FROM province WHERE  id=${id};`
  
  let sql1=` DELETE FROM province WHERE  id=${id};`
  pool.query(sql,(error,result)=>{
      if(error) return reject(notifyMessage(false,"Province Not Delete Successfly",'',error))
      return resolve(notifyMessage(true,'Province  Delete Successfly',result.rows,''))
  }
  )
  poolPublic.query(sql1,(error,result)=>{
    if(error) return reject(notifyMessage(false,"Province Public Not Delete Successfly",'',error))
    return resolve(notifyMessage(true,'Province Public  Delete Successfly',result.rows,''))
}
)
  
  })}

module.exports = Province;
