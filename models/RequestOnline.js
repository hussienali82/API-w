const { notifyMessage } = require("../utils/notification");
const { poolPublic, client } = require("../db/index");
const moment = require('moment-timezone')
const RequestOnline = {};

RequestOnline.all = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests.*,province.pro,category.cat
        FROM public.requests
        inner join province on requests.pro_id = province.id
        inner join category on requests.cat_id = category.id
        where downloaded=false
        `;
    poolPublic.query(sql, (error, result) => {
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

RequestOnline.insert = (body) => {
  return new Promise((resolve, reject) => {
    // solve problem
    let sql = `INSERT INTO public.requests (
      name1, 
      name2, 
      name3, 
      name4,
      surname, 
      profession, 
      birdate, 
      gen_id, 
      monam1, 
      monam2, 
      monam3, 
      idnum, 
      addresses, 
      phone, 
      note,
      downloaded ) 
      
      VALUES (
       '${body.name1}',
       '${body.name2}',
       '${body.name3}',
       '${body.name4}',
       '${body.surname}',
       default,
       '${moment(body.birdate).tz("Asia/Baghdad").format("YYYY-MM-DD")}',
        ${body.gen_id},
       '${body.monam1}',
       '${body.monam2}',
       '${body.monam3}',
       '${body.idnum}',
       '${body.addresses}',
       '${body.phone}',
        ${body.note ? "'" + body.note + "'" : 'default'},
        true
        );`;
    poolPublic.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(
            false,
            "Request Online Not Insert Successfly",
            "",
            error
          )
        );
      return resolve(
        notifyMessage(
          true,
          "Request Online  Insert Successfly",
          result.rows,
          ""
        )
      );
    });
  });
};

RequestOnline.update = (body, id) => {
  return new Promise((resolve, reject) => {
    let sql = `update public.requests set 

      name1='${body.name1}',
      name2='${body.name2}',
      name3='${body.name3}',
      name4='${body.name4}',
      surname='${body.surname}',
      profession='${body.profession}',
      birdate='${body.birdate}',
      gen_id=${body.gen_id},
      monam1='${body.monam1}',
      monam2='${body.monam2}',
      monam3='${body.monam3}',
      idnum='${body.idnum}',
      pro_id= ${body.pro_id},
      cat_id= ${body.cat_id},
      addresses='${body.addresses}',
      phone='${body.phone}',
      note='${body.note}'
     
      where id='${id}'`;

    console.log("sql", sql);

    poolPublic.query(sql, (err, result) => {
      if (err)
        return reject(
          notifyMessage(false, "Request Online was not read", "", err)
        );
      return resolve(
        notifyMessage(
          true,
          "Request Online updated successfully",
          result.rows,
          {}
        )
      );
    });
  });
};


RequestOnline.updateComplete = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `update public.requests set 
    downloaded=true,
    updated_at=default
      where id='${id}'`;

    console.log("sql", sql);

    poolPublic.query(sql, (err, result) => {
      if (err)
        return reject(
          notifyMessage(false, "Request Online was not read", "", err)
        );
      return resolve(
        notifyMessage(
          true,
          "Request Online updated successfully",
          result.rows,
          {}
        )
      );
    });
  });
};

RequestOnline.byNanoId = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests.*,province.pro,category.cat
    FROM public.requests
    inner join province on requests.pro_id = province.id
    inner join category on requests.cat_id = category.id
    where requests.downloaded=false and requests.nanoid='${id}' ;`;

    poolPublic.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "Requesst Not Get Successfly", "", error)
        );
      return resolve(notifyMessage(true, "Requesst  Get Successfly", result.rows, "")
      );
    });
  });
};

RequestOnline.byCreatedDate = (date,user) => {
  return new Promise((resolve, reject) => {
    let part = user.user_type === 3 ? 1 : user.validity = 4 ? 2 : null
    let sql = `SELECT requests_details.*,( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||
    requests_details.name4) as fullname,requests.downloaded,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro,
     license_type.license
     FROM requests_details
     inner join requests on requests_details.req_id = requests.id
     left join weapon_name on requests_details.weapname_id = weapon_name.id
     inner join province on requests_details.pro_id = province.id
     inner join category on requests_details.cat_id = category.id
     inner join license_type on requests_details.license_id = license_type.id
     where requests.downloaded = false and Date(requests_details.created_at)='${date}' and license_type.approving_party =${part} ;`;
    console.log("sql",sql);
    poolPublic.query(sql, (error, result) => {
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

RequestOnline.CountDay = (user) => {
  return new Promise((resolve, reject) => {
    let part = user.user_type === 3 ? 1 : user.validity = 4 ? 2 : null
    let sql = `select count (*) as req_count, DATE(created_at) as req_date from 
    (select requests.created_at from requests inner join requests_details on requests_details.req_id = requests.id 
      inner join license_type on license_type.id = requests_details.license_id where requests.downloaded = false and license_type.approving_party =${part}) req group by  DATE(created_at)
    order by DATE(created_at) ;`;
    console.log("sql",sql)
    poolPublic.query(sql, (error, result) => {
      if (error)
        return reject(notifyMessage(false, "Requesst Not Get Successfly", "", error));
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
module.exports = RequestOnline;
