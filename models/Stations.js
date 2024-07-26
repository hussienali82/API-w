const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Stations= {}
Stations.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblStations"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Stations Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Stations  Get Successfly',result.rows,''))

    })
})}

Stations.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblStations" where "id"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Stations Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Stations  Get Successfly',result.rows,''))

    })
})}



Stations.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = ` UPDATE public."TblStations" SET 
        "departmentID"='${(Body.departmentID)}',
        "value"='${(Body.value)}'
      
        where "id" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Stations was not read', '', err))
            return resolve(notifyMessage(true, "Stations updated successfully", result.rows, {}));
            
        });
    });
  };



  Stations.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblStations" ("departmentID","value") VALUES ('${(body.departmentID)}','${(body.value)}');`;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Stations Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Stations  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Stations.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblStations" WHERE "id"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Stations Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Stations  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Stations