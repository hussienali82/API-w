const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Rank= {}
Rank.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblRank"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Rank Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Rank  Get Successfly',result.rows,''))

    })
})}

Rank.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblRank" where "rnkSeg"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Rank Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Rank  Get Successfly',result.rows,''))

    })
})}



Rank.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."TblRank" SET 
        "rnkRank"='${(Body.value)}'
      
        where "rnkSeg" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Rank was not read', '', err))
            return resolve(notifyMessage(true, "Rank updated successfully", result.rows, {}));
            
        });
    });
  };



  Rank.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblRank" ("rnkRank") VALUES ('${body.value}')`;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Rank Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Rank  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Rank.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblRank" WHERE "rnkSeg"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Rank Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Rank  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Rank