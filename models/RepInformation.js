const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const RepInformation= {}
RepInformation.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * from public."TblInformation" inner join public."TblRank" on public."TblInformation"."InfRnk" = public."TblRank"."rnkSeg" left join public."TblDir" on public."TblInformation"."InfDir" = public."TblDir"."dirSeg" left join public."TblCommit" on public."TblInformation"."InfTypComm" = public."TblCommit"."comSeg" ; `
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"Information Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'Information  Get Successfly',result.rows,''))

    })
})}

module.exports= RepInformation