const router = require('express').Router()
const license_type = require('../models/License')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let License_type = await license_type.all()
        res.status(200).json(License_type)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'license_type was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let License_type= await license_type.byid(req.params.id)
        res.status(200).json(License_type)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'license_type was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let License_type = await license_type.update(req.body, req.params.id);
      res.status(200).json(License_type);
    } catch (error) {
      console.log("error", error);
      res.status(400).json(error);
    }
  });




router.post('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let License_type= await license_type.insert(req.body)
        res.status(200).json(License_type)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'license_type was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let License_type= await license_type.delete(req.params.id)
        res.status(200).json(License_type)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'License_type was not get by id', '', error))

    }

})

module.exports = router