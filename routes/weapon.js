const router = require('express').Router()
const weapon_name = require('../models/Weapon')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')

router.get('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Weapon_name = await weapon_name.all()
        res.status(200).json(Weapon_name)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'weapon_name was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Weapon_name= await weapon_name.byid(req.params.id)
        res.status(200).json(Weapon_name)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'weapon_name was not get by id', '', error))

    }

})

router.put("/id/:id", async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let Weapon_name = await weapon_name.update(req.body, req.params.id);
      res.status(200).json(Weapon_name);
    } catch (error) {
      console.log("error", error);
      res.status(400).json(error);
    }
  });




router.post('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Weapon_name= await weapon_name.insert(req.body)
        res.status(200).json(Weapon_name)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'weapon_name was not inserted', '', error))

    }

})

router.delete('/delete/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Weapon_name= await weapon_name.delete(req.params.id)
        res.status(200).json(Weapon_name)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Weapon_name was not get by id', '', error))

    }

})


module.exports = router