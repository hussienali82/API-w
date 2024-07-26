const router = require('express').Router()
const SubIdentity = require('../models/SubIdentity')
const { notifyMessage } = require('../utils/notification')
const { verifyToken } = require('../auth/jwt')

router.get('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let subidentity = await SubIdentity.all()
        res.status(200).json(subidentity)
    }
    catch (error) {
        res.status(400).json(error)
    }

})

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let subidentity = await SubIdentity.byid(req.params.id)
        res.status(200).json(subidentity)
    }
    catch (error) {
        res.status(400).json(error)

    }

})


router.put("/id/:id", async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let subidentity = await SubIdentity.update(req.body, req.params.id);
        res.status(200).json(subidentity);
    } catch (error) {
        console.log("error", error);
        res.status(400).json(error);
    }
});

router.post('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let subidentity = await SubIdentity.insert(req.body)
        res.status(200).json(subidentity)
    }
    catch (error) {
        res.status(400).json(error)

    }

})

router.delete('/delete/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let subidentity = await SubIdentity.delete(req.params.id)
        res.status(200).json(subidentity)
    }
    catch (error) {
        res.status(400).json(error)

    }
})

module.exports = router