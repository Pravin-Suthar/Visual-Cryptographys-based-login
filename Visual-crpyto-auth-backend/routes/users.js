const express = require("express");
const {
  registerExaminer,
  otpGenerator,
  verifyOTP,
  getUserNameById
} = require("../controllers/users");
const router = express.Router();

router.route("/register").post(registerExaminer);
router.route("/login").post(otpGenerator);
router.route("/verifyOtp").post(verifyOTP);
router.route("/getUserName").post(getUserNameById);

module.exports = router;
