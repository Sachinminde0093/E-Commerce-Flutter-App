const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();

const JWT_SECRET_KEY = "gfg_jwt_secret_key";

const TOKEN_HEADER_KEY = "gfg_token_header_key";

// SIGN UP
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // console.log(name, email, password);

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    console.log(email, password);

    const user = await User.findOne({ email });

    console.log(user.password);

    if (!user) {
      console.log("Invalid email address");

      res.status(400).json("Invalid email address");
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    console.log(isMatch);

    if (!isMatch) {
      console.log("Password is not matched");
      return res.status(502).json("Password is not matched");
    }

    let data = {
      id: user._id,
      name: user.name,
      time: Date(),
      type: user.type,
    };

    const token = jwt.sign(data, JWT_SECRET_KEY);

    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json(e.message + "error");
  }
});



module.exports = authRouter;
