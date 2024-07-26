const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')

const GRepInforMain= {}
GRepInforMain.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT * from public."TblInformation" left join public."TblRank" on public."TblInformation"."InfRnk" = public."TblRank"."rnkSeg" left join public."TblDir" on public."TblInformation"."InfDir" = public."TblDir"."dirSeg" left join public."TblCommit" on public."TblInformation"."InfTypComm" = public."TblCommit"."comSeg" ; `
   pool.query(sql,(error,result)=>{

    if(error) return reject(notifyMessage(false,"GRepInforMain Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'GRepInforMain  Get Successfly',result.rows,''))


    

})
})}
    GRepInforMain.byid=(id)=>{return new  Promise((resolve,reject)=>{
    
        let sql =`SELECT * from public."TblInformation" left join public."TblRank" on public."TblInformation"."InfRnk" = public."TblRank"."rnkSeg" left join public."TblDir" on public."TblInformation"."InfDir" = public."TblDir"."dirSeg" left join public."TblCommit" on public."TblInformation"."InfTypComm" = public."TblCommit"."comSeg" ;  where "InfSeg"=${id};`
       pool.query(sql,(error,result)=>{
    
            if(error) return reject(notifyMessage(false,"GRepInforMain Not Get Successfly",'',error))
            return resolve(notifyMessage(true,'GRepInforMain  Get Successfly',result.rows,''))
    
        })
    })}











module.exports= GRepInforMain