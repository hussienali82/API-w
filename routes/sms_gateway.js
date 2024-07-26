const router = require('express').Router()
const { notifyMessage } = require('../utils/notification')
const { sendsms } = require('../utils/send_sms')
const { verifyToken } = require('../auth/jwt')
const { smsValidate } = require("../utils/validations");


router.post('/', async (req, res) => {
  
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    //check validation
    const { error } = smsValidate(req.body);
    if (error) return res.status(400).json(notifyMessage(false, "Validation error", "", error.details[0].message));

    try {
        let sms =  await sendsms(req.body.msg, req.body.phone)
        // console.log("sms", sms);
        res.status(200).json(sms)
    }
    catch (error) {
        console.log("error", error);
        res.status(400).json(notifyMessage(false, 'Error, sms does not send', '', error))
    }
})

module.exports = router