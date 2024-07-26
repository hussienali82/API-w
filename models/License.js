const {notifyMessage}=require ('../utils/notification')
const {pool,client}=require('../db/index')


const license_type= {}

license_type.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT 
    id, 
    license,
    approving_party
	FROM license_type
    order by id;`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"license_type Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'license_type  Get Successfly',result.rows,''))

    })
})}
license_type.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT  
    id, 
    license,
    approving_party FROM license_type WHERE license_type.id=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"license_type Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'license_type  Get Successfly',result.row,''))

    })
})}

license_type.update = (Body,id) => {
  return new Promise((resolve, reject) => {
      let sql = `update license_type set 
      license='${Body.license}',
      approving_party=${Body.approving_party}
      where id=${id}`
      console.log("sql",sql)
      pool.query(sql, (err, result) => {
          if (err) return reject(notifyMessage(false, 'license_type was not read', '', err))
          return resolve(notifyMessage(true, "license_type updated successfully", result.rows, {}));
          
      });
  });
};

license_type.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      let sql = `INSERT INTO license_type (license, approving_party) VALUES ('${body.license}', ${body.approving_party});`;
      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "license_type Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "license_type  Insert Successfly", result.rows, "")
        );
      });
    });
  };

    license_type.delete=(id)=>{return new Promise((resolve,reject)=>{

        let sql=` DELETE FROM license_type
        WHERE  id=${id};`
        pool.query(sql,(error,result)=>{
            if(error) return reject(notifyMessage(false,"license_type Not Update Successfly",'',error))
            return resolve(notifyMessage(true,'license_type  Update Successfly',result.rows,''))
        }
        )
        
        })}

    module.exports=license_type