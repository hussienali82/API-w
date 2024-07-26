const router = require('express').Router()
const hospitalmid = require('../models/Hospitalmid')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Hospitalmid = await hospitalmid.all()
        res.status(200).json(Hospitalmid)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Hospitalmid was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Hospitalmid= await hospitalmid.byid(req.params.id)
        res.status(200).json(Hospitalmid)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Hospitalmid was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Hospitalmid = await hospitalmid.update(req.body, req.params.id);
      res.status(200).json(Hospitalmid);
    } catch (error) {
      console.log("error", error);
      res.status(400).json(error);
    }
  });




router.post('/', async (req, res) => {
     const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    console.log('body route', req.body);
    try {
       let Hospitalmid = await hospitalmid.insert(req.body)
        res.status(200).json(Hospitalmid)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Hospitalmid was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Hospitalmid= await hospitalmid.delete(req.params.id)
        res.status(200).json(Hospitalmid)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Hospitalmid was not get by id', '', error))

    }

})

module.exports = router