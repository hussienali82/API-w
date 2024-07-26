const router = require('express').Router()
const governs = require('../models/Governs')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Governs = await governs.all()
        res.status(200).json(Governs)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Governs was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Governs= await governs.byid(req.params.id)
        res.status(200).json(Governs)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Governs was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
     const getPaylod = verifyToken(req)
      if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Governs = await governs.update(req.body, req.params.id);
      res.status(200).json(Governs);
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
       let Governs = await governs.insert(req.body)
        res.status(200).json(Governs)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Governs was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Governs= await governs.delete(req.params.id)
        res.status(200).json(Governs)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Governs was not get by id', '', error))

    }

})

module.exports = router