const router = require('express').Router()
const RepTransMain = require('../models/RepTransMain')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let reptransmain = await RepTransMain.all()
        res.status(200).json(reptransmain)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'reptransmain was not get', '', error))

            }

        })

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let reptransmain= await RepTransMain.byid(req.params.id)
        res.status(200).json(reptransmain)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'RepInformation was not get by id', '', error))

    }

})



    





module.exports = router