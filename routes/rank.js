const router = require('express').Router()
const rank = require('../models/Rank')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Rank = await rank.all()
        res.status(200).json(Rank)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Rank was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Rank= await rank.byid(req.params.id)
        res.status(200).json(Rank)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Rank was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Rank = await rank.update(req.body, req.params.id);
      res.status(200).json(Rank);
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
       let Rank = await rank.insert(req.body)
        res.status(200).json(Rank)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Rank was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Rank= await rank.delete(req.params.id)
        res.status(200).json(Rank)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Rank was not get by id', '', error))

    }

})

module.exports = router