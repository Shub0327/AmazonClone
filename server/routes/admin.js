const express = require('express');
const adminRouter = express.Router();
const admin=require('../middleware/admin');
const Product = require('../model/product');

//creating admin middleware
    adminRouter.post('/admin/add-product',admin, async (req, res) => {

    try {
        
        const {name,description,price,quantity,category,image}=req.body; 
        let product= new Product({  
            name,
            description,
            price,
            quantity,
            category,
            image, 
        });
        product=await product.save();
        res.json(product);  

      } 
      catch (e) {
        return res.status(500).json({error:e.message});
        
    }
})

module.exports = adminRouter;