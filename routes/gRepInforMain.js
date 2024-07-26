const router = require('express').Router()
const gRepInforMain = require('../models/GRepInforMain')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let GRepInforMain = await gRepInforMain.all()
        res.status(200).json(GRepInforMain)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'RepInforMain was not get', '', error))

            }

        })

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let GRepInforMain= await gRepInforMain.byid(req.params.id)
        res.status(200).json(GRepInforMain)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'RepInformation was not get by id', '', error))

    }

})



    





module.exports = router