const mongoose =require('mongoose');

const productSchema =mongoose.Schema({
    
        name:{
            required: true,
            trim: true,
            type: String
        },
        description:{
            required: true,
            trim: true,
            type: String
        },
        price:{
            required: true,
            type: Number
        },
        quantity:{
            required: true,
            type: Number
        },
        category:{
            required: true,
            type: String
        },
        images:[
            {
            required: true,
            type: String
        },
    ],
    
    
    }
    );
const Product =mongoose.model('Product',productSchema);
module.exports=Product;