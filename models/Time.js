const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Time= {}
Time.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblTime"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Time Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Time  Get Successfly',result.rows,''))

    })
})}

Time.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblTime" where "timSeq"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Time Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Time  Get Successfly',result.rows,''))

    })
})}



Time.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."TblTime" SET 
        "timTrans"='${(Body.value)}'
      
        where "timSeq" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Time was not read', '', err))
            return resolve(notifyMessage(true, "Time updated successfully", result.rows, {}));
            
        });
    });
  };



  Time.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblTime" ("timTrans") VALUES ('${body.value}')`;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Time Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Time  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Time.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblTime" WHERE "timSeq"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Time Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Time  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Time