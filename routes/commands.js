const router = require('express').Router()
const commands = require('../models/Commands')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
      const getPaylod = verifyToken(req)
      if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Commands = await commands.all()
        res.status(200).json(Commands)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Commands was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
      if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Commands= await commands.byid(req.params.id)
        res.status(200).json(Commands)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Commands was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
       const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Commands = await commands.update(req.body, req.params.id);
      res.status(200).json(Commands);
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
       let Commands = await commands.insert(req.body)
        res.status(200).json(Commands)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Commands was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Commands= await commands.delete(req.params.id)
        res.status(200).json(Commands)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Commands was not get by id', '', error))

    }

})

module.exports = router