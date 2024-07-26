const router = require('express').Router()
const Approval_destination = require('../models/Approval_destination')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let approval_destination = await Approval_destination.all()
        res.status(200).json(approval_destination)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Approval_destination was not get', '', error))
    }

})

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let approval_destination= await Approval_destination.byid(req.params.id)
        res.status(200).json(approval_destination)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Approval_destination was not get by id', '', error))

    }

})
router.put('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let approval_destination= await Approval_destination.update(req.body,req.params.id)
        res.status(200).json(approval_destination)
    }
    catch(error) {
        console.log("error",error);
             res.status(400).json(error)

    }

})

router.post('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let approval_destination= await Approval_destination.insert(req.body)
        res.status(200).json(approval_destination)
    }
    catch(error) {
             res.status(400).json( error)

    }

})

router.delete('/delete/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let approval_destination= await Approval_destination.delete(req.params.id)
        res.status(200).json(approval_destination)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Approval_destination was not get by id', '', error))

    }

})

module.exports = router