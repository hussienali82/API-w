const router = require('express').Router()
const hospital = require('../models/Hospital')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Hospital = await hospital.all()
        res.status(200).json(Hospital)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Hospital was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Hospital= await hospital.byid(req.params.id)
        res.status(200).json(Hospital)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Hospital was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Hospital = await hospital.update(req.body, req.params.id);
      res.status(200).json(Hospital);
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
       let Hospital = await hospital.insert(req.body)
        res.status(200).json(Hospital)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Hospital was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
 if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Hospital= await hospital.delete(req.params.id)
        res.status(200).json(Hospital)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Hospital was not get by id', '', error))

    }

})

module.exports = router