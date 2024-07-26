const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Test= {}
Test.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblTest"`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Test Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Test  Get Successfly',result.rows,''))

    })
})}

Test.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public."TblTest" where "testSeg"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Test Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Test  Get Successfly',result.rows,''))

    })
})}



Test.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."TblTest" SET 
        "testName"='${(Body.value)}'
      
        where "testSeg" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Test was not read', '', err))
            return resolve(notifyMessage(true, "Test updated successfully", result.rows, {}));
            
        });
    });
  };



  Test.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblTest"(
        "testName")
        VALUES ( '${(body.value)}'); `;


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Test Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Test  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Test.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblTest" WHERE "testSeg"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Test Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Test  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Test