const express =require("express");
const bcryptjs=require("bcryptjs");
const jwt=require('jsonwebtoken');

const authRouter=express.Router();
const User=require('../model/user');

// authRouter.get('/user',(req,res)=>{
//         res.json({
//             msg:"hello there!!"
//         });
// });


//Sign up route
authRouter.post('/api/signup',async(req,res)=>{
    try{
        const {email,name,password}=req.body;
    
        const existingUser = await User.findOne({email});

        if(existingUser){
             return res.status(400).json({msg:'Email already exists'});
         }

         const hashedPassword= await bcryptjs.hash(password,8);
    
    let user=new User({
        email,
        name,
        password: hashedPassword,
    })
    
    user= await user.save();
    res.json(user);

}catch(e){
    res.status(500).json({error:e.message});
}
});

//Sign in Route

authRouter.post('/api/signin',(req,res)=>{

try{
    const {email,password}=res.body;
    const user= User.findOne({email});

    if(!user){
        return res.status(400).json({msg:"User already exists"});
    }

    const isMatch=bcryptjs.compare(User.password,password);

    if(!isMatch){
            return res.status(400).json({msg:"Password does not match"});
    }

    const token= jwt.sign({id:user._id},"passwordKey");
    res.json({token,...user._doc});

}
catch(e){
    res.status(500).json({error:"Fail to sign in"})}
});

module.exports = authRouter;