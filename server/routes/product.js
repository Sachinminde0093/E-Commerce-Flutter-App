const express = require("express");
const auth = require("../middlware/auth");
const Product = require("../models/product");

const ratingSchema = require("../models/rating");
const productRouter = express.Router();

productRouter.get("/api/get-category-product", auth, async (req, res) => {
  try {
    const { category } = req.body;

    var product = await Product.find({ category: req.query.category });

    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
productRouter.get("/api/demo", (req, res) => {
  res.send("info");
});

productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    console.log(req.body);
    let product = await Product.findById(id);
    console.log(product);

    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }
    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.ratings.push(ratingSchema);

    console.log(product);

    var prod = await product.save();

    res.json(prod);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
