const express = require("express");
const { model, models } = require("mongoose");
const Product = require("../models/product");

const admin = require("../middlware/admin");
const User = require("../models/user");

const adminRouter = express.Router();

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, price, quantity, images, category } = req.body;
    console.log(name + description + price + quantity + images + category);

    let product = new Product({
      name,
      description,
      price,
      quantity,
      images,
      category,
    });

    // console.log(product);
    product = await product.save();

    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.get("/admin/get-product", admin, async (req, res) => {
  var products = await Product.find();

  res.json(products);
});

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
  
    var product = await Product.findByIdAndDelete({ _id: id });

    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

adminRouter.post("/admin/api", admin, (req, res) => {
  res.send("sss");
});



module.exports = adminRouter;
