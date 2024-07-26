const router = require('express').Router()
const identification = require('../models/Identification')
const { notifyMessage } = require('../utils/notification')
const { verifyToken } = require('../auth/jwt')
const { JSEncrypt } = require('js-encrypt')
const fs = require('fs')
const { imgPath } = require('../utils/paths')

router.get('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {

        let Identification = await identification.all()
        res.status(200).json(Identification)
    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(notifyMessage(false, 'identification was not get', '', error))
    }
})

router.get('/StopPrint', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let Identification = await identification.StopPrint(req.params.id)
        res.status(200).json(Identification)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'identification was not get', '', error))

    }

})
//search
router.get('/is_print/:is_print/date1/:date1/date2/:date2', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let Identification = await identification.issearchPrint(req.params.is_print, req.params.date1, req.params.date2)
        res.status(200).json(Identification)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'identification was not get', '', error))

    }

})
router.get('/is_print/:is_print', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let Identification = await identification.isPrint(req.params.is_print)
        res.status(200).json(Identification)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'identification was not get', '', error))
    }

})
router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let Identification = await identification.byid(req.params.id)
        res.status(200).json(Identification)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'identification was not get by id', '', error))

    }

})
router.put('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let Identification = await identification.update(req.body)
        res.status(200).json(Identification)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'identification was not update', '', error))

    }
})

router.put('/quality', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let Identification = await identification.updateQuality(req.body)
        res.status(200).json(Identification)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(notifyMessage(false, 'identification quality was not update', '', error))

    }
})
router.put('/recieve', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        //check token
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
        let body = {
            ...req.body,
            updated_by: getPaylod.msg.id
        }
        let Identification = await identification.updateRecieve(body)
        res.status(200).json(Identification)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(notifyMessage(false, 'identification recieve was not update', '', error))

    }
})
// generate qr 
const qrCode = (name1, name2, name3, idnum) => {

    // const secretData = "2972867785,فؤاد,سالم,سليم"
    const secretData = `${idnum},${name1},${name2},${name3}`
    const publicKey = `-----BEGIN PUBLIC KEY-----
    MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+7GydcXJ4Xe8OU+ZDdbmo
    KOMWXKMRHw15cmp2S5LLtzatL+kpR5/89H4Zwn6cPjCO0YSTfoWXgM+3BONbHqm
    5gQUc3YrHkUFUROYI4lJY6W1SaNohSwf6MpNOJ8d9t6+3LSF3Bgb96tYy2UpYCZX0
    s+DsJp8XkAhhvjceMWKqQIDAQAB
    -----END PUBLIC KEY-----`

    // Encrypt with the public key using JSEncrypt...
    var encrypt = new JSEncrypt()
    encrypt.setPublicKey(publicKey)
    var encrypted = encrypt.encrypt(secretData)

    // console.log("encrypted", encrypted)
    return encrypted
}
// generate idnum
const makeid = (dt, gen) => {
    console.log("dt", dt);
    var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        result = ""
    for (var i = 2; i > 0; --i)
        result += chars[Math.round(Math.random() * (chars.length - 1))];
    let year = dt.getFullYear().toString().substr(-2);
    var x = year + gen.toString() + result + (Math.floor(Math.random() * 90000) + 10000).toString();
    return x
}

// image base64 function
const getImg64 = (img) => {
    let filePath = imgPath + '/' + img
    return new Promise((resolve, reject) => {
        fs.readFile(filePath, { encoding: 'base64' }, (err, base64String) => {
            if (err) {
                console.log("err", err)
                return reject(null)
            }
            return resolve("data:image/jpeg;base64," + base64String)
        })
    })
}

router.post('/', async (req, res) => {
    let body = req.body
    // console.log('laith',body)
    let chkInsert = true
    try {
        //check token
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));

        for (const item of body) {

            //    console.log("item", item);
            
            if (item.license_id === 3){
                let IDNum = item.idw_previous
                item.idnum = IDNum
            }
            else{
                let IDNum = makeid(new Date(item.birdate), item.gender_type)
                item.idnum = IDNum
            }
            
            // item.idnum = IDNum
            item.qr_code = qrCode(item.name1, item.name2, item.name3, IDNum)
            item.created_by = getPaylod.msg.id
            item.updated_by = getPaylod.msg.id
            item.img_print = await getImg64(item.pict)
            let stopPrint = await identification.StopPrint(item.id)
            // console.log('stopPrint', stopPrint)
            if (stopPrint.success == false) {
                // console.log("stopPrint.err", stopPrint.err)
                return res.status(400).json(notifyMessage(false, 'identification was not inserted', '', stopPrint.err))
            }
            if (stopPrint.data.length <= 0) {
                // update is_print 3 for any person
                if (item?.is_print === 2 || item?.is_print === 3) {
                    let is_print = item?.is_print === 2 ? 5 : 1
                    let update_identification = await identification.updateRePrint(item, is_print)
                    if (update_identification.success == false) {
                        // console.log("stopPrint.err", stopPrint.err)
                        return res.status(400).json(notifyMessage(false, 'identification was not updated', '', update_identification.err))
                    }
                }
                let Identification = await identification.insert(item)
                if (Identification.success === false) {
                    chkInsert = false
                    console.log("Identification.err", Identification.err)
                    return res.status(400).json(notifyMessage(false, 'identification was not inserted', '', Identification.err))
                }
            }


        }
        if (chkInsert === true) {
            res.status(200).json(notifyMessage(true, 'identification insert true', null, null))
        } else {
            res.status(400).json(notifyMessage(false, 'identification was not inserted', '', 'error in one record'))
        }
    } catch (error) {
        console.log("error", error)
        res.status(400).json(notifyMessage(false, 'identification was not inserted', '', error))
    }
})

router.get('/oldwid/:idnum', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let Identification = await identification.oldwid(req.params.idnum)
        res.status(200).json(Identification)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'identification was not get by id', '', error))

    }

})

module.exports = router