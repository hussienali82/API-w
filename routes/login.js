const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
// const { loginUser } = require("../utils/validations");
const { notifyMessage } = require("../utils/notification");
const User = require("../models/Users");
const bcrypt = require("bcryptjs");
const { v4: uuid4 } = require("uuid");
// const Audit = require('../models/Audit')

//routers
router.post("/", async (req, res) => {
  //login Validation
  // const { error } = loginUser(req.body);
  // if (error) return res.status(400).json(notifyMessage(false, 'Validation error', '', error.details[0].message));
  try {
    let user = await User.login(req.body.username);
    console.log('user', user);
    if (!user.success) {
      console.log("error login", user.err);
      return res.status(400).json(user.err);
    }

    // if (user.data[0].activation === false) {
    //   return res
    //     .status(400)
    //     .json(
    //       notifyMessage(
    //         false,
    //         "login error",
    //         {},
    //         { errActive: true, errMsg: "المستخدم غير نشط" }
    //       )
    //     );
    // }
    console.log("users", user);
    // if (user.success) {
      if (user.data) {
        //generate salted password
        // const password = req.body.password
        // const part1Length = password.length % 2 == 0 ? password.length / 2 : (password.length - 1) / 2
        // const part2Length = password.length - part1Length
        // const sub1Pass = password.substring(0, part1Length)
        // const sub2Pass = password.substring(password.length % 2 == 0 ? part2Length : part2Length - 1, password.length)
        // const saltedPwd = sub1Pass + user.data[0].usr_salt + sub2Pass
        //compare password
        if (!bcrypt.compareSync(req.body.password, user.data[0].password)) {

          // console.log("bycryot",bcrypt.compareSync(req.body.password, user.data[0].password));
          return res
            .status(400)
            .json(
              notifyMessage(
                false,
                "login error",
                {},
                "invalid username or password"
              )
            );
        }
        delete user.data[0].password;
        const token = jwt.sign({ sub: user.data[0] }, process.env.JWT_SECRET, {
          algorithm: "HS256",
          expiresIn: "8h",
        });
        console.log("users222222222222", user.data);

        // let auditbody = {
        //     id: uuid4(),
        //     table_name: "users",
        //     id_record: user.data[0].id,
        //     action_type: "Login",
        //     new_value: JSON.stringify(user.data[0]),
        //     action_by: user.data[0].id
        // }
        // await Audit.insert(auditbody)
        res.status(200).json(notifyMessage(true, "login successful", token, {}));
      } else {
        // console.log("dataErr",user.data)
        res
          .status(400)
          .json(
            notifyMessage(
              false,
              "login error",
              {},
              "Invalid username or password"
            )
          );
      }
    // } else {
      // console.log("successErr",user.success);
      // res
        // .status(400)
        // .json(
          // notifyMessage(
            // false,
            // "login error",
            // {},
            // "invalid username or password"
          // )
        // );
    // }
  } catch (error) {
    console.log("error", error);
    res.status(400).json(error);
  }
});

//export router
module.exports = router;
