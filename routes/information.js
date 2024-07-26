const router = require('express').Router()
const information = require('../models/Information')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Information = await information.all()
        res.status(200).json(Information)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Information was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Information= await information.byid(req.params.id)
        res.status(200).json(Information)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Information was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Information = await information.update(req.body, req.params.id);
      res.status(200).json(Information);
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
       let Information = await information.insert(req.body)
        res.status(200).json(Information)
        console.log('body route', req.body);
    }
   

    catch(error) {console.log("error",error)
             res.status(400).json(notifyMessage(false, 'Information was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Information= await information.delete(req.params.id)
        res.status(200).json(Information)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Information was not get by id', '', error))

    }

})

module.exports = router