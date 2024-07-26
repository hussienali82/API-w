const router = require("express").Router();
const RequestOnline = require("../models/RequestOnline");
const Request = require("../models/Request");
const RequestsDetails = require("../models/Requests_details");
const { notifyMessage } = require("../utils/notification");
const { verifyToken } = require("../auth/jwt");


router.get("/", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requestOnline = await RequestOnline.all();
    // console.log("requestOnline", requestOnline)
    let reqestData = [];
    for (const details of requestOnline.data) {
      let requestsDetails = await RequestsDetails.byOnlineReqID(details.id);
      // console.log("requestsDetails", requestsDetails);
      let detailsData = requestsDetails.data;
      let reqData = {
        ...details,
        details: detailsData,
      };
      reqestData.push(reqData);
    }
    res.status(200).json(notifyMessage(true, "Read succefuly", reqestData, null));
  } catch (error) {

    console.log("error", error)
    res.status(400).json(notifyMessage(false, "Request Online was not get", "", error));
  }
});
// get request with details day by day
router.get("/days", async (req, res) => {
  try {
    //check token
    const getPaylod = verifyToken(req);
    if (getPaylod.verify == false)
      return res.status(400).json(notifyMessage(false, "Authentication error", "", getPaylod.msg));
    // get requests counts by created date
    let requestOnline = await RequestOnline.CountDay(getPaylod.msg);
    let reqestDaysData = [];
    // loop for created day
    for (const requestsDays of requestOnline.data) {
      // get requests by evert created day 
      let requestsData = await RequestOnline.byCreatedDate(requestsDays.req_date, getPaylod.msg);
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
    res.status(400).json(notifyMessage(false, "Request Online was not get", "", error));
  }
});

router.post("/", async (req, res) => {
  try {
    //check token
    const getPaylod = verifyToken(req);
    if (getPaylod.verify == false)
      return res.status(400).json(notifyMessage(false, "Authentication error", "", getPaylod.msg));
    // let body = req.body;
    // console.log("body", req.body)            
    let requests = req.body.requests;
    console.log("requests", requests);
    for (let body of requests) {
      body.created_by = getPaylod.msg.id
      let request = await Request.insert(body);
      if (!request.success) {
        console.log("request.err", request.err)
        return res.status(400).json(notifyMessage(false, "request was not inserted", "", request.err));
      }
      let bodydetails = await RequestsDetails.insert(body);
      if (!bodydetails.success) {
        console.log("bodydetails.err", bodydetails.err)
        return res.status(400).json(notifyMessage(false, "request details was not inserted", "", bodydetails.err));
      }
      let updateRequestDownload = await RequestOnline.updateComplete(body.req_id)
      if (!updateRequestDownload.success) {
        return res.status(400).json(notifyMessage(false, "request downloaded was not updated", "", bodydetails.err));
      }
    }
    res.status(200).json(notifyMessage(true, "requests inserted successfuly", req.body.req_date, ""));
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

router.put("/id/:id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let request_online = await RequestOnline.update(req.body, req.params.id);
    res.status(200).json(request_online);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

router.get('/byNanoId/:id', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    // let request_online = await RequestOnline.byNanoId(req.params.id)
    // res.status(200).json(request_online)
    let requestOnline = await RequestOnline.byNanoId(req.params.id)
    // console.log("requestOnline", requestOnline)
    let reqestData = [];
    for (const details of requestOnline.data) {
      let requestsDetails = await RequestsDetails.byOnlineReqID(details.id);
      // console.log("requestsDetails", requestsDetails);
      let detailsData = requestsDetails.data;
      let reqData = {
        ...details,
        details: detailsData,
      };
      reqestData.push(reqData);
    }
    res
      .status(200)
      .json(notifyMessage(true, "Read succefuly", reqestData, null));
  }
  catch (error) {
    console.log("error", error)
    res.status(400).json(error)
  }

})

module.exports = router;
