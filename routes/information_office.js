const router = require("express").Router();
const { error } = require("@hapi/joi/lib/types/alternatives");
const information_office = require("../models/InformationOffice");
const category = require("../models/InformationOffice");
const { notifyMessage } = require("../utils/notification");
const { verifyToken } = require('../auth/jwt')

router.get("/", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let InformationOffice = await information_office.all();
    res.status(200).json(InformationOffice);
  } catch (error) {
    res
      .status(400)
      .json(notifyMessage(false, "category was not get", "", error));
  }
});

router.get("/id/:id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let InformationOffice = await information_office.byid(req.params.id);
      res.status(200).json(InformationOffice);
    } catch (error) {
      res
        .status(400)
        .json(notifyMessage(false, "category was not get by id", "", error));
    }
  });

  router.put("/id/:id", async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let InformationOffice = await information_office.update(req.body, req.params.id);
      res.status(200).json(InformationOffice);
    } catch (error) {
      console.log("error", error);
      res.status(400).json(error);
    }
  });

  router.post("/", async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let InformationOffice = await information_office.insert(req.body);
      res.status(200).json(InformationOffice);
    } catch (error) {
      res
        .status(400)
        .json(notifyMessage(false, "InformationOffice was not inserted", "", error));
    }
   
  });

  router.delete("/delete/:id", async (req, res) => {
    const getPaylod = verifyToken(req)
    if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
    try {
      let InformationOffice = await information_office.delete(req.params.id);
      res.status(200).json(InformationOffice);
    } catch (error) {
      res
        .status(400)
        .json(notifyMessage(false, "information_office was not get by id", "", error));
    }
  });
  

module.exports = router;
