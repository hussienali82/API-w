const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Transmit= {}
Transmit.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT *
FROM public."TblTransmit" t
LEFT JOIN public.hospitalmid hm ON t."trSeg" = hm.transmit_id
INNER JOIN public."TblTest" test ON test."testSeg" = hm.result
INNER JOIN public."TblHospital" h ON h."hosSeq" = hm.hospital
left JOIN public."TblCommit" c ON c."comSeg" = t."trTypComm"   `
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Transmit Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Transmit  Get Successfly',result.rows,''))

    })
})}

Transmit.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT *
FROM public."TblTransmit" t
LEFT JOIN public.hospitalmid hm ON t."trSeg" = hm.transmit_id
INNER JOIN public."TblTest" test ON test."testSeg" = hm.result
INNER JOIN public."TblHospital" h ON h."hosSeq" = hm.hospital
left JOIN public."TblCommit" c ON c."comSeg" = t."trTypComm"    where "trSeg"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Transmit Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Transmit  Get Successfly',result.rows,''))

    })
})}



Transmit.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."TblTransmit" SET 
        
      
      
       
       "trParcode"='${(Body.trParcode)}',
     
       "trTypComm"='${Body.trTypComm}',
        "trDateCom"='${(Body.trDateCom)}',

        "trConnct"='${(Body.trConnct)}'
        where "trSeg" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Transmit was not read', '', err))
            return resolve(notifyMessage(true, "Transmit updated successfully", result.rows, {}));
            
        });
    });
  };



  Transmit.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      // console.log('body', body)
      let sql = `INSERT INTO public."TblTransmit" ("trNo","trDate","trParcode","trTypComm","trDateCom","trConnct")  VALUES (default,default,'${body.trParcode}',${body.trTypComm},'${body.trDateCom}', '${body.trConnct}' )RETURNING "trSeg";`

      console.log("sql",sql);
      pool.query(sql, (error, result) => {
        if (error)
          return reject(
            notifyMessage(false, "Transmit Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Transmit  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Transmit.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblTransmit" WHERE "trSeg"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Transmit Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Transmit  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Transmit