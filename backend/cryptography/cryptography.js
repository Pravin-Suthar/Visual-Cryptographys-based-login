const Jimp = require("jimp");
function generateShares(otpImage) {
  // Convert the image to binary (black and white)
  otpImage.greyscale();

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

  // Create shares as Jimp images
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

  return { share1Image, share2Image };
}

module.exports = generateShares;
