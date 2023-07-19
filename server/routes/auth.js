const express = require("express");
const User = require("../models/user");
const jwt  = require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter = express.Router();


authRouter.post('/api/signup', async (req , res)=>{
  try{
   const { name ,email , profilePic} = req.body;

   // email already Exists?
  let user = await User.findOne({emial});
   

  if(!user){
    user = new User ({
    email,
    name,
    profilePic,
    });
    user = await user.save();

    
  }

  const token = jwt.sign({id :user._id});


  res.status(200).json({user});  // default 200 don't need to write status code 200.




  }catch{
    res.status(500).json({error:e.message});

  }
});

authRouter.get('', auth , async (req , res)=>{
    const user = await User.findById(req.user);
    res.json({user , token : req.token });
  });

module.exports = authRouter;