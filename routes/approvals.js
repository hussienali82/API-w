const router = require('express').Router()
const Approvals = require('../models/Approvals')
const { notifyMessage } = require('../utils/notification')
const { verifyToken } = require('../auth/jwt')
const Requests_details = require('../models/Requests_details')

router.get('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let approvals = await Approvals.all()
        res.status(200).json(approvals)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'approvals was not get', '', error))

    }

})

router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let approvals = await Approvals.byid(req.params.id)
        res.status(200).json(approvals)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'approvals was not get by id', '', error))

    }

})
router.get('/count/:req_details_id', async (req, res) => {

    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    let userBody = getPaylod.msg
    try {
        let approvals = await Approvals.count(req.params.req_details_id, userBody)
        res.status(200).json(approvals)
    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)

    }

})
router.get('/countrole/:req_details_id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    let userBody = getPaylod.msg

    let destRoleType = getPaylod.msg.role_type
    let destID = getPaylod.msg.approval_det_id
    try {
        let approvals = await Approvals.countRoleType(req.params.req_details_id, userBody)
        res.status(200).json(approvals)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'approvals was not get by id', '', error))

    }

})
router.get('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let approvals = await Approvals.byid(req.params.id)
        res.status(200).json(approvals)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'approvals was not get by id', '', error))

    }

})

router.get('/regid/:regid', async (req, res) => {
    //check token
    const getPaylod = verifyToken(req)

    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    let destRoleType = getPaylod.msg.role_type
    let destID = getPaylod.msg.approval_det_id
    let userType = getPaylod.msg.user_type
    try {
        if (destRoleType == 0) {
            res.status(400).json(notifyMessage(false, 'Authorization faild', [], 'You donot have destination role'))
        } else {
            let approvals = await Approvals.byreqid(req.params.regid, destID, destRoleType,userType)
            res.status(200).json(approvals)
        }
    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)
    }

})
router.get('/statusCount/:statusCount', async (req, res) => {
    //check token
    const getPaylod = verifyToken(req)
    let destRoleType = getPaylod.msg.role_type
    let destID = getPaylod.msg.approval_det_id


    try {
        if (destRoleType == 0) {
            res.status(400).json(notifyMessage(false, 'Authorization faild', [], 'You donot have destination role'))
        } else {
            let approvals = await Approvals.status1(req.params.statusCount, destID)
            res.status(200).json(approvals)
        }
    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)
    }

})
router.get('/statusCount2/:statusCount2', async (req, res) => {
    //check token
    const getPaylod = verifyToken(req)
    let destRoleType = getPaylod.msg.role_type
    let destID = getPaylod.msg.approval_det_id
    let subid = getPaylod.msg.sudid


    try {


        if (destRoleType == 0) {
            res.status(400).json(notifyMessage(false, 'Authorization faild', [], 'You donot have destination role'))
        } else {
            let approvals = await Approvals.status2(req.params.statusCount2, subid)
            res.status(200).json(approvals)
        }
    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)
    }

})


// Create by Mohammed A.
router.get('/all_data', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    
    let data = [];
            let approvals = await Approvals.all_data()

            approvals.data.map((row)=> {
            //    console.log(row.created_at);
            if (row.approval_dest_id === data.find((x)=> x.approval_dest_id != row.approval_dest_id))
            // console.log(row.created_at);
               data.push(row)

            })
            

            // approvals.data = data;
            res.status(200).json(data)
       
})

router.put('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let approvals = await Approvals.update(req.body)
        res.status(200).json(approvals)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'approvals was not update', '', error))

    }

})

router.post('/', async (req, res) => {
    // body info
    const payload = req.body
    let Status = payload.status

    console.log('payload', payload)
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false)
        return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    // get token info --------------------------------------------------------
    console.log('getPaylod.msg', getPaylod.msg)
    let destRoleType = getPaylod.msg.role_type
    let destID = getPaylod.msg.approval_det_id
    let userType = getPaylod.msg.user_type
    let subRoleType = getPaylod.msg.sudrultype
    let subid = getPaylod.msg.sudid



    //console.log('destRoleTypetypeof', subRoleType)
    //console.log('destRoleTypetypeof', typeof(subid))

    // get complet value from request_details
    let getcompleted = await Requests_details.getCompleted(payload.req_details_id)
    let completed = getcompleted.data[0].completed


    let pprov_Stat_Count;
    let identi_Stat_Count;
    console.log('userType', userType, 'Status', Status, 'destRoleType', destRoleType, 'payload.completed', completed, 'subRoleType',
    
    subRoleType,"pprov_Stat_Count", pprov_Stat_Count,"identi_Stat_Count", identi_Stat_Count)
    console.log('anas','destRoleType',destRoleType, 'pprov_Stat_Count',pprov_Stat_Count)

 
    
    //count of  aprovals status
    // let pprov_Stat_Count = payload.approvalStatusCount
    // count of identification status
    // let identi_Stat_Count = payload.identificationStatusCount

    // console.log('Status', Status, 'identi_Stat_Count', identi_Stat_Count, 'userType', userType, 'destRoleType', destRoleType, 'payload.completed', payload.completed)
    try {
        // If I login in  approvals_managment users (user_type=2) :
        //1- check if completed = (1 or 0)  out from check else  continue  check 
        //2- if count of aprovals_managment status > 0 then completed = 2
        // If I login in  iditification_managment users (user_type=1) 
        // 1- if count identifications status = 0 and subRoleType> 0 then completed = 1 else 0
       
        if (userType === 1) {
            let appStatus2 = await Approvals.status2(payload.req_details_id, subid)
            identi_Stat_Count = parseInt(appStatus2.data[0].count)
            console.log("identi_Stat_Count", appStatus2.data)
            if (userType === 1 && subRoleType === 2 && identi_Stat_Count === 0) {
                if (Status === '0') {
                    let requests_details = await Requests_details.updateComplete(payload, 0)
                    if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
    
                }
                else if (Status === '1') {
                    let requests_details = await Requests_details.updateComplete(payload, 'default')
                    if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
    
                }
            }
            else if (userType === 1 && subRoleType === 2 && identi_Stat_Count >= 1) {
                let requests_details = await Requests_details.updateComplete(payload, 0)
                if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
    
    
            }
            else if (userType === 1 && subRoleType === 3) {
                if (Status === '0') {
                    let requests_details = await Requests_details.updateComplete(payload, 0)
                    if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
    
                }
                else if (Status === '1') {
                    let requests_details = await Requests_details.updateComplete(payload, 1)
                    if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
    
                }
    
    
            }
           
        }
        if (userType === 2) {
            let appStatus1 = await Approvals.status1(payload.req_details_id, destID)
            pprov_Stat_Count = parseInt(appStatus1.data[0].count)
    
            console.log("pprov_Stat_CountAnas", pprov_Stat_Count)
            if (destRoleType === 1 && Status === '0' && (completed === 2 || completed === null)) {
                let requests_details = await Requests_details.updateComplete(payload, 2)
                if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
            }
            
            else if (destRoleType === 1 && Status === '1' && (completed === 2 || completed === null)) {
              
                if (pprov_Stat_Count === 0) {
                    let requests_details = await Requests_details.updateComplete(payload, null)
                    if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
                }
            }
            else if (destRoleType === 2   && pprov_Stat_Count ===0) {
                console.log("pprov_Stat_CountAnas2", pprov_Stat_Count)

                if (Status === '0') {
                    let requests_details = await Requests_details.updateComplete(payload, 0)
                    if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
    
                }
                else if (Status === '1') {
                    let requests_details = await Requests_details.updateComplete(payload, 'default')
                    if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
    
                }
            }
            else if (  destRoleType === 2 && pprov_Stat_Count >= 1) {
                console.log("pprov_Stafdfdfdfds2", pprov_Stat_Count)

                let requests_details = await Requests_details.updateComplete(payload, 0)
                if (!requests_details.success) return res.status(400).json(notifyMessage(false, 'update request completed error', '', requests_details.err));
    
    
            }
        }
        let approvals = await Approvals.insert(payload, destID, subid)
        res.status(200).json(approvals)
    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)

    }

})

router.put('/audit', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    const payload = req.body
    try {
        let approvals = await Approvals.updateAudit(payload)
        res.status(200).json(approvals)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'approvals was update audit', '', error))

    }

})

router.delete('/id/:id', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));

    try {
        let approvals = await Approvals.delete(req.params.id)
        res.status(200).json(approvals)
    }
    catch (error) {
        res.status(400).json(notifyMessage(false, 'approvals was not deleted', '', error))

    }

})



module.exports = router