const router = require('express').Router()
const transmit = require('../models/Transmit')
const { notifyMessage } = require('../utils/notification')
const { verifyToken } = require('../auth/jwt')
const hospital = require('../models/Hospital')
const Test = require('../models/Test')

const Hospitalmid = require('../models/Hospitalmid')
const { body, Result } = require('express-validator')
router.get('/', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let Transmit = await transmit.all()
    res.status(200).json(Transmit)
  }
  catch (error) {
    console.log('error', error);
    res.status(400).json(notifyMessage(false, 'Transmit was not get', '', error))

  }

})

router.get('/id/:id', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let Transmit = await transmit.byid(req.params.id)
    res.status(200).json(Transmit)
  }
  catch (error) {
    res.status(400).json(notifyMessage(false, 'Transmit was not get by id', '', error))

  }

})


router.put("/id/:id", async (req, res) => {
  const payload = req.body

  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
   
    let Transmit = await transmit.update(payload.datarecord, req.params.id);
    let length=payload.hospitalTrans.length 
    let hospitalmid
for (let i = 0; i < length; i++) {
   hospitalmid = await Hospitalmid.update(payload.hospitalTrans[i], req.params.id);

}


    res.status(200).json({success:true,data:'',error:'',message:'the update run correct'});
    
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});




router.post('/', async (req, res) => {
   const payload = req.body
  // const getPaylod = verifyToken(req)
  // if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  console.log('body route', req.body);
  try {
    let Transmit = await transmit.insert(payload.dataRecord)
    const id= Transmit.data[0].trSeg
    console.log('id',id);
    let hospitalmid
    let length=payload.hospitalTrans.length
    console.log('length',length);
    for (let i = 0; i < length; i++) { 
      
      hospitalmid = await Hospitalmid.insert(payload.hospitalTrans[i],id) }

    res.status(200).json(Transmit)
  }
  catch (error) {
    console.log('error',error)
    res.status(400).json(notifyMessage(false, 'Transmit was not inserted', '', error))

  }

})

router.delete('/delete/:id', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let Transmit = await transmit.delete(req.params.id)
    res.status(200).json(Transmit)
  }
  catch (error) {
    res.status(400).json(notifyMessage(false, 'Transmit was not get by id', '', error))

  }

})

module.exports = router