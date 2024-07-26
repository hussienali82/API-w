const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Hospitalmid= {}
Hospitalmid.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public.hospitalmid`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Hospitalmid Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Hospitalmid  Get Successfly',result.rows,''))

    })
})}

Hospitalmid.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * FROM public.hospitalmid where "transmit_id"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Hospitalmid Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Hospitalmid  Get Successfly',result.rows,''))

    })
})}



Hospitalmid.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."hospitalmid" SET 
        "hospital"='${(Body.hospital)}',
        "result"='${(Body.result)}'
        where "transmit_id" =${id}`


        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Hospitalmid was not read', '', err))
            return resolve(notifyMessage(true, "Hospitalmid updated successfully", result.rows, {}));
            
        });
    });
  };



  Hospitalmid.insert = (body,transmit_id) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
    
      let sql = `INSERT INTO public."hospitalmid" ( id,"hospital","result",transmit_id) VALUES (default, ${body.hospital}, ${body.result},${transmit_id})`


      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Hospitalmid Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Hospitalmid  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Hospitalmid.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblHospitalmid" WHERE "id"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Hospitalmid Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Hospitalmid  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Hospitalmid