var express = require('express');
const { pool, client } = require('../db');
const isAuthorized = require('./authentication').isAuthorized
var router = express.Router();

/* GET category listing by id. */
router.get('/category',isAuthorized, async function (req, res, next) {
  try {
    let q = 'select * from category'
    pool.query(q, (error, result) => {
      if (error) {
        return res.json({ success: false, message: 'category read success', data: [], error: error });
      } else {
        res.json({ success: true, message: 'category read error', data: result.rowss, error: '' })
      }
    });
  }
  catch (error) {
    res.json({ success: false, message: 'category read success', data: [], error: error });
  }
});

/* GET category listing by id. */
router.get('/category/:id',isAuthorized, async function (req, res, next) {
  try {
    let q = 'select * from category where id = $1'
    pool.query(q, [req.params.id], (error, result) => {
      if (error) {
        return res.json({ success: false, message: 'category read error', data: [], error: error });
      } else {
        res.json({ success: true, message: 'category read success', data: result.rowss, error: '' })
      }
    });
  }
  catch (error) {
    res.json({ success: false, message: 'category read error', data: [], error: error });
  }
});

/* POST new request . */
router.post('/category',isAuthorized, async function (req, res, next) {
  try {
    let q = 'INSERT INTO category (cat, created_by) VALUES ($1, $2) RETURNING id '
    pool.query(q, [...Object.values(req.body),req.user.id], (error, result) => {
      if (error) {
        return res.json({ success: false, message: 'category insert error', data: [], error: error });
      } else {
        res.json({ success: true, message: 'category insert success', data: result.rowss, error: '' })
      }
    });
  }
  catch (error) {
    console.log(error)
    res.json({ success: false, message: 'category insert error ', data: [], error: error });
  }
});


/* UPDATE user by id */
router.put('/category/:id', isAuthorized,function (req, res, next) {
  try {
    let q = 'UPDATE category SET cat = $1, updated_by = $2, updated_at = $3 WHERE id = $4'
    pool.query(q, [...Object.values(req.body), req.user.id, new Date(), req.params.id], (error, result) => {
      if (error) {
        return res.json({ success: false, message: 'category update error', data: [], error: error });
      } else {
        res.json({ success: true, message: 'category update success', data: result.rowsCount, error: '' })
      }
    });
  }
  catch (error) {
    console.log(error)
    res.json({ success: false, message: 'category update error', data: [], error: error });

  }
});


/* DELETE category by id */
router.delete('/category/:id',isAuthorized, async function (req, res, next) {
  try {
    let q = 'delete from category where id = $1'
    pool.query(q, [req.params.id], (error, result) => {
      if (error) {
        return res.json({ success: false, message: 'category delete error', data: [], error: error });
      } else {
        res.json({ success: true, message: 'category delete success', data: result.rowsCount, error: '' })
      }
    });
  }
  catch (error) {
    res.json({ success: false, message: 'category delete error', data: [], error: error });
  }
});

module.exports = router;