const { notifyMessage } = require("../utils/notification");
const { pool, client } = require("../db/index");
const moment = require('moment-timezone')

const Requesst = {};

Requesst.all = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT 
        id, 
        name1, 
        name2, 
        name3, 
        name4, 
        surname, 
        profession,
         birdate, 
         gender_type, 
         cat_id, 
         monam1, 
         monam2, 
         monam3, 
         idnum, 
         pro_id, 
         addresses, 
         phone, 
         note, 
         approv_num,
         approv_date,
         created_at, 
         created_by, 
         updated_at, 
         updated_by
        FROM requests;`
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "Requesstence Not Get Successfly", '', error))
      return resolve(notifyMessage(true, 'Requesstence  Get Successfly', result.rows, ''))

    })
  })
}

// with code
Requesst.all2 = () => {
  return new Promise((resolve, reject) => {

    let sql = `SELECT 
        requests.id, 
        name1, 
        name2, 
        name3, 
        name4, 
        surname, 
        profession,
         birdate, 
         gender_type, 
         category.cat as cat_id, 
         monam1, 
         monam2, 
         monam3, 
         idnum, 
         province.pro_name as pro_id, 
         addresses, 
         phone, 
         note, 
         created_at, 
         created_by, 
         updated_at, 
         updated_by
        FROM requests
        inner join province on pro_id = province.id
        join  category on cat_id = category.id`
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "Requesstence Not Get Successfly", '', error))
      return resolve(notifyMessage(true, 'Requesstence  Get Successfly', result.rows, ''))

    })
  })
}

Requesst.byid = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests.*,category.cat, province.pro_name FROM requests
    inner join category on requests.cat_id = category.id
    inner join province on requests.pro_id = province.id
    WHERE requests.id='${id}';`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Get Successfly", "", error)
        );
      return resolve(notifyMessage(true, "Requesstence  Get Successfly", result.rows, "")
      );
    });
  });
};

Requesst.byApprove = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests.*,category.cat, province.pro_name FROM requests
    inner join category on requests.cat_id = category.id
    inner join province on requests.pro_id = province.id WHERE requests.approv_num IS NOT NULL;`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Get Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "Requesstence  Get Successfly", result.rows, "")
      );
    });
  });
};

Requesst.byApproveWithID = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests.*,category.cat, province.pro_name FROM requests
    inner join category on requests.cat_id = category.id
    inner join province on requests.pro_id = province.id WHERE requests.approv_num IS NOT NULL and requests.id='${id}';`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Get Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "Requesstence  Get Successfly", result.rows, "")
      );
    });
  });
};

Requesst.byNotApprove = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests.*,category.cat, province.pro_name FROM requests
    inner join category on requests.cat_id = category.id
    inner join province on requests.pro_id = province.id WHERE requests.approv_num IS NULL;`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Get Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "Requesstence  Get Successfly", result.rows, "")
      );
    });
  });
};

Requesst.byApproveDays = (user) => {
  return new Promise((resolve, reject) => {
    let part = user.user_type === 3 ? 1 : user.validity = 4 ? 2 : null
    let sql = `
    select count (*) as req_count, DATE(created_at) as req_date from 
    (select requests.created_at from requests inner join requests_details on requests_details.req_id = requests.id 
      inner join license_type on license_type.id = requests_details.license_id where requests.approv_num IS NOT NULL and license_type.approving_party =${part}) req group by  DATE(created_at)
    order by DATE(created_at);`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Get Successfly", "", error)
        );
      console.log("result", result.rows)
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          detail = {
            ...detail,
            req_date: detail.req_date && moment(detail.req_date).tz("Asia/Baghdad").format("YYYY-MM-DD"),
          };
          details.push(detail);
        });
      }
      return resolve(notifyMessage(true, "requests_details  Get Successfly", details, ""));
    });
  });
};

Requesst.byCreatedApprovDate = (date,user) => {
  return new Promise((resolve, reject) => {
    let part = user.user_type === 3 ? 1 : user.validity = 4 ? 2 : null
    let sql = `SELECT requests_details.*,( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||
    requests_details.name4) as fullname,requests.approv_num,requests.approv_date,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
     license_type.license
     FROM requests_details
     inner join requests on requests_details.req_id = requests.id
     left join weapon_name on requests_details.weapname_id = weapon_name.id
     inner join province on requests_details.pro_id = province.id
     inner join category on requests_details.cat_id = category.id
     inner join license_type on requests_details.license_id = license_type.id
     where requests.approv_num IS NOT NULL and Date(requests_details.created_at)='${date}' and license_type.approving_party =${part} ;`;

    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesst Not Get Successfly", "", error)
        );
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          detail = {
            ...detail,
            birdate: detail.birdate && moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
            issdat1: detail.issdat1 && moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD")
          };
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", details, "")
      );
    });
  });
};


Requesst.byNotApproveDays = (user) => {
  return new Promise((resolve, reject) => {
    let part = user.user_type === 3 ? 1 : user.validity = 4 ? 2 : null
    let sql = `
    select count (*) as req_count, DATE(created_at) as req_date from 
    (select requests.created_at from requests inner join requests_details on requests_details.req_id = requests.id 
      inner join license_type on license_type.id = requests_details.license_id where requests.approv_num IS NULL and license_type.approving_party =${part}) req group by  DATE(created_at)
    order by DATE(created_at);`;
 
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Get Successfly", "", error)
        );
      console.log("result", result.rows)
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          detail = {
            ...detail,
            req_date: detail.req_date && moment(detail.req_date).tz("Asia/Baghdad").format("YYYY-MM-DD"),
          };
          details.push(detail);
        });
      }
      return resolve(notifyMessage(true, "requests_details  Get Successfly", details, ""));
    });
  });
};

Requesst.byCreatedDate = (date,user) => {
  return new Promise((resolve, reject) => {
    let part = user.user_type === 3 ? 1 : user.validity = 4 ? 2 : null
    let sql = `SELECT requests_details.*,( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||
    requests_details.name4) as fullname,requests.approv_num,requests.approv_date,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
     license_type.license
     FROM requests_details
     inner join requests on requests_details.req_id = requests.id
     left join weapon_name on requests_details.weapname_id = weapon_name.id
     inner join province on requests_details.pro_id = province.id
     inner join category on requests_details.cat_id = category.id
     inner join license_type on requests_details.license_id = license_type.id
     where requests.approv_num IS NULL and Date(requests_details.created_at)='${date}' and license_type.approving_party =${part}  ;`;

    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesst Not Get Successfly", "", error)
        );
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          detail = {
            ...detail,
            birdate: detail.birdate && moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
            issdat1: detail.issdat1 && moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD")
          };
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", details, "")
      );
    });
  });
};


Requesst.update = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests set
        name1=N${body.name1},
        name2=N${body.name2},
        name3=N${body.name3},
        name4=N${body.name4},
        surname=N${body.surname},
        profession=N${body.profession},
        birdate=N${body.birdate},
        gender_type=N${body.gender_type},
        cat_id=N${body.cat_id},
        monam1=N${body.monam1},
        monam2=N${body.monam2},
        monam3=N${body.monam3},
        idnum=N${body.idnum},
        pro_id=N${body.pro_id},
        addresses=N${body.addresses},
        phone=N${body.phone},
        note=N${body.note},
        created_at=N${body.created_at},
        created_by=N${body.created_by},
        updated_at=N${body.updated_at},
        updated_by=N${body.updated_by}`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Update Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "Requesstence  Update Successfly", result.rows, "")
      );
    });
  });
};

Requesst.updateMinister = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests set
        approv_num='${body.approv_num}',
        approv_date='${body.approv_date}',
        updated_at=default 
        where requests.id = '${body.req_id}'`;
    // console.log("sql",sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Update Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "Requesstence  Update Successfly", result.rows, "")
      );
    });
  });
};
Requesst.updatepartMinister = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests set
        approv_num='${body.approv_num}',
        approv_date='${body.approv_date}',
        updated_at=default,
        updated_by = ${body.updated_by}
        where requests.id = '${body.req_id}'`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Update Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "Requesstence  Update Successfly", result.rows, "")
      );
    });
  });
};
Requesst.Ministerdelete = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests set
        approv_num='${body.approv_num}',
        updated_at=default,
        updated_by = ${body.updated_by}
        where requests.id = '${body.req_id}'`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Update Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "Requesstence  Update Successfly", result.rows, "")
      );
    });
  });
};


Requesst.insert = (body) => {
  return new Promise((resolve, reject) => {
    // let sqls = `INSERT INTO             
    //         VALUES (
    //          '${body.name1}',
    //          '${body.name2}',
    //          '${body.name3}',
    //          '${body.name4}',
    //          '${body.surname}',
    //          '${body.profession}',
    //          '${body.birdate}',
    //           ${body.gen_id},
    //          '${body.monam1}',
    //          '${body.monam2}',
    //          '${body.monam3}',
    //          '${body.idnum}',
    //          '${body.addresses}',
    //          '${body.phone}',
    //          '${body.note}',
    //           true

    //           );`;
    let sql = `INSERT INTO requests VALUES (
            
        '${body.req_id}',
        '${body.name1}',
        '${body.name2}',
        '${body.name3}',
        '${body.name4}',
        '${body.surname}',
        default,
        '${body.birdate}',
         ${body.gen_id},
         ${body.cat_id},
        '${body.monam1}',
        '${body.monam2}',
        '${body.monam3}',
        '${body.idnum}',
        ${body.pro_id},
        '${body.addresses}',
        '${body.phone}',
        '${body.note}',
        '${body.created_at}',
        ${body.created_by},
        default,
        default,
        default,
        default
            ) ;`;
    pool.query(sql, (error, result) => {
      console.log('sql', sql);
      if (error)
        return reject(
          notifyMessage(false, "Requesstence Not Insert Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "Requesstence  Insert Successfly", result.rows, "")
      );
    });
  });
};


module.exports = Requesst;
