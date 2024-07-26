const { notifyMessage } = require("../utils/notification");
const { pool, poolPublic, client } = require("../db/index");
const moment = require("moment-timezone");

const requests_details = {};

requests_details.all = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.*,
    ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname,
    weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
    license_type.license,requests.approv_num,requests.approv_date
    FROM requests_details
    inner join requests on requests_details.req_id = requests.id
    left join weapon_name on requests_details.weapname_id = weapon_name.id
    inner join province on requests_details.pro_id = province.id
    inner join category on requests_details.cat_id = category.id
    inner join license_type on requests_details.license_id = license_type.id `;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(
            false,
            "Approval_destination Not Get Successfly",
            "",
            error
          )
        );
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          // if (detail.created_at) {
          detail = {
            ...detail,
            birdate: detail.birdate ? moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat1: detail.issdat1 ? moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat2: detail.issdat2 ? moment(detail.issdat2)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            datedet: detail.datedet ? moment(detail.datedet)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
          };
          // }
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "Approval_destination  Get Successfly", details, "")
      );
    });
  });
};


requests_details.approval = () => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.*,( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
    license_type.license,requests.approv_num,requests.approv_date, information_office.name as iss_2_name,biometric.pict, biometric.iris, biometric.fing_dat, biometric.fing_xml
    FROM requests_details
    inner join requests on requests_details.req_id = requests.id
    left join weapon_name on requests_details.weapname_id = weapon_name.id
    inner join province on requests_details.pro_id = province.id
    inner join category on requests_details.cat_id = category.id
    inner join license_type on requests_details.license_id = license_type.id
	  inner join information_office on requests_details.iss_2 = information_office.id
	  left join biometric on requests_details.biometric_id = biometric.id
    where  requests.approv_num IS NOT NULL
  and (requests_details.completed > 1 or requests_details.completed is null)
`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(
            false,
            "Approval_destination Not Get Successfly",
            "",
            error
          )
        );
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          // if (detail.created_at) {
          detail = {
            ...detail,
            birdate: detail.birdate ? moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat1: detail.issdat1 ? moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat2: detail.issdat2 ? moment(detail.issdat2)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            datedet: detail.datedet ? moment(detail.datedet)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
          };
          // }
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "Approval_destination  Get Successfly", details, "")
      );
    });
  });
};

requests_details.name = (name) => {
  return new Promise((resolve, reject) => {
    let sql = `select * from  (SELECT requests_details.*, ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname ,
    (requests_details.monam1 || ' ' || 
    requests_details.monam2 || ' ' || 
    requests_details.monam3)as fullmonam,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
    license_type.license,requests.approv_num,requests.approv_date
    FROM public.requests_details
    inner join public.requests on requests_details.req_id = requests.id
    left join public.weapon_name on requests_details.weapname_id = weapon_name.id
    inner join public.province on requests_details.pro_id = province.id
    inner join public.category on requests_details.cat_id = category.id
    inner join public.license_type on requests_details.license_id = license_type.id   
) as f
    
    where fullname like '%${name}%' and approv_num IS NOT NULL and approv_date IS NOT NULL 
      and ((completed <> 0 and completed <> 1) or completed is null  )   and is_entry =1
    `;

    console.log('sql_in_requestdetails', sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", result.rows, "")
      );
    });
  });
};
requests_details.name_finance = (name) => {
  return new Promise((resolve, reject) => {
    let sql = `select * from  (SELECT requests_details.*, ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname ,
    (requests_details.monam1 || ' ' || 
    requests_details.monam2 || ' ' || 
    requests_details.monam3)as fullmonam,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
    license_type.license,requests.approv_num,requests.approv_date , 
    identification.id as id_identification, 
    
    identification.printtime, 
    identification.expdate, 
    identification.permdate, 
    identification.note, 
    identification.created_at as creat_identification
    , identification.created_by as creatby_identification,
     identification.updated_at as update_identification,
      identification.updated_by as update_by_identification ,
       identification.is_print,
        identification.qr_code,
         identification.quality,
         identification.accountant,
          identification.is_receive
    FROM public.requests_details
    left join public.identification on requests_details.id = identification.req_det_id
    inner join public.requests on requests_details.req_id = requests.id
    left join public.weapon_name on requests_details.weapname_id = weapon_name.id
    inner join public.province on requests_details.pro_id = province.id
    inner join public.category on requests_details.cat_id = category.id
    inner join public.license_type on requests_details.license_id = license_type.id   
) as f
    
    where fullname like '%${name}%'  and approv_num  is not NULL and approv_date  is not NULL 
      and   is_entry=1
    `;

    // console.log('sql_in_requestdetails', sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", result.rows, "")
      );
    });
  });
};
  requests_details.name_delivery = (name) => {
  return new Promise((resolve, reject) => {
    let sql =
   `  select * from  (SELECT requests_details.*, ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname
      , (requests_details.monam1 || ' ' || 
      requests_details.monam2 || ' ' || 
      requests_details.monam3)as fullmonam,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
      license_type.license,requests.approv_num,requests.approv_date , 
      identification.id as id_identification, 
      identification.is_receive,
      identification.quality AS quality_id,
      identification.quality_note,
      identification.printtime, 
      identification.expdate, 
      identification.permdate,
      identification.idnum as idnumcard, 
      identification.note, 
      identification.created_at as creat_identification
      , identification.created_by as creatby_identification,
       identification.updated_at as update_identification,
        identification.updated_by as update_by_identification ,
         identification.is_print as is_print,
          identification.qr_code,
           identification.quality,
           identification.accountant,         
           identification.flg,
           identification.img_print
           
      FROM public.requests_details
      left join public.identification on requests_details.id = identification.req_det_id
      inner join public.requests on requests_details.req_id = requests.id
      left join public.weapon_name on requests_details.weapname_id = weapon_name.id
      inner join public.province on requests_details.pro_id = province.id
      inner join public.category on requests_details.cat_id = category.id
      inner join public.license_type on requests_details.license_id = license_type.id   
      ) as f
      where (fullname like '%${name}%' or idnumcard = '${name}')
      and is_print = 1 
      and (quality_id is null )
      and (is_receive <> cast(1 as bit ))
      `;

    // console.log('sql_in_requestdetails', sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", result.rows, "")
      );
    });
  });
};
requests_details.idnume_delivery = (idnum) => {
  return new Promise((resolve, reject) => {
    let sql =  ` 
    select * from  (SELECT requests_details.*, ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname
    , (requests_details.monam1 || ' ' || 
    requests_details.monam2 || ' ' || 
    requests_details.monam3)as fullmonam,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
    license_type.license,requests.approv_num,requests.approv_date , 
    identification.id as id_identification, 
    identification.is_receive,
    identification.quality AS quality_id,
    identification.quality_note,
    identification.printtime, 
    identification.expdate, 
    identification.permdate,
    identification.idnum as idnumcard, 
    identification.note, 
    identification.created_at as creat_identification
    , identification.created_by as creatby_identification,
     identification.updated_at as update_identification,
      identification.updated_by as update_by_identification ,
       identification.is_print as is_print,
        identification.qr_code,
         identification.quality,
         identification.accountant,         
         identification.flg,
         identification.img_print
         
    FROM public.requests_details
    left join public.identification on requests_details.id = identification.req_det_id
    inner join public.requests on requests_details.req_id = requests.id
    left join public.weapon_name on requests_details.weapname_id = weapon_name.id
    inner join public.province on requests_details.pro_id = province.id
    inner join public.category on requests_details.cat_id = category.id
    inner join public.license_type on requests_details.license_id = license_type.id   
    ) as f
    where (fullname like '%${idnum}%' or idnumcard = '${idnum}')
    and is_print = 1 
    and (quality_id = cast(1 as bit ) )
    and (is_receive <> cast(1 as bit )) `;

    // console.log('sql_in_requestdetails', sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", result.rows, "")
      );
    });
  });
};
requests_details.print = () => {
  return new Promise((resolve, reject) => {
    let sql = `select * from  (SELECT requests_details.*, 
      ( requests_details.name1 || ' ' 
      ||requests_details.name2 || ' ' 
      ||requests_details.name3|| ' ' 
      ||requests_details.name4) as fullname ,
    (requests_details.monam1 || ' ' || 
    requests_details.monam2 || ' ' || 
    requests_details.monam3)as fullmonam,
   ( weapon_name.weapon_name || ' ' || requests_details.weapnum) as weapon_name_num
    ,weapon_name.weapon_size
    ,category.cat,
    province.pro_name,
    license_type.license,
    requests.approv_num,
    requests.approv_date,
	biometric.pict,
	identification.id as id_identification, 
        identification.req_det_id,
        identification.printtime, 
        identification.expdate, 
        identification.permdate, 
        identification.note, 
        identification.created_at as creat_identification
				,identification.created_by as creatby_identification,
         identification.updated_at as update_identification,
          identification.updated_by as update_by_identification ,
          identification.is_print,
          identification.qr_code,
          identification.quality,
          identification.accountant,
          identification.idnum,
          identification.is_receive,
          identification.quality_note, 
          identification.flg,
          identification.img_print
    FROM public.requests_details
	inner join biometric on biometric.id = requests_details.biometric_id
	left join public.identification on requests_details.id = identification.req_det_id
    inner join public.requests on requests_details.req_id = requests.id
    left join public.weapon_name on requests_details.weapname_id = weapon_name.id
    inner join public.province on requests_details.pro_id = province.id
    inner join public.category on requests_details.cat_id = category.id
    inner join public.license_type on requests_details.license_id = license_type.id   
) as f
where  completed = 1  and (is_print = 2 or is_print = 3 or is_print is null)`;

    // console.log('sql_in_requestdetails', sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "print records   Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "print records  Get Successfly", result.rows, "")
      );
    });
  });
};


requests_details.quality = () => {
  return new Promise((resolve, reject) => {
    let sql = `select * from  (SELECT requests_details.*, 
      ( requests_details.name1 || ' ' 
      ||requests_details.name2 || ' ' 
      ||requests_details.name3|| ' ' 
      ||requests_details.name4) as fullname ,
    (requests_details.monam1 || ' ' || 
    requests_details.monam2 || ' ' || 
    requests_details.monam3)as fullmonam,
    weapon_name.weapon_name
    ,weapon_name.weapon_size
    ,category.cat,
    province.pro_name,
    license_type.license,
    requests.approv_num,
    requests.approv_date,
				identification.id as id_identification, 
        identification.req_det_id,
        identification.printtime, 
        identification.expdate, 
        identification.permdate, 
        identification.note, 
        identification.created_at as creat_identification
				, identification.created_by as creatby_identification,
         identification.updated_at as update_identification,
          identification.updated_by as update_by_identification ,
           identification.is_print,
            identification.qr_code,
             identification.quality,
             identification.accountant,
              identification.is_receive,
              identification.quality_note, 
              identification.flg,
              identification.img_print

    FROM public.requests_details
			left join public.identification on requests_details.id = identification.req_det_id
    inner join public.requests on requests_details.req_id = requests.id
    left join public.weapon_name on requests_details.weapname_id = weapon_name.id
    inner join public.province on requests_details.pro_id = province.id
    inner join public.category on requests_details.cat_id = category.id
    inner join public.license_type on requests_details.license_id = license_type.id   
) as f
    
    where  completed = 1   and (quality <> cast(1 as bit ) or quality is null) and  (is_print = 1)`;

    // console.log('sql_in_requestdetails', sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "print records   Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "print records  Get Successfly", result.rows, "")
      );
    });
  });
};
requests_details.nametracking = (nametracking) => {
  return new Promise((resolve, reject) => {
    let sql = 
  `select * from  (SELECT requests_details.*, ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname ,
    weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
    license_type.license,requests.approv_num,requests.approv_date,identification.is_print,identification.quality,
    identification.is_receive
    FROM public.requests_details
    
    inner join public.requests on requests_details.req_id = requests.id
    left join public.weapon_name on requests_details.weapname_id = weapon_name.id
    left join public.identification on requests_details.id = identification.req_det_id
    inner join public.province on requests_details.pro_id = province.id
    inner join public.category on requests_details.cat_id = category.id
    inner join public.license_type on requests_details.license_id = license_type.id   
    )  as f
    
    where fullname like '%${nametracking}%' and  (is_receive <> CAST(1 as bit) or is_receive is null) 
    ORDER by updated_at DESC 
    `
      ;

    // console.log('sql_in_requestdetails', sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", result.rows, "")
      );
    });
  });
};
requests_details.tracking = (tracking) => {
  return new Promise((resolve, reject) => {
    let sql = 
 `select * from  (SELECT requests_details.*, ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname ,
   weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
   license_type.license,identification.req_det_id
   FROM public.requests_details
   left join public.weapon_name on requests_details.weapname_id = weapon_name.id
   inner join public.province on requests_details.pro_id = province.id
   left join public.identification on requests_details.id = identification.req_det_id
   inner join public.category on requests_details.cat_id = category.id
   inner join public.license_type on requests_details.license_id = license_type.id   
   ) as f
       
    
    where fullname like '%${tracking}%'  `
      ;

    // console.log('sql_in_requestdetails', sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", result.rows, "")
      );
    });
  });
};
requests_details.complet = (complet_id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.*,( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
    license_type.license,requests.approv_num,requests.approv_date
    FROM requests_details
    inner join requests on requests_details.req_id = requests.id
    left join weapon_name on requests_details.weapname_id = weapon_name.id
    inner join province on requests_details.pro_id = province.id
    inner join category on requests_details.cat_id = category.id
    inner join license_type on requests_details.license_id = license_type.id
    where requests_details.completed=${complet_id}
    `;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );

      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", result.rows, "")
      );
    });
  });
};

requests_details.byReqID = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.*,( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname,weapon_name.weapon_name,weapon_name.weapon_size,category.cat,province.pro_name,
    license_type.license,requests.approv_num,requests.approv_date
    FROM requests_details
    inner join requests on requests_details.req_id = requests.id
    left join weapon_name on requests_details.weapname_id = weapon_name.id
    inner join province on requests_details.pro_id = province.id
    inner join category on requests_details.cat_id = category.id
    inner join license_type on requests_details.license_id = license_type.id
       WHERE requests_details.req_id='${id}';`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          // if (detail.created_at) {
          detail = {
            ...detail,
            birdate: detail.birdate ? moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat1: detail.issdat1 ? moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat2: detail.issdat2 ? moment(detail.issdat2)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            datedet: detail.datedet ? moment(detail.datedet)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
          };
          // }
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", details, "")
      );
    });
  });
};

requests_details.byid = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.*,
    ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname,
     license_type.license,category.cat, province.pro_name , 
    weapon_name.weapon_name,weapon_name.weapon_size,biometric.pict, biometric.iris, biometric.fing_dat, biometric.fing_xml, biometric.note as bio_note
    FROM requests_details 
    inner join license_type on requests_details.license_id = license_type.id
    inner join category on requests_details.cat_id = category.id
    left join weapon_name on requests_details.weapname_id = weapon_name.id
    inner join province on requests_details.pro_id = province.id
    left join biometric on requests_details.biometric_id = biometric.id
       WHERE requests_details.id='${id}';`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          // if (detail.created_at) {
          detail = {
            ...detail,
            birdate: detail.birdate ? moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat1: detail.issdat1 ? moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat2: detail.issdat2 ? moment(detail.issdat2)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            datedet: detail.datedet ? moment(detail.datedet)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
          };
          // }
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", details, "")
      );
    });
  });
};

//search by fullname and idnum
requests_details.searchbyidnum = (id, name, idnum) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.*,
    ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname,
     license_type.license,category.cat, province.pro_name , 
    weapon_name.weapon_name,weapon_name.weapon_size,biometric.pict, biometric.iris, biometric.fing_dat, biometric.fing_xml, biometric.note as bio_note
    FROM requests_details 
    inner join license_type on requests_details.license_id = license_type.id
    inner join category on requests_details.cat_id = category.id
    left join weapon_name on requests_details.weapname_id = weapon_name.id
    inner join province on requests_details.pro_id = province.id
    left join biometric on requests_details.biometric_id = biometric.id
       WHERE ( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) like '%${name}%' and requests_details.idnum ='${idnum}' and requests_details.id <> '${id}';`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          // if (detail.created_at) {
          detail = {
            ...detail,
            birdate: detail.birdate ? moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat1: detail.issdat1 ? moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat2: detail.issdat2 ? moment(detail.issdat2)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            datedet: detail.datedet ? moment(detail.datedet)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
          };
          // }
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", details, "")
      );
    });
  });
};

requests_details.searchById = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.id, requests_details.req_id,  requests_details.license_id,  requests_details.approval_role,
    ( requests_details.name1 ||' '||  requests_details.name2||' '||  requests_details.name3||' '||  requests_details.name4) as fullname ,  requests_details.surname,  requests_details.gender_type,  requests_details.cat_id, 
     requests_details.birdate, ( requests_details.monam1||' '||  requests_details.monam2|| ' '||  requests_details.monam3) as fullmonam,  requests_details.idnum,  requests_details.iss_1,  requests_details.issdat1,  requests_details.natnum, 
     requests_details.iss_2,  requests_details.issdat2,  requests_details.pro_id,  requests_details.addresses,  requests_details.nearplace,  requests_details.mahala,  requests_details.zuqaq,  requests_details.dar,  requests_details.djp,  requests_details.numdet,  requests_details.datedet,  requests_details.phone,
     requests_details.weapname_id,  requests_details.weapnum,  requests_details.wea_hold_per,  requests_details.margin_app,  requests_details.completed, 
     requests_details.note,  requests_details.created_at,  requests_details.created_by,  requests_details.updated_at,  requests_details.updated_by,  requests_details.prev_weapn,  requests_details.archive_num,  requests_details.biometric_id
    , license_type.license,category.cat, province.pro_name , 
      weapon_name.weapon_name,weapon_name.weapon_size,biometric.pict, biometric.iris, biometric.fing_dat, biometric.fing_xml, biometric.note
      FROM requests_details 
      inner join license_type on requests_details.license_id = license_type.id
      inner join category on requests_details.cat_id = category.id
      left join weapon_name on requests_details.weapname_id = weapon_name.id
      inner join province on requests_details.pro_id = province.id
      left join biometric on requests_details.biometric_id = biometric.id
       WHERE requests_details.id='${id}';`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );
      let details = [];
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          // if (detail.created_at) {
          detail = {
            ...detail,
            birdate: detail.birdate ? moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat1: detail.issdat1 ? moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            issdat2: detail.issdat2 ? moment(detail.issdat2)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
            datedet: detail.datedet ? moment(detail.datedet)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD") : null,
          };
          // }
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", details, "")
      );
    });
  });
};

requests_details.byOnlineReqID = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.*,( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname, license_type.license,category.cat, province.pro , 
    weapon_name.weapon_name,weapon_name.weapon_size 
    FROM requests_details 
    inner join license_type on requests_details.license_id = license_type.id
    inner join category on requests_details.cat_id = category.id
    left join weapon_name on requests_details.weapname_id = weapon_name.id
    inner join province on requests_details.pro_id = province.id
    WHERE requests_details.req_id='${id}';`;
    // console.log('sql',sql)
    poolPublic.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );
      let details = [];
      // console.log("row", result.rows)
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          // if (detail.created_at) {
          detail = {
            ...detail,
            birdate: detail.birdate && moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
            issdat1: detail.issdat1 && moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
            issdat2: detail.issdat2 && moment(detail.issdat2)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
            datedet: detail.datedet && moment(detail.datedet)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
          };
          // }
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", details, "")
      );
    });
  });
};

requests_details.byOnlineCreatedDate = (date) => {
  return new Promise((resolve, reject) => {
    let sql = `SELECT requests_details.*,( requests_details.name1 || ' ' ||requests_details.name2 || ' ' ||requests_details.name3|| ' ' ||requests_details.name4) as fullname, license_type.license,category.cat, province.pro , 
    weapon_name.weapon_name,weapon_name.weapon_size 
    FROM requests_details 
    inner join license_type on requests_details.license_id = license_type.id
    inner join category on requests_details.cat_id = category.id
    left join weapon_name on requests_details.weapname_id = weapon_name.id
    inner join province on requests_details.pro_id = province.id
    WHERE Date(requests_details.created_at)= '${date}';`;
    console.log("sql", sql)
    poolPublic.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );
      let details = [];
      // console.log("row", result.rows)
      if (result.rows[0]) {
        result.rows.forEach((detail) => {
          // if (detail.created_at) {
          detail = {
            ...detail,
            birdate: detail.birdate && moment(detail.birdate)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
            issdat1: detail.issdat1 && moment(detail.issdat1)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
            issdat2: detail.issdat2 && moment(detail.issdat2)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
            datedet: detail.datedet && moment(detail.datedet)
              .tz("Asia/Baghdad")
              .format("YYYY-MM-DD"),
          };
          // }
          details.push(detail);
        });
      }
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", details, "")
      );
    });
  });
};

requests_details.biometricCountReqID = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `select count (*) as finger from requests_details inner join biometric 
    on requests_details.biometric_id = biometric.id 
    where biometric.fing_dat IS NOT NULL and biometric.fing_xml IS NOT NULL and
     requests_details.id='${id}';`;
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(false, "requests_details Not Get Successfly", "", error)
        );
      return resolve(
        notifyMessage(true, "requests_details  Get Successfly", result.rows, "")
      );
    });
  });
};
requests_details.getCompleted = (req_details_id) => {
  return new Promise((resolve, reject) => {
    let sql = `select completed from requests_details 
    WHERE requests_details.id='${req_details_id}';`
    console.log('getCompleted', sql)
    pool.query(sql, (error, result) => {
      console.log(error)
      if (error) return reject(notifyMessage(false, "request  Not Update completed status Successfly", '', error))
      return resolve(notifyMessage(true, 'request  Update completed status Successfly', result.rows, ''))
    }
    )
  })
}
requests_details.updateComplete = (body, complet) => {
  return new Promise((resolve, reject) => {
    console.log('complet', complet)
    let sql = `Update requests_details set
    completed= ${complet}
    WHERE requests_details.id='${body.req_details_id}';`
    console.log('completeding', sql)
    pool.query(sql, (error, result) => {
      console.log(error)
      if (error) return reject(notifyMessage(false, "request  Not Update completed status Successfly", '', error))
      return resolve(notifyMessage(true, 'request  Update completed status Successfly', result.rows, ''))
    }
    )
  })
}

requests_details.updateBiometirc = (body, bioID) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests_details set
    biometric_id= '${bioID}'
    WHERE requests_details.id='${body.req_details_id}';`
    console.log('completeding', sql)
    pool.query(sql, (error, result) => {
      console.log(error)
      if (error) return reject(notifyMessage(false, "request det  Not Update biometric Successfly", '', error))
      return resolve(notifyMessage(true, 'request det Update biometric Successfly', result.rows, ''))
    }
    )
  })
}

requests_details.update = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests_details set
req_id= '${body.req_id}',
license_id= ${body.license_id},
approval_role= ${body.approval_role},
name1= '${body.name1}',
name2= '${body.name2}',
name3= '${body.name3}',
name4= '${body.name4}',
surname= '${body.surname}',
gender_type= ${body.gender_type},
cat_id= ${body.cat_id},
birdate= '${body.birdate}',
monam1= '${body.monam1}',
monam2= '${body.monam2}',
monam3= '${body.monam3}',
idnum= ${body.idnum},
iss_1= '${body.iss_1}',
issdat1= ${body.issdat1 ? "'" + body.issdat1 + "'" : 'default'},
natnum= '${body.natnum}',
iss_2= '${body.iss_2}',
issdat2=  ${body.issdat2 ? "'" + body.issdat2 + "'" : 'default'},
pro_id= ${body.pro_id},
addresses= '${body.addresses}',
nearplace= '${body.nearplace}',
mahala= '${body.mahala}',
zuqaq= '${body.zuqaq}',
dar= '${body.dar}',
djp= '${body.djp}',
numdet= '${body.numdet}',
datedet= ${body.datedet ? "'" + body.datedet + "'" : 'default'},
phone= '${body.phone}',
weapname_id= ${body.weapname_id},
weapnum= '${body.weapnum}',
wea_hold_per= '${body.wea_hold_per}',
margin_app= '${body.margin_app}',
completed= ${body.completed},
note= '${body.note}',
created_at= '${body.created_at}',
created_by= '${body.created_by}',
updated_at= default,
updated_by= '${body.updated_by}',
prev_weapn=${body.prev_weapn ? "'" + body.prev_weapn + "'" : 'default'},
archive_num=${body.archive_num ? "'" + body.archive_num + "'" : 'default'},
is_entry = ${body.is_entry},
entry_note= '${body.entry_note}',
identity_type = ${body.identity_type},
idw_previous = '${body.idw_previous}'
WHERE requests_details.id='${body.id}';`
    console.log('sql', sql);
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "rd Not Update Successfly", '', error))
      return resolve(notifyMessage(true, 'rd  Update Successfly', result.rows, ''))
    }
    )
  })
}
requests_details.updateNAme = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests_details set

name1= '${body.name1}',
name2= '${body.name2}',
name3= '${body.name3}',
name4= '${body.name4}',
surname= '${body.surname}',
monam1= '${body.monam1}',
monam2= '${body.monam2}',
monam3= '${body.monam3}',
updated_at= default,
updated_by= '${body.updated_by}'
WHERE requests_details.id='${body.id}';`
    console.log('sql', sql);
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, " name  Not  update Successfly", '', error))
      return resolve(notifyMessage(true, 'name Update Successfly', result.rows, ''))
    }
    )
  })
}
requests_details.updatedeleteminster = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests_details set
                completed= ${body.completed},
                note= '${body.note}',
                updated_at= default
                WHERE id ='${body.id}';`
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "rd Not Update Successfly", '', error))
      return resolve(notifyMessage(true, 'rd  Update Successfly', result.rows, ''))
    }
    )
  })
}
requests_details.updateacceptminster = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests_details set
              approval_role= ${body.approval_role},
              wea_hold_per= '${body.wea_hold_per}',
              margin_app= '${body.margin_app}',
              identity_type = ${body.identity_type},
              updated_at= default
              WHERE id ='${body.id}';`
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "rd Not Update Successfly", '', error))
      return resolve(notifyMessage(true, 'rd  Update Successfly', result.rows, ''))
    }
    )
  })
}

requests_details.updateMinister = (body) => {
  return new Promise((resolve, reject) => {
    let sql = `Update requests_details set
        license_id= ${body.license_id},
        approval_role= ${body.approval_role},
        wea_hold_per= '${body.wea_hold_per}',
        margin_app= '${body.margin_app}',
        updated_at= default,
        updated_by = ${body.updated_by},
        identity_type = ${body.identity_type}
        WHERE requests_details.id='${body.id}';`
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "request details Not Update Successfly", '', error))
      return resolve(notifyMessage(true, 'request details  Update Successfuly', result.rows, ''))
    }
    )
  })
}

requests_details.insert = (body) => {
  return new Promise((resolve, reject) => {
    console.log("body", body)
    let sql = `INSERT INTO requests_details VALUES(
default,       
 '${body.req_id}',
 ${body.license_id ? body.license_id : 1},
 ${body.apptype_id ? body.apptype_id : 2}, 
 '${body.name1}',
 '${body.name2}',
 '${body.name3}', 
 '${body.name4}',
 '${body.surname}',
 ${body.gen_id}, 
 ${body.cat_id},
 '${moment(body.birdate).tz('Asia/Baghdad').format('Y-M-D')}',
 '${body.monam1}', 
 '${body.monam2}',
 '${body.monam3}',
 '${body.idnum}', 
  ${body.iss_id1 ? "'" + body.iss_id1 + "'" : 'default'},
 '${moment(body.issdat1).tz('Asia/Baghdad').format('Y-M-D')}',
 '${body.natnum}',
 ${body.iss_id2},
 ${body.issdat2 ? "'" + moment(body.issdat2).tz('Asia/Baghdad').format('Y-M-D') + "'" : 'default'},
 ${body.pro_id}, 
'${body.addresses}',
'${body.nearplace}',
'${body.mahala}', 
'${body.zuqaq}',
'${body.dar}',
${body.djp ? "'" + body.djp + "'" : 'default'}, 
${body.numdet ? "'" + body.numdet + "'" : 'default'},
${body.datedet ? "'" + body.datedet + "'" : 'default'},
'${body.phone}', 
${body.weapname_id ? "'" + body.weapname_id + "'" : 'default'},
${body.weapnum ? "'" + body.weapnum + "'" : 'default'},
 ${body.wea_hold_per ? "'" + body.wea_hold_per + "'" : 60}, 
${body.margin_app ? "'" + body.margin_app + "'" : 'default'},
  default,
${body.note ? "'" + body.note + "'" : 'default'},
'${body.created_at}',
  ${body.created_by},
  default,
  default,
  default,
  default,
  default,
  '${body.e_fullname}',
  default,
  default,
  2
);`;
    console.log("sqlDetails", sql)
    pool.query(sql, (error, result) => {
      if (error)
        return reject(
          notifyMessage(
            false,
            "requests_details Not Insert Successfly",
            "",
            error
          )
        );
      return resolve(
        notifyMessage(
          true,
          "requests_details  Insert Successfly",
          result.rows,
          ""
        )
      );
    });
  });
};

requests_details.Delete = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `delete from requests_details WHERE requests_details.id='${id}';`
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "request details Not deleted Successfly", '', error))
      return resolve(notifyMessage(true, 'request details  deleted Successfuly', result.rows, ''))
    }
    )
  })
}
module.exports = requests_details;
