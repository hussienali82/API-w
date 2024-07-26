const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Dir= {}
Dir.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblDir"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Dir Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Dir  Get Successfly',result.rows,''))

    })
})}

Dir.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblDir" where "dirSeg"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Dir Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Dir  Get Successfly',result.rows,''))

    })
})}



Dir.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."TblDir" SET 
        "dirTyp"='${(Body.value)}'
      
        where "dirSeg" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Dir was not read', '', err))
            return resolve(notifyMessage(true, "Dir updated successfully", result.rows, {}));
            
        });
    });
  };



  Dir.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblDir" ("dirTyp") VALUES ('${(body.value)}');`;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Dir Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Dir  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Dir.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblDir" WHERE "dirSeg"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Dir Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Dir  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Dir