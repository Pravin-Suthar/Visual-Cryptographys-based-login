const express = require("express");
const app = express();
const path = require("path");
const mysql = require("mysql2");

require("dotenv").config();
const db = require("./models/index.js");
const port = process.env.PORT || 6000;

const userRoutes = require("./routes/users");


app.use(express.json());
app.use("/api/user", userRoutes);

app.listen(port, () => {
  console.log("Starting the listing process.");
  console.log(
    `${process.env.NODE_ENV} Server is running on port: http://localhost:${port}`
  );
});
