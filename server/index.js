// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// //IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth");

// //INIT
const PORT = 3000;
const app = express();

//MIDDLEWARE
// CLIENT -> MIDELWARE ->  SERVER -> CLIENT
app.use(express.json());
app.use(authRouter);

// connections

mongoose.connect("mongodb://127.0.0.1:27017/user", (err, res) => {
  if (!err) {
    console.log("success");
  }
});

app.get("/", (req, res) => {
  res.send("ldjfldsf");
});

app.listen(PORT, "192.168.0.101", () => {
  console.log(`connected at port ${PORT}`);
});
