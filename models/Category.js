const {notifyMessage}=require ('../utils/notification')
const {pool,client, poolPublic}=require('../db/index')


const category= {}

category.all=()=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT 
    id, 
    cat
	FROM category
    order by id;`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"category Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'category  Get Successfly',result.rows,''))

    })
})}

category.byid=(id)=>{return new  Promise((resolve,reject)=>{

    let sql =`SELECT  
    cat  
    updated_by FROM category WHERE category.id=${id};`
   pool.query(sql,(error,result)=>{

        if(error) return reject(notifyMessage(false,"category Not Get Successfly",'',error))
        return resolve(notifyMessage(true,'category  Get Successfly',result.rows,''))

    })
})}

// category.update=(body)=>{return new Promise((resolve,reject)=>{

// let sql=`Update category set
// cat=N${body.cat}
// FROM category WHERE category.id=${id};`
// pool.query(sql,(error,result)=>{
//     if(error) return reject(notifyMessage(false,"category Not Update Successfly",'',error))
//     return resolve(notifyMessage(true,'category  Update Successfly',result.rows,''))
// }
// )

// })}


category.update = (Body,id) => {
  return new Promise((resolve, reject) => {
      let sql = `update category set 
                 cat='${Body.cat}'
                 where id=${id}`
                 console.log("sql",sql)

      let sql1 = `update category set 
                 cat='${Body.cat}'
                 where id=${id}`
                 console.log("sql1",sql1)

      pool.query(sql, (err, result) => {
          if (err) return reject(notifyMessage(false, 'category Public was not read', '', err))
          return resolve(notifyMessage(true, "category updated successfully", result.rows, {}));
          
      });
      poolPublic.query(sql1, (err, result) => {
        if (err) return reject(notifyMessage(false, 'category Public was not read', '', err))
        return resolve(notifyMessage(true, "category updated successfully", result.rows, {}));
        
    });
  });
};

    // category.insert = (body) => {
    //     return new Promise((resolve, reject) => {
    //       // solve problem
    //       let sql = `INSERT INTO category (cat) VALUES ('${body.cat}');`;
    //       console.log("sql",sql);
    //       pool.query(sql, (error, result) => {
    //         if (error)
    //           return reject(
    //             notifyMessage(false, "category Not Insert Successfly", "", error)
    //           );
    //         return resolve(
    //           notifyMessage(true, "category  Insert Successfly", result.rows, "")
    //         );
    //       });
    //     });
    //   };

    category.insert = (body) => {
      return new Promise((resolve, reject) => {
        // solve problem
        let sql = `INSERT INTO category (cat) VALUES ('${body.cat}');`;

        let sql1 = `INSERT INTO category (cat) VALUES ('${body.cat}');`;
        console.log("sql",sql);
        console.log("sql1",sql1);
        pool.query(sql, (error, result) => {
          if (error)
            return reject(
              notifyMessage(false, "category Not Insert Successfly", "", error)
            );
          return resolve(
            notifyMessage(true, "category  Insert Successfly", result.rows, "")
          );
        });
        poolPublic.query(sql1, (error, result) => {
          if (error)
            return reject(
              notifyMessage(false, "category public Not Insert Successfly", "", error)
            );
          return resolve(
            notifyMessage(true, "category public  Insert Successfly", result.rows, "")
          );
        });
      });
    };


    // category.delete=(id)=>{return new Promise((resolve,reject)=>{

    //     let sql=` DELETE FROM category
    //     WHERE  id=${id};`
    //     pool.query(sql,(error,result)=>{
    //         if(error) return reject(notifyMessage(false,"category Not Update Successfly",'',error))
    //         return resolve(notifyMessage(true,'category  Update Successfly',result.rows,''))
    //     }
    //     )
        
    //     })}

    category.delete=(id)=>{return new Promise((resolve,reject)=>{

      let sql=` DELETE FROM category WHERE  id=${id};`
      
      let sql1=` DELETE FROM category WHERE  id=${id};`
      console.log("sql",sql);
      console.log("sql1",sql1);
      pool.query(sql,(error,result)=>{
          if(error) return reject(notifyMessage(false,"category Not Delete Successfly",'',error))
          return resolve(notifyMessage(true,'category  delete Successfly',result.rows,''))
      }
      )

      poolPublic.query(sql1,(error,result)=>{
        if(error) return reject(notifyMessage(false,"category Not Delete Successfly",'',error))
        return resolve(notifyMessage(true,'category  delete Successfly',result.rows,''))
    }
    )
      
      })}

    module.exports=category