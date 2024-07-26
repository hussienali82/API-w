const express = require("express");
const router = express.Router();
const pool = require("../db/index");
const { v4: uuid4 } = require('uuid');
const fs = require("fs");
const multer = require("multer");
const { imgPath } = require("../utils/paths")
const path = require('path');
const { notifyMessage } = require("../utils/notification");
const { verifyToken } = require('../auth/jwt')

//  // multer 
//  const storage = multer.diskStorage({ 

//      destination: (req, file, cb) => { 
//          cb(null, "./public/images") 
//      }, 
//      filename: (req, file, cb) => { 
//          const ext = file.mimetype.split("/")[1]; 
//          cb(null, `${uuid4()}.${ext}`); 
//      } 
//  }); 
//  const upload = multer({ 
//      storage: storage 
//  }) 
const upload = multer({
    dest: imgPath
    // you might also want to set some limits: https://github.com/expressjs/multer#limits
});

// upload image to storage 
router.post('/profile-image', upload.single("file"), (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        console.log("filee",req.files)
        // to declare some path to store your converted image
        const fileExtension = '.jpg'
        const fileName = uuid4() + fileExtension
        const path = imgPath + '/' + fileName
        const imgdata = req.body.file;
        // to convert base64 format into random filename
        const base64Data = imgdata.replace(/^data:([A-Za-z-+/]+);base64,/, '');
        fs.writeFileSync(path, base64Data, { encoding: 'base64' });
        res.status(200).json(notifyMessage(true, 'Upload Sucess', { path: path, filename: fileName }, ''))

    } catch (error) {
        console.log("err", error)
        res.json({ success: false, message: 'image file upload error !', data: {}, error: error })
    }
})



module.exports = router;