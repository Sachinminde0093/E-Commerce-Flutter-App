const express = require("express");
const bcrypt = require("bcryptjs");

const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same  email is already present " });
    }

    const hsapassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hsapassword,
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.send({ error: e.message });
  }
});

module.exports = authRouter;
