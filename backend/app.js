const express = require("express");
const app = express();
const path = require("path");
const mysql = require("mysql2");

require("dotenv").config();
// Import the Sequelize setup and models from your index.js file
const db = require("./models/index.js");
const port = process.env.PORT || 6000;

// Establish a connection to the MySQL databa
const examinerRoutes = require("./routes/examiner");
const marksRoutes = require("./routes/marks.js");
app.use(express.json());
app.use("/api/examiner", examinerRoutes);
app.use("/api/marks", marksRoutes);
// Handle other Express routes and middleware here
app.listen(port, () => {
  console.log("Starting the listing process.");
  console.log(
    `${process.env.NODE_ENV} Server is running on port: http://localhost:${port}`
  );
});

module.exports = app;

