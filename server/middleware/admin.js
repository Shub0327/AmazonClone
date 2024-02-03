const jwt =require('jsonwebtoken');
const User=require('../model/user');

const admin=async (req,res,next)=>{
try {
    //get token from header
    const token = req.header("x-auth-token");
    console.log(token);
    if(!token){
        return res.status(401).json({msg:"No authentication token, authorization denied"});
    }
    //verify token
    const verified=jwt.verify(token,"passwordKey");
    if(!verified){
        return res.status(401).json({msg:"Token verification failed, authorization denied"});
    }
    //add user from payload
    const user=await User.findById(verified.id);

    console.log(user.token);
    if(user.type!=="admin"){
        return res.status(401).json({msg:"You are not admin to access this route, authorization denied"});
    }
    req.user=verified.id;
    req.token=token;

} catch (e) {
    return res.status(500).json({error:e.message});
}
next();
}   
module.exports=admin;