const {notifyMessage}=require ('../utils/notification')
const {pool,client}=require('../db/index')
const {poolPublic}= require('../db/index')

const Dashpoard= {}

Dashpoard.countOffline=()=>{return new  Promise((resolve,reject)=>{

    let sql =` select offlinecount,onlinCount,count_completed,notcount_completed,handale_process,nothandale_process,isnot_print,is_print,isnot_receive,is_receive,isnot_quality,is_quality from( SELECT count(*) as offlinecount FROM public.requests_details)  offlinecount,
    (SELECT count(*) as onlinCount FROM public.requests_details) onlinCount,
    (SELECT count (*) as count_completed FROM public.requests_details where  completed=1)   count_completed,
    (SELECT count (*)as notcount_completed  FROM public.requests_details  where 	 completed=0)  notcount_completed,
    (    SELECT count (*) as handale_process FROM public.requests where 	 approv_num  is  NULL and approv_date  is  NULL 
    ) handale_process,
    (    SELECT count (*) as nothandale_process  FROM public.requests where 	 approv_num  is not NULL and approv_date  is not NULL 
    ) nothandale_process,
	(    SELECT count (*) as isnot_print  FROM public.identification where 	 is_print  = 0) isnot_print,
	(    SELECT count (*) as is_print  FROM public.identification where 	 is_print  = 1) is_print,
	(    SELECT count (*) as isnot_receive  FROM public.identification where 	 is_receive  ='0' and is_print  = 1 ) isnot_receive,
	(    SELECT count (*) as is_receive  FROM public.identification where 	 is_receive  = '1' and is_print  = 1) is_receive,
	(    SELECT count (*) as isnot_quality  FROM public.identification where 	 quality  = '0' and is_print  = 1) isnot_quality,
	(    SELECT count (*) as is_quality  FROM public.identification where 	 quality = '1' and is_print  = 1) is_quality
    `
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"countOffline Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'countOffline  Get Successfly',result.rows,''))

    })
})}
// Dashpoard.countOnline=()=>{return new  Promise((resolve,reject)=>{

//     let sql =`SELECT count(*) as onlinCount FROM requests_details;`
//     poolPublic.query(sql,(error,result)=>{

//         if(error) return reject(notifyMessage(false,"onlinCount Not Get Successfly",'',error))
//         return resolve(notifyMessage(true,'onlinCount  Get Successfly',result.rows,''))

//     })
// })}
// Dashpoard.countPrint=(id)=>{return new  Promise((resolve,reject)=>{

//     let sql =`SELECT count (*) as printcount FROM identification where is_print=true
// 	`
//    pool.query(sql,(error,result)=>{

//         if(error) return reject(notifyMessage(false,"printcount Not Get Successfly",'',error))
//         return resolve(notifyMessage(true,'printcount  Get Successfly',result.rows,''))

//     })
// })}
// Dashpoard.completed=(id)=>{return new  Promise((resolve,reject)=>{

//     let sql =`SELECT count (*) as count_completed FROM requests_details where 	 completed=1
// 	`
//    pool.query(sql,(error,result)=>{

//         if(error) return reject(notifyMessage(false,"count_completed Not Get Successfly",'',error))
//         return resolve(notifyMessage(true,'count_completed  Get Successfly',result.rows,''))

//     })
// })}
// Dashpoard.notcompleted=(id)=>{return new  Promise((resolve,reject)=>{

//     let sql =`SELECT count (*) as notcount_completed FROM requests_details  where 	 completed=0
// 	`
//    pool.query(sql,(error,result)=>{

//         if(error) return reject(notifyMessage(false,"notcount_completed Not Get Successfly",'',error))
//         return resolve(notifyMessage(true,'notcount_completed  Get Successfly',result.rows,''))

//     })
// })}

// Dashpoard.handleProcess=(id)=>{return new  Promise((resolve,reject)=>{

//     let sql =`
//     SELECT count (*) as handale_process FROM requests_details where 	 approval_num  is  NULL and approval_date  is  NULL 
// 	`
//    pool.query(sql,(error,result)=>{

//         if(error) return reject(notifyMessage(false,"handale_process Not Get Successfly",'',error))
//         return resolve(notifyMessage(true,'handale_process  Get Successfly',result.rows,''))

//     })
// })}
// Dashpoard.notHandleProcess=(id)=>{return new  Promise((resolve,reject)=>{

//     let sql =`
//     SELECT count (*) as nothandale_process FROM requests_details where 	 approval_num  is not NULL and approval_date  is not NULL 
// 	`
//    pool.query(sql,(error,result)=>{

//         if(error) return reject(notifyMessage(false,"notHandale_process Not Get Successfly",'',error))
//         return resolve(notifyMessage(true,'notHandale_process  Get Successfly',result.rows,''))

//     })
// })}




 


 

    module.exports=Dashpoard