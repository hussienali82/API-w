const router = require('express').Router()
const test = require('../models/Test')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
     const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Test = await test.all()
        res.status(200).json(Test)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Test was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Test= await test.byid(req.params.id)
        res.status(200).json(Test)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Test was not get by id', '', error))

    }

})


router.put("/id/:id", async (req, res) => {
     const getPaylod = verifyToken(req)
      if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Test = await test.update(req.body, req.params.id);
      res.status(200).json(Test);
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
       let Test = await test.insert(req.body)
        res.status(200).json(Test)
    }
    catch(error) {
      console.log('error',error)
             res.status(400).json(notifyMessage(false, 'Test was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Test= await test.delete(req.params.id)
        res.status(200).json(Test)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Test was not get by id', '', error))

    }

})

module.exports = router