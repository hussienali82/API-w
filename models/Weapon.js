const { notifyMessage } = require("../utils/notification");
const { pool, client } = require("../db/index");

const weapon_name = {};

weapon_name.all = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT 
    id, 
    weapon_name,
    weapon_size 
	FROM weapon_name
  order by id;`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "weapon_name Not Get Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "weapon_name  Get Successfly", result.rows, "")
      );
    });
  });
};

weapon_name.byid = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT  
    weapon_name ,
    weapon_size   
    updated_by FROM weapon_name WHERE weapon_name.id=${id};`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "weapon_name Not Get Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "weapon_name  Get Successfly", result.row, "")
      );
    });
  });
};


weapon_name.update = (Body,id) => {
  return new Promise((resolve, reject) => {
      let sql = `update weapon_name set 
      weapon_name='${Body.weapon_name}',
      weapon_size='${Body.weapon_size}'
                 where id=${id}`
                 console.log("sql",sql)
      pool.query(sql, (err, result) => {
          if (err) return reject(notifyMessage(false, 'weapon_name was not read', '', err))
          return resolve(notifyMessage(true, "weapon_name updated successfully", result.rows, {}));
          
      });
  });
};


weapon_name.insert = (body) => {
  return new Promise((resolve, reject) => {
    // solve problem  
    let sql = `INSERT INTO weapon_name (weapon_name,weapon_size) VALUES ('${body.weapon_name}','${body.weapon_size}');`;
    console.log("sql",sql);
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "weapon_name Not Insert Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "weapon_name  Insert Successfly", result.rows, "")
      );
    });
  });
};

weapon_name.delete=(id)=>{return new Promise((resolve,reject)=>{

  let sql=` DELETE FROM weapon_name
  WHERE  id=${id};`
  pool.query(sql,(error,result)=>{
      if(error) return reject(notifyMessage(false,"weapon_name Not Update Successfly",'',error))
      return resolve(notifyMessage(true,'weapon_name  Update Successfly',result.rows,''))
  }
  )
  
  })}

module.exports = weapon_name;
