// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const produtRouter = require("./routes/product");
const searchRouter = require("./routes/search");

// INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB = "mongodb://127.0.0.1:27017/user";

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(produtRouter);
app.use(searchRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
