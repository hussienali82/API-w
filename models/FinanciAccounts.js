
const { notifyMessage } = require('../utils/notification')
const { pool, client } = require('../db/index')
const moment = require('moment-timezone')


const FinanciAccounts = {}



FinanciAccounts.byreqid = (regid) => {
  return new Promise((resolve, reject) => {

    let sql = `select financial_accounts.*, payment_text, payment_amount from financial_accounts inner join payment_amount on 
    financial_accounts.id_payment=payment_amount.id
            where req_id='${regid}'`
    console.log('sql', sql)
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "finance not get successfly", '', error))
      let AllData = []
      if (result.rows[0]) {
        result.rows.forEach(data => {
          if (data) {
            data = {
              ...data,
              check_date: data.check_date ? moment(data.check_date).tz('Asia/Baghdad').format('YYYY-MM-DD') : data.check_date,
              updated_at: moment(data.updated_at).tz('Asia/Baghdad').format('YYYY-MM-DD'),
              created_at: moment(data.created_at).tz('Asia/Baghdad').format('YYYY-MM-DD')


            }
          }
          AllData.push(data)
        });
      }
      return resolve(notifyMessage(true, 'finance  get successfly', AllData, ''))

    })
  })
}
FinanciAccounts.paymantable = () => {
  return new Promise((resolve, reject) => {

    let sql = `select * from payment_amount`
    console.log('sql', sql)
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "paymant  not get successfly", '', error))

      return resolve(notifyMessage(true, 'paymant  get successfly', result.rows, ''))

    })
  })
}
FinanciAccounts.Countpaymantable = () => {
  return new Promise((resolve, reject) => {

    let sql = `select count(*) from payment_amount`
    console.log('sql', sql)
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "paymant count not get successfly", '', error))

      return resolve(notifyMessage(true, 'paymant  get successfly', result.rows, ''))

    })
  })
}
FinanciAccounts.CountFinancialTable = (regid) => {
  return new Promise((resolve, reject) => {

    let sql = `select count(*) from public.financial_accounts 
    where req_id='${regid}' 
              
`
    console.log('sql', sql)
    pool.query(sql, (error, result) => {

      if (error) return reject(notifyMessage(false, "finance count not get successfly", '', error))

      return resolve(notifyMessage(true, 'finance count get successfly', result.rows, ''))

    })
  })
}


FinanciAccounts.update = (body) => {
  return new Promise((resolve, reject) => {
    console.log('body', body)
    let sql = `Update public.financial_accounts set

    req_id='${body.req_id}'
    , note='${body.note}'
    , created_at=default
    , created_by=${body.created_by}
    , updated_at=default
    , updated_by='${body.updated_by}'
    , check_num=${body.check_num}
    , check_date=${(body.check_date==null || body.check_date=='') ?null:`'${body.check_date}'`}
    , id_payment='${body.id_payment}'
    

 WHERE financial_accounts.id='${body.id}';`

    console.log('sql', sql)
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "finance not update successfly", '', error))
      return resolve(notifyMessage(true, 'finance  update successfly', result.rows, ''))
    }
    )

  })
}


FinanciAccounts.updatePaymant = (body) => {
  return new Promise((resolve, reject) => {
    console.log('body', body)
    let sql = `Update public.payment_amount set

    payment_text='${body.payment_text}'
    , payment_amount='${body.payment_amount}'
   
 WHERE payment_amount.id='${body.id}';`

    console.log('sql', sql)
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "payment_amount not update successfly", '', error))
      return resolve(notifyMessage(true, 'payment_amount  update successfly', result.rows, ''))
    }
    )

  })
}

FinanciAccounts.insert = (body, req_id) => {
  return new Promise((resolve, reject) => {
    let sql = `INSERT INTO financial_accounts VALUES
    (
    default
    ,'${req_id}'
    ,'${!body.note?null:body.note}'
    , default
    , 2
    ,default
    , 2
    , ${!body.check_num?null:body.check_num}
    , ${(body.check_date==null || body.check_date=='')?null:`'${body.check_date}'`}
    , '${body.id_payment}'
         )
            ;`

    console.log('sql2', sql)
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "finance not insert successfly", '', error))
      return resolve(notifyMessage(true, 'finance  insert successfly', result.rows, ''))
    })
  }
  )
}

FinanciAccounts.insertPayment = (body, req_id) => {
  return new Promise((resolve, reject) => {
    let sql = `INSERT INTO payment_amount VALUES
    (default
   , '${body.payment_text}'
    ,'${body.payment_amount}'
         )
            ;`

    console.log('sql2', sql)
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "payment_amount not insert successfly", '', error))
      return resolve(notifyMessage(true, 'payment_amount  insert successfly', result.rows, ''))
    })
  }
  )
}

FinanciAccounts.delete = (id) => {
  return new Promise((resolve, reject) => {
   
    let sql = `delete from  payment_amount where id='${id}';`
    console.log('sql',sql)
    pool.query(sql, (error, result) => {
      if (error) return reject(notifyMessage(false, "payment_amount not delete successfly", '', error))
      return resolve(notifyMessage(true, 'payment_amount  delete successfly', result.rows, ''))
    })
  }
  )
}
module.exports = FinanciAccounts