const express = require("express"); 
 const router = express.Router(); 
 const pool = require("../db/index"); 
 const { v4: uuid4 } = require('uuid'); 
 const fs = require("fs"); 
 const multer = require("multer"); 
 const { imgPath } = require("../utils/paths")
 const path = require('path'); 
 const { verifyToken } = require('../auth/jwt')
 
 // multer 
 const storage = multer.diskStorage({ 
  
     destination: (req, file, cb) => { 
         cb(null, imgPath) 
     }, 
     filename: (req, file, cb) => { 
         const ext = file.mimetype.split("/")[1]; 
         cb(null, `${uuid4()}.${ext}`); 
     } 
 }); 
 const upload = multer({ 
     storage: storage 
 }) 
  
 // upload image to storage 
 router.post('/profile-image', upload.single("file"), (req, res) => { 
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  
     const targetPathUrl = path.join(__dirname, imgPath + req.file.filename); 
     console.log("body",req.body)
     console.log("targetPathUrl",targetPathUrl)
     // console.log(baseUrl) 
     try { 
         // console.log("targetpath", targetPathUrl) 
         if (req.file.originalname.match(/\.(jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF)$/)) { 
             // console.log(req.file.originalname) 
             fs.rename(req.file.path, targetPathUrl, err => { 
                 // console.log("targetPathUrl", targetPathUrl) 
                 res.status(200).json({ 
                     success: true, 
                     message: "uploaded successfully", 
                     url: `/${req.file.path}`, 
                     filename: req.file.filename 
                     // error: [] 
                 }); 
  
             }) 
         } else { 
             res.json({ success: false, message: 'Only image files (jpg, jpeg, png) are allowed!', data: {}, error: err }) 
  
         } 
  
  
     } catch (error) { 
         res.json({ success: false, message: 'image file upload error !', data: {}, error: error }) 
     } 
  
  
     // console.log(req.files); 
 }) 
  
  
  
 module.exports = router;