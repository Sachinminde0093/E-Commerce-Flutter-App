// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB = "mongodb://127.0.0.1:27017/user";

app.get("/", (req, res) => {
  res.send("Hii");
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
