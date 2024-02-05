const { Sequelize } = require("sequelize");
const db = require("../models/index");

const generateOTPImage = require("../cryptography/imageGenerator");
const generateShares = require("../cryptography/cryptography");
const {
  sendOtpEmail,
  newAccountCreatedMail,
} = require("../middleware/sendEmail"); // Import your email service module
const { Examiner } = require("../models/examiner"); // Import the Examiner model
const OTP = db.tempOtp;
const Examinerdb = db.examiners;
const fs = require("fs");
const nodemailer = require("nodemailer");
const Jimp = require("jimp");
const { createCanvas, loadImage } = require("canvas");


exports.otpGenerator = async (req, res) => {
  try {
    const { email } = req.body; // Assuming you're getting the email from the request body.

    // Generate a new OTP
    function generateOTP(length) {
      const chars = "0123456789";
      let otp = "";
      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * chars.length);
        otp += chars[randomIndex];
      }
      return otp;
    }
    
    // Generate a random OTP
    const otp = "567679";

    // Create a canvas for the image
    const canvas = createCanvas(350, 350);
    const context = canvas.getContext("2d");
    
    // Set the background color
    context.fillStyle = "#ffffff";
    context.fillRect(0, 0, canvas.width, canvas.height);
    
    // Set the text properties
    context.fillStyle = "#000000";
    context.textBaseline = "middle";
    
    // Calculate the optimal font size for equal digit width
    const fontSize = 50; // Adjust 20 as needed for padding
    
    // Draw each digit of the OTP with equal size
    for (let i = 0; i < otp.length; i++) {
      context.font = `bold ${fontSize}px Arial`;
      const digit = otp[i];
      const digitWidth = context.measureText(digit).width;
      const digitX = (canvas.width - otp.length * digitWidth) / 2 + i * digitWidth;
      const digitY = canvas.height / 2;
      context.fillText(digit, digitX, digitY);
    }
    
    // Add random noise lines
    for (let i = 0; i < 20; i++) {
      context.strokeStyle = `rgba(${Math.random() * 255},${Math.random() * 255},${
        Math.random() * 255
      },${Math.random()})`;
      context.lineWidth = Math.random() * 2;
      context.beginPath();
      context.moveTo(Math.random() * canvas.width, Math.random() * canvas.height);
      context.lineTo(Math.random() * canvas.width, Math.random() * canvas.height);
      context.stroke();
    }
    
    // Add random noise dots
    for (let i = 0; i < 100; i++) {
      context.fillStyle = `rgba(${Math.random() * 255},${Math.random() * 255},${
        Math.random() * 255
      },${Math.random()})`;
      context.beginPath();
      context.arc(
        Math.random() * canvas.width,
        Math.random() * canvas.height,
        Math.random() * 2,
        0,
        Math.PI * 2
      );
      context.fill();
    }
    
    // Save the canvas as a PNG image
    const buffer = canvas.toBuffer("image/png");
    fs.writeFileSync("otp_captcha.png", buffer);
    
    
console.log("OTP image created as otp_captcha.png");
    const otpImage = await Jimp.read("otp_captcha.png");

    otpImage.greyscale();

    // Convert the image to a matrix of 0s and 255s (0 for black and 255 for white)
    const imageArray = [];
    for (let y = 0; y < otpImage.bitmap.height; y++) {
      const row = [];
      for (let x = 0; x < otpImage.bitmap.width; x++) {
        const pixelColor = Jimp.intToRGBA(otpImage.getPixelColor(x, y));
        const grayscaleValue = (pixelColor.r + pixelColor.g + pixelColor.b) / 3;
        const binaryValue = grayscaleValue < 128 ? 0 : 255;
        row.push(binaryValue);
      }
      imageArray.push(row);
    }

    // Create random_matrix_1 by generating random 0s and 255s of the same shape as the image
    const random_matrix_1 = [];
    for (let y = 0; y < otpImage.bitmap.height; y++) {
      const row = [];
      for (let x = 0; x < otpImage.bitmap.width; x++) {
        const randomValue = Math.random() < 0.5 ? 0 : 255;
        row.push(randomValue);
      }
      random_matrix_1.push(row);
    }
    console.log(random_matrix_1);

    // Create random_matrix_2 by XORing random_matrix_1 with the imageArray
    const random_matrix_2 = [];
    for (let y = 0; y < otpImage.bitmap.height; y++) {
      const row = [];
      for (let x = 0; x < otpImage.bitmap.width; x++) {
        const xorValue = random_matrix_1[y][x] ^ imageArray[y][x];
        row.push(xorValue);
      }
      random_matrix_2.push(row);
    }

    // Create shares
    const share1Image = new Jimp(imageArray[0].length, imageArray.length);
    const share2Image = new Jimp(imageArray[0].length, imageArray.length);

    for (let y = 0; y < otpImage.bitmap.height; y++) {
      for (let x = 0; x < otpImage.bitmap.width; x++) {
        share1Image.setPixelColor(
          Jimp.rgbaToInt(
            random_matrix_1[y][x],
            random_matrix_1[y][x],
            random_matrix_1[y][x],
            255
          ),
          x,
          y
        );
        share2Image.setPixelColor(
          Jimp.rgbaToInt(
            random_matrix_2[y][x],
            random_matrix_2[y][x],
            random_matrix_2[y][x],
            255
          ),
          x,
          y
        );
      }
    }

    // Save shares as imagess
    // share1Image.write("share1.png");
    // share2Image.write("share2.png");

    const share1Buffer = fs.readFileSync("share1.png");
    const share1Base64 = share1Buffer.toString("base64");
    console.log("share1base64 realprint :" , share1Base64);
    console.log("share1Base64 length:", share1Base64.length);

    // Check if a user with the provided email exists
    const existingUser = await Examinerdb.findOne({ where: { email: email } });
    console.log(otp);
    console.log(otp);
    if (existingUser) {
      // Check if there's an existing OTP record for the same user
      let otpRecord = await OTP.findOne({ where: { userId: existingUser.id } });

      if (otpRecord) {
        // If an OTP record exists, update it with the new OTP and reset the expiration time.
        otpRecord.otp = otp;
        otpRecord.createdAt = new Date(); // Reset the creation time (if you want to consider it for expiration).
        await otpRecord.save();
      } else {
        // If no OTP record exists, create a new one.
        otpRecord = await OTP.create({
          userId: existingUser.id,
          otp: otp,
        });
      }
      console.log("dtgdgd", email);
      const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: "pravin.suthar6484@gmail.com", // Your Gmail email address
          pass: "wcvq fkho egpr uvxw", // Your Gmail password or application-specific password
        },
      });

      const mailOptions = {
        from: "pravin.suthar6484@gmail.com", // Sender address
        to: email, // Recipient address
        subject: "OTP Verification", // Email subject
        text: `Your OTP is: ${otp}`, // Email body text
        attachments: [
          {
            filename: "share2.png", // Name of the attachment
            path: "share2.png", // Path to the attachment file
          },
        ],
      };
      try {
        await transporter.sendMail(mailOptions);
        console.log("Mail sent successfully");
      } catch (err) {
        console.error("Error sending mail:", err);
      } finally {
        transporter.close();
      }

      // Send the OTP via email
      //  await sendOtpEmail(email, otp, share2Image);
      console.log(otp);
      res.status(200).json({
        success: true,
        message: "OTP sent to your email",
        otpRecord,
        share1 : share1Base64
        
      });
    } else {
      res.status(400).json({
        success: false,
        message: "Kindly Register First",
      });
    }
  } catch (error) {
    return res.status(400).json({ success: false, message: error.message });
  }
};
exports.registerExaminer = async (req, res) => {
  try {
    const {
      firstName,
      lastName,
      email,
      phoneNumber,
      dateOfBirth,
      gender,
      address,
      qualifications,
    } = req.body; // Include all fields from the request body

    // Check if the email already exists
    // const existingExaminer = await Examiner.findOne({ where: { email } });
    // if (existingExaminer) {
    //   return res
    //     .status(400)
    //     .json({ success: false, message: "Email already exists" });
    // }

    // Create a new examiner record in the database with all provided data
    await Examinerdb.create({
      firstName,
      lastName,
      email,
      phoneNumber,
      dateOfBirth,
      gender,
      address,
      qualifications,
    });

    // Send a registration email to the user

    return res
      .status(201)
      .json({ success: true, message: "Examiner registered successfully" });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: "Registration failed",
      error: error.message,
    });
  }
};

exports.verifyOTP = async (req, res) => {
  const { email, otp } = req.body;

  try {
    // Check if a user with the provided email exists
    const existingUser = await Examinerdb.findOne({ where: { email: email } });

    if (existingUser) {
      // Check if there's an OTP record for the user
      const otpRecord = await OTP.findOne({
        where: { userId: existingUser.id },
      });

      if (otpRecord) {
        // Check if the provided OTP matches the one stored in the database
        if (otp === otpRecord.otp) {
          // You can mark the OTP record as used or delete it, depending on your requirements.
          // For example, to mark it as used:
          // otpRecord.used = true;
          // await otpRecord.save();

          res.status(200).json({
            success: true,
            message: "OTP verified successfully",
            examinersid: existingUser.id,
          });
        } else {
          res.status(400).json({
            success: false,
            message: "Invalid OTP",
          });
        }
      } else {
        res.status(400).json({
          success: false,
          message: "No OTP record found for this user",
        });
      }
    } else {
      res.status(400).json({
        success: false,
        message: "User not found. Kindly Register First",
      });
    }
  } catch (error) {
    return res.status(400).json({ success: false, message: error.message });
  }
};
