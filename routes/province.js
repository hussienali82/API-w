const router = require('express').Router()
const Province = require('../models/Province')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
    try {
       let province = await Province.all()
        res.status(200).json(province)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'province was not get', '', error))
    }

})

router.get('/id/:id', async (req, res) => {
    try {
       let province= await Province.byid(req.params.id)
        res.status(200).json(province)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'province was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let province = await Province.update(req.body, req.params.id);
      res.status(200).json(province);
    } catch (error) {
      console.log("error", error);
      res.status(400).json(error);
    }
  });

router.post('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let province= await Province.insert(req.body)
        res.status(200).json(province)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'province was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let province= await Province.delete(req.params.id)
        res.status(200).json(province)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'province was not get by id', '', error))

    }

})

module.exports = router