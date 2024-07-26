const router = require('express').Router()
const { notifyMessage } = require('../utils/notification')
const { verifyToken } = require('../auth/jwt')
const FinanciAccounts = require('../models/FinanciAccounts')


// router.get('/', async (req, res) => {
//     try {
//         let approvals = await Approvals.all()
//         res.status(200).json(approvals)
//     }
//     catch (error) {
//         res.status(400).json(notifyMessage(false, 'approvals was not get', '', error))


router.get('/regid/:regid', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));


    try {

        let finance = await FinanciAccounts.byreqid(req.params.regid)
        res.status(200).json(finance)

    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)
    }

})

router.get('/paymantable', async (req, res) => {

    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));


    try {

        let finance = await FinanciAccounts.paymantable()
        res.status(200).json(finance)

    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)
    }

})
router.get('/countfinance/:regid', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));


    try {

        let finance = await FinanciAccounts.CountFinancialTable(req.params.regid)
        res.status(200).json(finance)

    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)
    }

})
router.get('/countPaymanTable/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));


    try {

        let finance = await FinanciAccounts.Countpaymantable()
        res.status(200).json(finance)

    }
    catch (error) {
        console.log("err", error)
        res.status(400).json(error)
    }

})


router.put('/', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
        let finance = await FinanciAccounts.update(req.body[0])
        res.status(200).json(finance)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(notifyMessage(false, 'finance  was not update', '', error))

    }

})
router.put('/updatePaymant', async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));

    try {
        let finance = await FinanciAccounts.updatePaymant(req.body)
        res.status(200).json(finance)
    }
    catch (error) {
        console.log("err", error);
        res.status(400).json(notifyMessage(false, 'finance  was not update', '', error))

    }

})



router.post('/', async (req, res) => {
    console.log('req.body', req.body)
    let body = req.body
    //count of paymant table 
    let Count1 = await FinanciAccounts.Countpaymantable()
    let CountPaymanTable = Count1.data[0].count
    // count of numper of records that have same req_id 
    let count2 = await FinanciAccounts.CountFinancialTable(body.req_id)
    let CountFinancialTable = count2.data[0].count

console.log('CountFinancialTable',CountFinancialTable)
console.log('CountPaymanTable',CountPaymanTable)
    try {
        let finance
        //check token
        const getPaylod = verifyToken(req);
        if (getPaylod.verify == false)
            return res.status(400).json(notifyMessage(false, "Authentication error", "", getPaylod.msg));
        // let body = {
        //     ...req.body,
        //     created_by: getPaylod.msg.id
        // }
        for (const item of body.financeAddEddit) {
            // compare the counts of records in finance table with count of paymant table 
            // if count finance greater or equall return 
            if (CountFinancialTable >= CountPaymanTable)

                return res.status(400).json(notifyMessage(false, "count finance greater than paymant or equall", "", getPaylod.msg))

            console.log('body', item);
            finance = await FinanciAccounts.insert(item, body.req_id)

        }
        res.status(200).json(finance)
    }
    catch (error) {
        console.log('error', error);
        res.status(400).json(notifyMessage(false, 'finance was not inserted', '', error))

    }

})
router.post("/insertPayment", async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    
    try {
      let finance = await FinanciAccounts.insertPayment(req.body);
      res.status(200).json(finance);
    } catch (error) {
      res
        .status(400)
        .json(notifyMessage(false, "Payment was not inserted", "", error));
    }
  });
  router.delete("/id/:id", async (req, res) => {
    console.log('req.body',req.body);
    try {
      let finance = await FinanciAccounts.delete(req.params.id);
      res.status(200).json(finance);
    } catch (error) {
      res
        .status(400)
        .json(notifyMessage(false, "paymant_amount was not delete", "", error));
    }
  });
module.exports = router