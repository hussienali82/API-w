const router = require('express').Router()
const Dashpoard = require('../models/Dashpoard')
const {notifyMessage}=require ('../utils/notification')


router.get('/', async (req, res) => {
    try {
       let dashpoard = await Dashpoard.countOffline()
        res.status(200).json(dashpoard)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'countOffline was not get', '', error))

    }

})
router.get('/countOnline', async (req, res) => {
    try {
       let dashpoard = await Dashpoard.countOnline()
        res.status(200).json(dashpoard)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'countOnline was not get', '', error))

    }

})
// router.get('/', async (req, res) => {
//     try {
//        let dashpoard = await Dashpoard.completed()
//         res.status(200).json(dashpoard)
//     }
//     catch(error) {
//              res.status(400).json(notifyMessage(false, 'completed was not get', '', error))

//     }

// })
// router.get('/', async (req, res) => {
//     try {
//        let dashpoard = await Dashpoard.countPrint()
//         res.status(200).json(dashpoard)
//     }
//     catch(error) {
//              res.status(400).json(notifyMessage(false, 'countPrint was not get', '', error))

//     }

// })
// router.get('/', async (req, res) => {
//     try {
//        let dashpoard = await Dashpoard.handleProcess()
//         res.status(200).json(dashpoard)
//     }
//     catch(error) {
//              res.status(400).json(notifyMessage(false, 'handleProcess was not get', '', error))

//     }

// })
// router.get('/', async (req, res) => {
//     try {
//        let dashpoard = await Dashpoard.notHandleProcess()
//         res.status(200).json(dashpoard)
//     }
//     catch(error) {
//              res.status(400).json(notifyMessage(false, 'notHandleProcess was not get', '', error))

//     }

// })
// router.get('/', async (req, res) => {
//     try {
//        let dashpoard = await Dashpoard.notcompleted()
//         res.status(200).json(dashpoard)
//     }
//     catch(error) {
//              res.status(400).json(notifyMessage(false, 'notcompleted was not get', '', error))

//     }

// })



module.exports = router