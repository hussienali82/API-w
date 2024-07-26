const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Commands= {}
Commands.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblCommands"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Commands Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Commands  Get Successfly',result.rows,''))

    })
})}

Commands.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblCommands" where "id"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Commands Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Commands  Get Successfly',result.rows,''))

    })
})}



Commands.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = ` UPDATE public."TblCommands" SET 
        "value"='${(Body.value)}',
        "governID"='${(Body.governID)}'
      
        where "id" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Commands was not read', '', err))
            return resolve(notifyMessage(true, "Commands updated successfully", result.rows, {}));
            
        });
    });
  };



  Commands.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblCommands" ("value","governID") VALUES ('${(body.value)}','${(body.governID)}');`;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Commands Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Commands  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Commands.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblCommands" WHERE "id"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Commands Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Commands  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Commands