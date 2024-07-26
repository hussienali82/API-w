
const { notifyMessage } = require('../utils/notification')
const { pool, client } = require('../db/index')
const moment = require('moment-timezone')


const approvals = {}

approvals.all = () => {
  return new Promise((resolve, reject) => {

    let sql = `SELECT  
    req_details_id, 
    approval_dest_id, 
	  approval_destination.destination,
	  approval_destination.approval_part,
    status, 
    reason, 
    booknum, 
    bookdate, 
    note, 
    created_at, 
    created_by,
    updated_at, 
    updated_by,
    audit
	  FROM approvals 
    inner join approval_destination on approvals.approval_dest_id = approval_destination.id ;`

    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "approvals not get successfly", '', error))
      let AllData = []
      if (result.rows[0]) {
        result.rows.forEach(data => {
          if (data) {
            data = {
              ...data,
              bookdate: moment(data.bookdate).tz('Asia/Baghdad').format('YYYY-MM-DD'),
            }
          }
          AllData.push(data)
        });
      }
      return resolve(notifyMessage(true, 'approvals  Get Successfly', AllData, ''))

    })
  })
}

approvals.count = (req_details_id, userBody) => {
  return new Promise((resolve, reject) => {
    let sql = userBody.user_type === 1 ? `SELECT count(*)	FROM public.approvals
      where req_details_id='${req_details_id}'` :
      `SELECT count(*)	FROM public.approvals
      where sub_identity=${userBody.sudid} and req_details_id='${req_details_id}'`
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "approvals not get successfly", '', error))
      return resolve(notifyMessage(true, 'approvals  get successfly', result.rows, ''))

    })
  })
}
approvals.countRoleType = (req_details_id, body) => {
  return new Promise((resolve, reject) => {

    let sql = body.role_type == 1 ? `select count (*) as cou from approvals inner join approval_destination
      on approvals.approval_dest_id = approval_destination.id
      where (approval_destination.role_type = 2 or approval_destination.role_type = 3)
      and req_details_id ='${req_details_id}'` : body.sudrultype > 0 ? `select count (*) as cou from approvals left join approval_destination
            on approvals.approval_dest_id = approval_destination.id
            where 
             req_details_id ='${req_details_id}'` : ''
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "approvals count role not get successfly", '', error))
      return resolve(notifyMessage(true, 'approvals count role get successfly', result.rows, ''))

    })
  })
}

approvals.byreqid = (regid, destID, destRoleType, userType) => {
  return new Promise((resolve, reject) => {

    let sql = `SELECT a.*, d.role_type, d.approval_part ,d.destination,d.precedence,d.send_sms as det_send_sms,s.sudname
    FROM approvals a left join approval_destination d on a.approval_dest_id=d.id  
    left join subidentity s on a.sub_identity=s.sudid
    where a.req_details_id='${regid}' 
              
`
    if (userType == 2) {
      sql = sql + ` and a.approval_dest_id=${destID} order by a.created_at DESC  `
    } else {
      sql = sql + ' order by a.created_at DESC  '
    }

    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "approvals not get successfly", '', error))
      let AllData = []
      if (result.rows[0]) {
        result.rows.forEach(data => {
          if (data) {
            data = {
              ...data,
              bookdate: moment(data.bookdate).tz('Asia/Baghdad').format('YYYY-MM-DD'),
              created_at: moment(data.created_at).tz('Asia/Baghdad').format('YYYY-MM-DD/ hh-mm-ss')
            }
          }
          AllData.push(data)
        });
      }
      return resolve(notifyMessage(true, 'approvals  get successfly', AllData, ''))

    })
  })
}

approvals.byid = (req_details_id) => {
  return new Promise((resolve, reject) => {

    let sql = `
    SELECT approvals.*,approval_destination.destination,subidentity.sudid,subidentity.sudname,subidentity.sudrultype
	FROM public.approvals
	left join subidentity on approvals.sub_identity = subidentity.sudid
    left join approval_destination on approvals.approval_dest_id = approval_destination.id 
        WHERE approvals.req_details_id='${req_details_id}'
        order by created_at ASC ;`
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "approvals not get successfly", '', error))
      return resolve(notifyMessage(true, 'approvals  get successfly', result.rows, ''))

    })
  })
}
approvals.status1 = (req_details_id, destID) => {
  return new Promise((resolve, reject) => {

    let sql = `select count(*) from 
     (SELECT public.fn_status1(approval_dest_id) as status from approvals 
     where req_details_id='${req_details_id}'  and	sub_identity  is null and status = 0 and approval_dest_id <> ${destID}  ) status
    ;`
    console.log('sqlstatus', sql)
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "approvals status  not get successfly", '', error))
      return resolve(notifyMessage(true, 'approvals status get successfly', result.rows, ''))

    })
  })
}

approvals.status2 = (req_details_id, subid) => {
  return new Promise((resolve, reject) => {

    let sql = `select count(*) from 
    (SELECT public.fn_status2(sub_identity) as status from approvals 
    where req_details_id='${req_details_id}'  and	sub_identity  is not null 
   
  and  status =0   and	sub_identity<> ${subid} ) status 
    ;`
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "approvals status  not get successfly", '', error))
      return resolve(notifyMessage(true, 'approvals status get successfly', result.rows, ''))

    })
  })
}

approvals.update = (body) => {
  return new Promise((resolve, reject) => {

    let sql = `Update approvals set
req_details_id='${body.req_details_id}',
approval_dest_id=${body.approval_dest_id},
approval_part=${body.approval_part},
status=${body.status},
reason='${body.reason}',
booknum='${body.booknum}',
bookdate='${body.bookdate}',
note='${body.note}',
created_by=${body.created_by},
updated_at=default,
updated_by=${body.updated_by}
 WHERE approvals.id='${body.id}';`
    console.log('sql', sql)
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "approvals not update successfly", '', error))
      return resolve(notifyMessage(true, 'approvals  update successfly', result.rows, ''))
    }
    )

  })
}
approvals.updateAudit = (body) => {
  return new Promise((resolve, reject) => {

    let sql = `Update approvals set audit= cast ((${body.audit}) as bit)
 
   WHERE approvals.id='${body.id}';`
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "approvals not update audit successfly", '', error))
      return resolve(notifyMessage(true, 'approvals  update audit successfly', result.rows, ''))
    }
    )

  })
}


approvals.insert = (body, destID, sudid) => {
  return new Promise((resolve, reject) => {
    console.log('body', body)
    let sql = `INSERT INTO approvals VALUES
         (default,
        '${body.req_details_id}',
         ${destID},
         ${body.approval_part},
         ${body.status},
        '${body.reason}',
         '${body.booknum}',
        ${!body.bookdate ? null : "'" + body.bookdate + "'"},
         '${body.note}',
         default,
         ${body.created_by},
         default,
		  default,
         cast ((${body.audit}) as bit),
         default,
         ${sudid},
        '${body.sms}'
         )
            ;`
    console.log('sql2', sql)
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "approvals not insert successfly", '', error))
      return resolve(notifyMessage(true, 'approvals  insert successfly', result.rows, ''))
    })
  }
  )
}


approvals.delete = (id) => {
  return new Promise((resolve, reject) => {
    let sql = `delete from  approvals where id='${id}';`

    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "approvals not delete successfly", '', error))
      return resolve(notifyMessage(true, 'approvals  delete successfly', result.rows, ''))
    })
  }
  )
}

module.exports = approvals