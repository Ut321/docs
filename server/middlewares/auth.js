
const jwt = require('josnwebtoken');

const auth = async (res , res , next=>{
    try{
           const token = req.header("x-auth-token");

           if(!token)
            return res.status(401).json({msg : 'No auth token , acess denied.'});

            const verified  = jwt.verify(token,"passwordKey");
        if(!verified )

        return res
        .status(401)
        .json({msg : "Token verification failed , authorization denied" });

     req.user = verified.id;

           
    }catch(e){

    }
       
})