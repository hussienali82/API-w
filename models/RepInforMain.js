const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const RepInforMain= {}
RepInforMain.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT *   FROM 
    "TblTransmit"  t

	left join public.hospitalmid hm on t."trSeg"=hm.transmit_id
		 	 inner join public."TblCommit" com  on t."trTypComm"= com."comSeg"

     inner join public."TblTest" test on test."testSeg"=hm.result 
     inner join public."TblHospital" h on h."hosSeq"=hm.hospital 

	 left join public."TblInformation" i on i."InfSeg"= t."trConnct"
     inner join public."TblDir" dir  on i."InfDir"= dir."dirSeg"

     inner join public."TblRank" rank  on i."InfRnk"= rank."rnkSeg"
      right join public."users" users  on i."InCreatedby"= users."id" `
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"RepInforMain Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'RepInforMain  Get Successfly',result.rows,''))


    

})
})}
    RepInforMain.byid=(id)=>{return new  Promise((resolve,reject)=>{
    
        let sql =`SELECT *   FROM 
    "TblTransmit"  t

	left join public.hospitalmid hm on t."trSeg"=hm.transmit_id
		 	 inner join public."TblCommit" com  on t."trTypComm"= com."comSeg"

     inner join public."TblTest" test on test."testSeg"=hm.result 
     inner join public."TblHospital" h on h."hosSeq"=hm.hospital 

	 left join public."TblInformation" i on i."InfSeg"= t."trConnct"
     inner join public."TblDir" dir  on i."InfDir"= dir."dirSeg"

     inner join public."TblRank" rank  on i."InfRnk"= rank."rnkSeg"
      right join public."users" users  on i."InCreatedby"= users."id"  where "InfSeg"=${id};`
       console.log('sql_info',sql);
         pool.query(sql,(error,result)=>{
    
            if(error) return reject(notifyMessage(false,"RepInforMain Not Get Successfly",'',error))
            return resolve(notifyMessage(true,'RepInforMain  Get Successfly',result.rows,''))
    
        })
    })}











module.exports= RepInforMain