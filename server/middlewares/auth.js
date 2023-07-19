
const jwt = require('jsonwebtoken');


const auth = async (req, res, next) => {  // This ->{} work in the same middleware
    try {
      const token = req.header("x-auth-token");
  
      if (!token)
        return res.status(401).json({ msg: "No auth token, access denied." });
  
      const verified = jwt.verify(token, "passwordKey");
  
      if (!verified)
        return res
          .status(401)
          .json({ msg: "Token verification failed, authorization denied." });
  
      req.user = verified.id;
      req.token = token;
      next();  // middlewares to servers. 
    } catch (e) {
      res.status(500).json({ error: e.message });  
    }
  };
  
  module.exports = auth;   // this will make public we can access entire the Application .