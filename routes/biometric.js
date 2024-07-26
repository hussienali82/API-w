const router = require('express').Router()
const Biometric = require('../models/Biometric')
const Requests_details = require('../models/Requests_details')
const { notifyMessage } = require('../utils/notification')
const { verifyToken } = require('../auth/jwt')

router.get('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let biometric = await Biometric.all()
        res.status(200).json(biometric)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(error)
    }

})

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let biometric = await Biometric.byid(req.params.id)
        res.status(200).json(biometric)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(error)
    }

})

router.get('/req-id/:id', async (req, res) => {
    // const getPaylod = verifyToken(req)
    // if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let biometric = await Biometric.byReqDetID(req.params.id)
        res.status(200).json(biometric)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(error)
    }

})
router.put('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let biometric = await Biometric.update(req.body)
        res.status(200).json(biometric)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(error)

    }

})

router.post('/', async (req, res) => {
    try {
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false)
            return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
        let body = {
            ...req.body,
            created_by: getPaylod.msg.id
        }
        console.log("Insert body",body);
        let biometric = await Biometric.insert(body)
        if(!biometric.success)   return res.status(400).json(notifyMessage(false, 'Biometric insert error', '', biometric.err));
        let bioID = biometric.data[0]?.id
        let updateReqDetails = await Requests_details.updateBiometirc(body,bioID)
        res.status(200).json(updateReqDetails)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(error)

    }

})

module.exports = router