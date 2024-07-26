const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Governs= {}
Governs.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblGoverns"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Governs Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Governs  Get Successfly',result.rows,''))

    })
})}

Governs.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblGoverns" where "id"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Governs Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Governs  Get Successfly',result.rows,''))

    })
})}



Governs.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."TblGoverns" SET 
        "value"='${(Body.value)}'
      
        where "id" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Governs was not read', '', err))
            return resolve(notifyMessage(true, "Governs updated successfully", result.rows, {}));
            
        });
    });
  };



  Governs.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblGoverns" ("value") VALUES ('${(body.value)}');`;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Governs Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Governs  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Governs.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblGoverns" WHERE "id"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Governs Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Governs  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Governs