const jwt =require('jsonwebtoken');

const auth=((req,res,next)=>{

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
        req.user=verified.id;
        req.token=token;
        next();

    } catch (e) {
        res.status(500).json({error:e.message});
    }
});
module.exports=auth;