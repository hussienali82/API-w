const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const Information= {}
Information.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * from public."TblInformation" left join public."TblRank" on public."TblInformation"."InfRnk" = public."TblRank"."rnkSeg" left join public."TblDir" on public."TblInformation"."InfDir" = public."TblDir"."dirSeg" left join public."TblCommit" on public."TblInformation"."InfTypComm" = public."TblCommit"."comSeg" ;`
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Information Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Information  Get Successfly',result.rows,''))

    })
})}

Information.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * from public."TblInformation" inner join public."TblRank" on public."TblInformation"."InfRnk" = public."TblRank"."rnkSeg" inner join public."TblDir" on public."TblInformation"."InfDir" = public."TblDir"."dirSeg"  where "InfSeg"=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"Information Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Information  Get Successfly',result.rows,''))

    })
})}



Information.update = (Body,id) => {
    return new Promise((resolve, reject) => {

        let sql = `UPDATE public."TblInformation" SET 
        "InfNo"='${(Body.InfNo)}',
       
        "InfDir"='${(Body.InfDir)}', 
        "InfPhone"='${(Body.InfPhone)}', 
        "InfId"='${(Body.InfId)}', 
        "InfYear"='${(Body.InfYear)}',
        "InfDateCome"='${(Body.InfDateCome)}', 
       
        "InfRnk"='${(Body.InfRnk)}', 
        "InfNam"='${(Body.InfNam)}', 
        "InfBokDate"='${(Body.InfBokDate)}',
     "InCreatedby"='${(Body.InCreatedby)}'
        where "InfSeg" =${id}`
        console.log("sql",sql)
        pool.query(sql, (err, result) => {
            if (err) return reject(notifyMessage(false, 'Information was not read', '', err))
            return resolve(notifyMessage(true, "Information updated successfully", result.rows, {}));
            
        });
    });
  };



  Information.insert = (body) => {
    return new Promise((resolve, reject) => {
      // solve problem
      console.log('body', body)
      let sql = `INSERT INTO public."TblInformation" ( "InfRnk","InfNam","InfDir" ,"InfPhone","InfId","InfYear","InfDateCome","InfNo","InfBokDate","InCreatedby") VALUES ( ${body.InfRnk}, '${body.InfNam}',${body.InfDir} ,'${body.InfPhone}','${body.InfId}','${body.InfYear}',default, '${body.InfNo}', '${body.InfBokDate}',${body.InCreatedby})`

      console.log("sql",sql);
      pool.query(sql, (error, result) => { 
        if (error)
          return reject(
            notifyMessage(false, "Information Not Insert Successfly", "", error)
          );
        return resolve(
          notifyMessage(true, "Information  Insert Successfly", result.rows, "")
        );
      });
    });
  };



  Information.delete=(id)=>{return new Promise((resolve,reject)=>{

    let sql=` DELETE FROM public."TblInformation" WHERE "InfSeg"=${id};`
    pool.query(sql,(error,result)=>{
        if(error) return reject(notifyMessage(false,"Information Not Update Successfly",'',error))
        return resolve(notifyMessage(true,'Information  Update Successfly',result.rows,''))
    }
    )
    
    })}


    module.exports= Information