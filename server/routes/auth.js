const express =require("express");
const bcryptjs=require("bcryptjs");
const jwt=require('jsonwebtoken');

const authRouter=express.Router();
const User=require('../model/user');
const auth = require("../middleware/auth");

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
authRouter.post('/api/signin',async(req,res)=>{

try{
    const {email,password}=req.body;
    const user= await User.findOne({email});

    if(!user){
        return res.status(400).json({msg:"User with this email does not exists"});
    }

    const isMatch= await bcryptjs.compare(password,user.password);

    if(!isMatch){
            return res.status(400).json({msg:"Password does not match"});
    }

    const token= jwt.sign({id:user._id},"passwordKey");
    // console.log(user._doc);
    res.json({token,...user._doc});


}
catch(e){
    res.status(500).json({error:"Fail to sign in(server error)"})}
});


//validating token
authRouter.post('/api/validate-token',(req,res)=>{
    try{
        const token=req.header("x-auth-token");
        if(!token){
            return res.json(false);
        }
        const verified=jwt.verify(token,"passwordKey");
        if(!verified){
            return res.json(false);
        }
        const user=User.findById(verified.id);
        if(!user){
            return res.json(false);
        }
        
        return res.json(true);
    }
    catch(e){
        res.status(500).json({error:e.message});
    }
});


//get user data
authRouter.get('/',auth,async(req,res)=>{
    console.log(req.user);
    const user=await User.findById(req.user);
    // console.log(user);
    res.json({...user._doc,token:req.token});

});

module.exports = authRouter;