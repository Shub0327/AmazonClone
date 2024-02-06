
//import from packages
const express = require('express');
const mongoose=require('mongoose');

//import from other files
const authRouter=require('./routes/auth');
const  adminRouter=require('./routes/admin');
const productRouter = require('./routes/products');
//INIT
const PORT =3000;
const app =express();
const DB="mongodb+srv://shubham:eZs23s5FXLnfpPN@cluster0.a03ul8t.mongodb.net/?retryWrites=true&w=majority"

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

//connection
mongoose.connect(DB).then(()=>{
    console.log("Connection Successful");
}).catch((e)=>{
    console.log(e);
});

//create api
app.listen(PORT,()=>{
    console.log(`Connected to port ${PORT}`);
});
