const Jimp = require("jimp");
const { createCanvas } = require("canvas");
const fs = require("fs");

async function generateOTPImage() {
  // Generate OTP logic (similar to your existing logic)
  const otp = Math.floor(100000 + Math.random() * 900000);

  const canvas = createCanvas(720, 520);
  const context = canvas.getContext("2d");

  // Set the background color
  context.fillStyle = "#ffffff";
  context.fillRect(0, 0, canvas.width, canvas.height);

  // Set the text properties
  context.fillStyle = "#000000";
  context.textBaseline = "middle";

  // Apply a rotation to make the text look "crooked"
  const angle = Math.random() * 0.1 - 0.05; // Random rotation angle
  context.setTransform(1, angle, 0, 1, 0, 0);

  // Draw each digit of the OTP with a random size
  for (let i = 0; i < otp.length; i++) {
    const randomFontSize = Math.floor(Math.random() * 80) + 56; // Random font size between 48 and 84
    context.font = `bold ${randomFontSize}px Arial`;
    const digit = otp[i];
    const digitWidth = context.measureText(digit).width;
    const digitX =
      (canvas.width - otp.length * digitWidth) / 2 + i * digitWidth;
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

  const imageBuffer = canvas.toBuffer("image/png");
  const otpImage = await Jimp.read(imageBuffer);

  // Return both OTP and the Jimp image
  return { otp, otpImage };
}

module.exports = generateOTPImage;
