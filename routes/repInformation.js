const router = require('express').Router()
const repInformation = require('../models/RepInformation')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
      const getPaylod = verifyToken(req)
     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let RepInformation = await repInformation.all()
        res.status(200).json(RepInformation)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'RepInformation was not get', '', error))

    }

})

// router.get('/id/:id', async (req, res) => {
//     const getPaylod = verifyToken(req)
//     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
//     try {
//        let RepInformation= await RepInformation.byid(req.params.id)
//         res.status(200).json(RepInformation)
//     }
//     catch(error) {
//              res.status(400).json(notifyMessage(false, 'RepInformation was not get by id', '', error))

//     }

// })


// router.put("/id/:id", async (req, res) => {
//      const getPaylod = verifyToken(req)
//      if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
//     try {
//       let RepInformation = await RepInformation.update(req.body, req.params.id);
//       res.status(200).json(RepInformation);
//     } catch (error) {
//       console.log("error", error);
//       res.status(400).json(error);
//     }
//   });




// router.post('/', async (req, res) => {
//     const getPaylod = verifyToken(req)
//     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
//     console.log('body route', req.body);
//     try {
//        let RepInformation = await RepInformation.insert(req.body)
//         res.status(200).json(RepInformation)
//         console.log('body route', req.body);
//     }
   

//     catch(error) {console.log("error",error)
//              res.status(400).json(notifyMessage(false, 'RepInformation was not inserted', '', error))

//     }

// })

// router.delete('/delete/:id', async (req, res) => {
//     const getPaylod = verifyToken(req)
//     if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
//     try {
//        let RepInformation= await RepInformation.delete(req.params.id)
//         res.status(200).json(RepInformation)
//     }
//     catch(error) {
//              res.status(400).json(notifyMessage(false, 'RepInformation was not get by id', '', error))

//     }

// })

module.exports = router