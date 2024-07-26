const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const information_office= {}
information_office.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT DISTINCT id, name
	FROM public.information_office
    order by id;`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"information_office Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'InformationOffice  Get Successfly',result.rows,''))

    })
})}

information_office.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT id, name
	FROM public.information_office
     WHERE information_office.id=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"information_office Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'information_office  Get Successfly',result.rows,''))

    })
})}

// information_office.update = (Body,id) => {
//     return new Promise((resolve, reject) => {
//         let sql = `update information_office set 
//                    name='${Body.name}'
//                    where id=${id}`
//                    console.log("sql",sql)
  
//         pool.query(sql, (err, result) => {
//             if (err) return reject(notifyMessage(false, 'information_office was not read', '', err))
//             return resolve(notifyMessage(true, "information_office updated successfully", result.rows, {}));
            
//         });
//     });
//   };
information_office.update = (Body,id) => {
  return new Promise((resolve, reject) => {

      let sql = `UPDATE information_office set
	               name='${Body.name}'
                 where id=${id}`
                 
      let sql1 = `UPDATE issuer set
                  iss='${Body.name}'
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

  // information_office.insert = (body) => {
  //   return new Promise((resolve, reject) => {
  //     // solve problem
  //     let sql = `INSERT INTO information_office (name) VALUES ('${body.name}');`;
  //     console.log("sql",sql);
  //     pool.query(sql, (error, result) => {
  //       if (error)
  //         return reject(
  //           notifyMessage(false, "information_office Not Insert Successfly", "", error)
  //         );
  //       return resolve(
  //         notifyMessage(true, "information_office  Insert Successfly", result.rows, "")
  //       );
  //     });
  //   });
  // };

  information_office.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      let sql = `INSERT INTO information_office (name) VALUES ('${body.name}');`;

      let sql1 = `INSERT INTO issuer (iss) VALUES ('${body.name}');`;
      console.log("sql",sql);
      console.log("sql1",sql1);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "information_office Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "information_office  Insert Successfly", result.rows, "")
        );
      });
      poolPublic.query(sql1, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "information_office Public Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "information_office Public Insert Successfly", result.rows, "")
        );
      });
    });
  };


  information_office.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM information_office WHERE  id=${id};`
    let sql1=` DELETE FROM issuer WHERE  id=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"information_office Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'information_office  Update Successfly',result.rows,''))
    }
    )
    poolPublic.query(sql1,(error,result)=>{
      if(error) return reject(notifyMessage(false,"information_office Public Not Update Successfly",'',error))
      return resolve(notifyMessage(true,'information_office Public  Update Successfly',result.rows,''))
  }
  )
    
    })}



    module.exports=information_office