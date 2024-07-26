const router = require('express').Router()
const Requesst = require('../models/Request')
const RequestsDetails = require('../models/Requests_details')
const { notifyMessage } = require('../utils/notification')
const { verifyToken } = require("../auth/jwt");
const { sendsms } = require('../utils/send_sms')

router.get('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let requesst = await Requesst.all()
        res.status(200).json(requesst)
    }
    catch (error) {
        res.status(400).json(error)

    }

})

router.get('/approval', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let requesst = await Requesst.byApprove()
        let reqestData = [];
        for (const details of requesst.data) {
            let requestsDetails = await RequestsDetails.byReqID(details.id);
            let detailsData = requestsDetails.data;
            let reqData = {
                ...details,
                details: detailsData,
            };
            reqestData.push(reqData);
        }
        res.status(200).json(notifyMessage(true, "Read succefuly", reqestData, null));
    }
    catch (error) {
        res.status(400).json(error)

    }
})

router.get('/approvaldays', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        //check token
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
        // get requests counts by created date
        let request = await Requesst.byApproveDays(getPaylod.msg);
        let reqestDaysData = [];
        // loop for created day
        for (const requestsDays of request.data) {
            // get requests by evert created day 
            let requestsData = await Requesst.byCreatedApprovDate(requestsDays.req_date,getPaylod.msg);
            // add requests array to count day 
            let reqdayData = {
                ...requestsDays,
                requests: requestsData.data
            };
            // push requests to count day array
            reqestDaysData.push(reqdayData);
        }

        res.status(200).json(notifyMessage(true, "Read succefuly", reqestDaysData, null));
    } catch (error) {
        console.log("error", error)
        res.status(400).json(error);
    }
})

router.get('/approval/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let requesst = await Requesst.byApproveWithID(req.params.id)
        res.status(200).json(notifyMessage(true, "Read succefuly", requesst, null));
    }
    catch (error) {
        console.log("error", error)
        res.status(400).json(error)
    }
})

router.get('/notapproval', async (req, res) => {
    try {
        //check token
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
        let requesst = await Requesst.byNotApprove()
        let reqestData = [];
        for (const details of requesst.data) {
            console.log("details", details)
            let requestsDetails = await RequestsDetails.byReqID(details.id);
            let detailsData = requestsDetails.data;
            let reqData = {
                ...details,
                details: detailsData,
            };
            reqestData.push(reqData);
        }
        res.status(200).json(notifyMessage(true, "Read succefuly", reqestData, null));
    }
    catch (error) {
        console.log("error", error)
        res.status(400).json(error)

    }
})

router.get('/notapprovaldays', async (req, res) => {
    try {
        //check token
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
        // get requests counts by created date
        let request = await Requesst.byNotApproveDays(getPaylod.msg);
        let reqestDaysData = [];
        // loop for created day
        for (const requestsDays of request.data) {
            // get requests by evert created day 
            let requestsData = await Requesst.byCreatedDate(requestsDays.req_date,getPaylod.msg);
            // add requests array to count day 
            let reqdayData = {
                ...requestsDays,
                requests: requestsData.data
            };
            // push requests to count day array
            reqestDaysData.push(reqdayData);
        }

        res.status(200).json(notifyMessage(true, "Read succefuly", reqestDaysData, null));
    } catch (error) {
        console.log("error", error)
        res.status(400).json(error);
    }
})

//with code
router.get('/withcode', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let requesst = await Requesst.all2()
        res.status(200).json(requesst)
    }
    catch (error) {
        res.status(400).json(error)

    }

})

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let requesst = await Requesst.byid(req.params.id)
        res.status(200).json(requesst)
    }
    catch (error) {
        console.log("error", error)
        res.status(400).json(error)
    }

})

router.put('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let requesst = await Requesst.update(req.body)
        res.status(200).json(requesst)
    }
    catch (error) {

        res.status(400).json(error)
    }
})
router.put('/ministerpart', async (req, res) => {
    try {
        let chkUpdate = true
        let detailsBody = req.body.requests
        //check token
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
        for (let detail of detailsBody) {
            detail.approv_num = req.body.approv_num
            detail.approv_date = req.body.approv_date
            detail.updated_by = getPaylod.msg.id
            let requesst = await Requesst.updatepartMinister(detail)
            if (!requesst.success) {
                chkUpdate = false
                return res.status(400).json(notifyMessage(false, 'request update error', '', requesst.err));
            }
            // send sms
            let sms = await sendsms(`اجازات السلاح\r\nحصلت موافقة هوية السلاح٫ يرجى مراجعة مديرية الهويات لاكمال المتطلبات\r\nوزارة الداخلية\r\nمكتب الوزير`,detail.phone)
            if (!sms.success) {
                chkUpdate = false
                return res.status(400).json(notifyMessage(false, 'SMS does not send', '', sms.msg));
            }
        }
        if (chkUpdate == true) {
            res.status(200).json(notifyMessage(true, 'requests update true', null, null))
        } else {
            res.status(200).json(notifyMessage(false, 'requests update error', '', 'error insert in one record'))
        }
    }
    catch (error) {

        res.status(400).json(error)
    }
})

router.put('/minister', async (req, res) => {
    try {
        let chkUpdate = true
        let detailsBody = req.body.requests
        //check token
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));

        for (let detail of detailsBody) {
            detail.approv_num = req.body.approv_num
            detail.approv_date = req.body.approv_date
            detail.approval_role = req.body.approval_role
            detail.wea_hold_per = req.body.wea_hold_per
            detail.margin_app = req.body.margin_app
            detail.identity_type = req.body.identity_type
            detail.updated_by = getPaylod.msg.id
            let requesst = await Requesst.updateMinister(detail)
            if (!requesst.success) {
                chkUpdate = false
                return res.status(400).json(notifyMessage(false, 'request update error', '', requesst.err));
            }

            let reqDetails = await RequestsDetails.updateacceptminster(detail)
            // console.log("reqDetails", reqDetails)
            if (!reqDetails.success) {
                chkUpdate = false
                return res.status(400).json(notifyMessage(false, 'request details update error', '', reqDetails.err));
            }

            // send sms
            let sms = await sendsms(`اجازات السلاح\r\nحصلت موافقة هوية السلاح٫ يرجى مراجعة مديرية الهويات لاكمال المتطلبات\r\nوزارة الداخلية\r\nمكتب الوزير`,detail.phone)
            if (!sms.success) {
                chkUpdate = false
                return res.status(400).json(notifyMessage(false, 'SMS does not send', '', sms.msg));
            }
        }
        if (chkUpdate == true) {
            res.status(200).json(notifyMessage(true, 'request details update true', null, null))
        } else {
            res.status(200).json(notifyMessage(false, 'request details update error', '', 'error insert in one record'))
        }

    }
    catch (error) {
        console.log('error', error)
        res.status(400).json(error)
    }
})
router.put('/ministerdelete', async (req, res) => {
    try {
        let chkUpdate = true
        let detailsBody = req.body.requests
        //check token
        const getPaylod = verifyToken(req)
        if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
        for (let detail of detailsBody) {
            detail.approv_num = req.body.approv_num
            detail.completed = 0
            detail.note = "رفض مكتب الوزير: " + req.body.note
            let requesst = await Requesst.Ministerdelete(detail)
            if (!requesst.success) {
                chkUpdate = false
                return res.status(400).json(notifyMessage(false, 'request update error', '', requesst.err));
            }

            let reqDetails = await RequestsDetails.updatedeleteminster(detail)
            if (!reqDetails.success) {
                chkUpdate = false
                return res.status(400).json(notifyMessage(false, 'request details update error', '', reqDetails.err));
            }

        }

        if (chkUpdate == true) {
            res.status(200).json(notifyMessage(true, 'request details update true', null, null))
        } else {
            res.status(200).json(notifyMessage(false, 'request details update error', '', 'error insert in one record'))
        }
    }
    catch (error) {
        console.log('error', error)
        res.status(400).json(error)
    }
})




router.post('/', async (req, res) => {
    try {
        //check token
        const getPaylod = verifyToken(req);
        if (getPaylod.verify == false)
            return res.status(400).json(notifyMessage(false, "Authentication error", "", getPaylod.msg));
        let body = {
            ...req.body,
            created_by: getPaylod.msg.id
        }
        let requesst = await Requesst.insert(body)
        res.status(200).json(requesst)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'requesst was not inserted', '', error))

    }

})

module.exports = router