const router = require("express").Router();
const Requests_details = require("../models/Requests_details");
const { notifyMessage } = require("../utils/notification");
const { verifyToken } = require("../auth/jwt");

router.get("/", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.all();
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

router.get("/approval", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.approval();
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});
router.get("/print", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.print();
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});
router.get("/fingerCount/id/:id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.biometricCountReqID(
      req.params.id
    );
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(notifyMessage(false, "print records was not get", "", error));
  }
});

router.get("/complet_id/:complet_id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.complet(
      req.params.complet_id
    );
    res.status(200).json(requests_details);
  } catch (error) {
    res
      .status(400)
      .json(notifyMessage(false, "requests_details was not get", "", error));
  }
});
router.get("/name/:name", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.name(req.params.name);
    res.status(200).json(requests_details);
  } catch (error) {
    res
      .status(400)
      .json(
        notifyMessage(false, "requests_details was not get by name", "", error)
      );
  }
});
router.get("/nameFinance/:name", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.name_finance(req.params.name);
    res.status(200).json(requests_details);
  } catch (error) {
    res
      .status(400)
      .json(
        notifyMessage(false, "requests_details was not get by name", "", error)
      );
  }
});
router.get("/namedelivery/:name", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.name_delivery(req.params.name);
    res.status(200).json(requests_details);
  } catch (error) {
    res
      .status(400)
      .json(
        notifyMessage(false, "requests_details was not get by name", "", error)
      );
  }
});
router.get("/idnumdelivery/:idnum", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.idnume_delivery(req.params.idnum);
    res.status(200).json(requests_details);
  } catch (error) {
    res
      .status(400)
      .json(
        notifyMessage(false, "requests_details was not get by name", "", error)
      );
  }
});
router.get("/nametracking/:name", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.nametracking(req.params.name);
    res.status(200).json(requests_details);
  } catch (error) {
    res
      .status(400)
      .json(
        notifyMessage(false, "requests_details was not get by name", "", error)
      );
  }
});

router.get("/tracking/:name", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.tracking(req.params.name);
    res.status(200).json(requests_details);
  } catch (error) {
    res
      .status(400)
      .json(
        notifyMessage(false, "requests_details was not get by name", "", error)
      );
  }
});

router.get("/id/:id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.byid(req.params.id);
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

router.get("/searchById/:id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.searchById(req.params.id);
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

router.get("/byReqID/:id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.byReqID(req.params.id);
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

router.get('/id/:id', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.byid(req.params.id)
    res.status(200).json(requests_details)
  }
  catch (error) {
    console.log("error", error)
    res.status(400).json(error)

  }

})

router.get('/id/:id/name/:name/idnum/:idnum', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.searchbyidnum(req.params.id, req.params.name, req.params.idnum)
    res.status(200).json(requests_details)
  }
  catch (error) {
    console.log("error", error)
    res.status(400).json(error)

  }

})
router.post("/", async (req, res) => {
  //check token
  const getPaylod = verifyToken(req);
  if (getPaylod.verify == false)
    return res.status(400).json(notifyMessage(false, "Authentication error", "", getPaylod.msg));
  let body =
  {
    ...req.body,
    created_by: getPaylod.msg.id
  }

  try {
    let requests_details = await Requests_details.insert(body);
    res.status(200).json(requests_details);
  } catch (error) {
    res.status(400).json(notifyMessage(false, "requests_details was not inserted", "", error)
    );
  }
});

router.put('/', async (req, res) => {
  try {
    //check token
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    let body = {
      ...req.body,
      updated_by: getPaylod.msg.id
    }

    let requests_details = await Requests_details.update(body)
    res.status(200).json(requests_details)
  }
  catch (error) {
    console.log('error', error);
    res.status(400).json(error)
  }

})

router.put("/updateName", async (req, res) => {
  try {
    //check token
    const getPaylod = verifyToken(req);
    if (getPaylod.verify == false)
      return res
        .status(400)
        .json(notifyMessage(false, "Authentication error", "", getPaylod.msg));
    let body = req.body;
    body.updated_by = getPaylod.msg.id;
    let requests_details = await Requests_details.updateNAme(body);
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res
      .status(400)
      .json(notifyMessage(false, "requests_details was not update", "", error));
  }
});

router.put("/minister", async (req, res) => {
  try {
    //check token
    const getPaylod = verifyToken(req);
    if (getPaylod.verify == false)
      return res.status(400).json(notifyMessage(false, "Authentication error", "", getPaylod.msg));
    let body = req.body;
    body.updated_by = getPaylod.msg.id;
    let requests_details = await Requests_details.updateMinister(body);
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

router.put('/deleteminister/:id', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.updatedeleteminster(req.body, req.params.id)
    res.status(200).json(requests_details)
  }
  catch (error) {
    console.log('error', error);
    res.status(400).json(error)
  }
})
router.put('/acceptminister', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.updateacceptminster(req.body)
    res.status(200).json(requests_details)
  }
  catch (error) {
    console.log('error', error);
    res.status(400).json(error)
  }
})

router.put('/biometric', async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {

    let requests_details = await Requests_details.updateBiometirc(req.body, req.body?.bioID)
    res.status(200).json(requests_details)
  }
  catch (error) {
    console.log('error', error);
    res.status(400).json(error)
  }
})

router.delete("/id/:id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let requests_details = await Requests_details.Delete(req.params.id);
    res.status(200).json(requests_details);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

module.exports = router
