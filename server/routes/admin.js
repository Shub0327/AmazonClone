const express = require('express');
const adminRouter = express.Router();
const admin=require('../middleware/admin');
const Product = require('../model/product');

//add product
    adminRouter.post('/admin/add-product',admin, async (req, res) => {

    try {
        
        const {name,description,price,quantity,category,images}=req.body; 
        let product= new Product({  
            name,
            description,
            price,
            quantity,
            category,
            images, 
        });
        product=await product.save();
        res.json(product);  

      } 
      catch (e) {
        return res.status(500).json({error:e.message});
        
    }
})

//get all products
adminRouter.get('/admin/products',admin, async (req, res) => {
    try {
        const products = await Product.find();
        res.json(products);
    } catch (e) {
        return res.status(500).json({error:e.message});
    }
})

//delete product
adminRouter.delete('/admin/delete-product/:id',admin, async (req, res) => {
    try {
        const product = await Product.findByIdAndDelete(req.params.id);
        res.json(product);
    } catch (e) {
        return res.status(500).json({error:e.message});
    }
})

module.exports = adminRouter;