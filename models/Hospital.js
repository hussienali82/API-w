const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Hospital= {}
Hospital.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblHospital"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Hospital Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Hospital  Get Successfly',result.rows,''))

    })
})}

Hospital.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblHospital" where "hosSeq"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Hospital Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Hospital  Get Successfly',result.rows,''))

    })
})}



Hospital.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."TblHospital" SET 
        "hosName"='${(Body.value)}'
      
        where "hosSeq" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Hospital was not read', '', err))
            return resolve(notifyMessage(true, "Hospital updated successfully", result.rows, {}));
            
        });
    });
  };



  Hospital.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblHospital" ("hosName") VALUES ('${(body.value)}');`;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Hospital Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Hospital  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Hospital.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblHospital" WHERE "hosSeq"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Hospital Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Hospital  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Hospital