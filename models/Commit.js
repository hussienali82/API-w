const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Commit= {}
Commit.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblCommit"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Commit Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Commit  Get Successfly',result.rows,''))

    })
})}

Commit.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblCommit" where "comSeg"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Commit Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Commit  Get Successfly',result.rows,''))

    })
})}



Commit.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = ` UPDATE public."TblCommit" SET 
        "comTyp"='${(Body.value)}'
      
        where "comSeg" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Commit was not read', '', err))
            return resolve(notifyMessage(true, "Commit updated successfully", result.rows, {}));
            
        });
    });
  };



  Commit.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblCommit" ("comTyp") VALUES ('${(body.value)}');`;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Commit Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Commit  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Commit.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblCommit" WHERE "comSeg"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Commit Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Commit  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Commit