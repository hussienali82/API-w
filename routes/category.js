const router = require("express").Router();
const category = require("../models/Category");
const { notifyMessage } = require("../utils/notification");
const { verifyToken } = require('../auth/jwt')

router.get("/", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let Category = await category.all();
    res.status(200).json(Category);
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
    let Category = await category.byid(req.params.id);
    res.status(200).json(Category);
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
    let Category = await category.update(req.body, req.params.id);
    res.status(200).json(Category);
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

router.post("/", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let Category = await category.insert(req.body);
    res.status(200).json(Category);
  } catch (error) {
    res
      .status(400)
      .json(notifyMessage(false, "category was not inserted", "", error));
  }
});

router.delete("/delete/:id", async (req, res) => {
  const getPaylod = verifyToken(req)
  if (getPaylod.verify == false) return res.status(400).json(notifyMessage(false, 'Authentication error', '', getPaylod.msg));
  try {
    let Category = await category.delete(req.params.id);
    res.status(200).json(Category);
  } catch (error) {
    res
      .status(400)
      .json(notifyMessage(false, "Category was not get by id", "", error));
  }
});

module.exports = router;
