const express = require("express");
const router = express.Router();
const { v4: uuid4 } = require('uuid');
const fs = require("fs");
const multer = require("multer");
const path = require('path');
const Biometric = require('../models/Biometric')
const { notifyMessage } = require('../utils/notification')
const { verifyToken } = require("../auth/jwt");
const { biometricPath } = require("../utils/paths")
// multer 
const storage =
    multer.diskStorage({
        destination: (req, file, cb) => {
            cb(null, biometricPath)
        },
        filename: (req, file, cb) => {
            const ext = file.mimetype.split("/")[1];
            cb(null, `${uuid4()}.${ext === "octet-stream" ? "dat" : ext}`);
        }
    })

const upload = multer({
    storage: storage
})

// upload image to storage 
router.post('/biometric/id/:id', upload.array("file", 2), async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));


    console.log("body", req.body);
    console.log("files", req.files);
    let files = req.files
    let fileNames = { dat: '', xml: '' }
    for (const file of files) {
        const targetPathUrl = path.join(__dirname, biometricPath + "/" + file.filename);
        try {
            if (file.originalname.match(/\.(dat|DAT|xml|XML)$/)) {
                const ext = file.mimetype.split("/")[1];
                ext === "xml" ? fileNames.xml = file.filename : fileNames.dat = file.filename
                fs.rename(file.path, targetPathUrl, err => { })
            } else {
                return res.json({ success: false, message: 'Only image files (jpg, jpeg, png) are allowed!', data: {}, error: err })
            }

        } catch (error) {
            console.log("error", error);
            res.status(400).json(notifyMessage(false, 'biometric file upload error !', {}, error))
        }

    }
    try {
        const getPaylod = verifyToken(req);
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, "Authentication error", "", getPaylod.msg));

        let bodyBio = {
            id: req.params.id,
            fing_dat: fileNames.dat,
            fing_xml: fileNames.xml,
            updated_by: getPaylod.msg.id
        }
        console.log("bodyBio",bodyBio);
        let biometricUpdate = await Biometric.update(bodyBio)
        res.status(200).json(biometricUpdate)
    } catch (error) {
        console.log("err", error)
        res.status(400).json(error)

    }



    // {
    //     success: true,
    //         message: "uploaded successfully",
    //             // url: `/${file.path}`,
    //             filename: fileNames
    //     // error: [] 
    // });
    // console.log(files); 
})



module.exports = router;