const router = require('express').Router()
const users = require('../models/Users')
const {notifyMessage}=require ('../utils/notification')
const { verifyToken } = require('../auth/jwt')


router.get('/', async (req, res) => {
    //  const getPaylod = verifyToken(req)
    //  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Users = await users.all()
        res.status(200).json(Users)
    }
    catch(error) {
        console.log('error',error);
             res.status(400).json(notifyMessage(false, 'Users was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
     const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
       let Users= await users.byid(req.params.id)
        res.status(200).json(Users)
    }
    catch(error) {
             res.status(400).json(notifyMessage(false, 'Users was not get by id', '', error))

    }

    



})


router.post('/', async (req, res) => {
    const getPaylod = verifyToken(req)
   if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
   console.log('body route', req.body);
   try {
      let Users = await users.insert(req.body)
       res.status(200).json(Users)
   }
   catch(error) {
            res.status(400).json(notifyMessage(false, 'Users was not inserted', '', error))

   }

})


// router.post("/", async (req, res) => {
//   try {
//     const passwordDefault = "12345678";
//     let userBody = req.body;
//     userBody = {
//       ...userBody,
//       password: bcrypt.hashSync(passwordDefault, 10),
//       first_enter: true,
//       roles: JSON.stringify(userBody.roles),
//       created_at: moment().tz("Asia/Baghdad").format("Y-M-D H:m:s"),
//     };
//     let user = await User.insert(userBody);
//     res.status(200).json(user);
//   } catch (error) {
//     console.log("insertError", error);
//     res.status(400).json(error);
//   }
// });






module.exports = router