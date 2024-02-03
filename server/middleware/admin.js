const jwt =require('jsonwebtoken');
const User=require('../model/user');

const admin=((req,res,next)=>{
try {
    //get token from header
    const token = req.header("x-auth-token");
    if(!token){
        return res.status(401).json({msg:"No authentication token, authorization denied"});
    }
    //verify token
    const verified=jwt.verify(token,"passwordKey");
    if(!verified){
        return res.status(401).json({msg:"Token verification failed, authorization denied"});
    }
    //add user from payload
    const user=User.findById(verified.id);
    if(user.type!=='admin'){
        return res.status(401).json({msg:"No user found with this id"});
    }
    req.user=verified.id;
    req.token=token;

} catch (e) {
    return res.status(500).json({error:e.message});
}
next();
}   
);
module.exports=admin;