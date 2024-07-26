const router = require('express').Router()
const stations = require('../models/Stations')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
      const getPaylod = verifyToken(req)
      if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Stations = await stations.all()
        res.status(200).json(Stations)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Stations was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Stations= await stations.byid(req.params.id)
        res.status(200).json(Stations)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Stations was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Stations = await stations.update(req.body, req.params.id);
      res.status(200).json(Stations);
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
       let Stations = await stations.insert(req.body)
        res.status(200).json(Stations)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Stations was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Stations= await stations.delete(req.params.id)
        res.status(200).json(Stations)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Stations was not get by id', '', error))

    }

})

module.exports = router