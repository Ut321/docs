const express = require("express");
const mongoose = require('mongoose');
const cors = require("cors");
const authRouter = require("./routes/auth");


const PORT = process.env.PORT | 3001;

const app = express();
app.use(cors);  
app.use(express.json()); //Manipulation of Data Occoured here .
app.use(authRouter);

const DB ="mongodb+srv://ut88080:Utr1234@cluster0.purseue.mongodb.net/?retryWrites=true&w=majority"; 
mongoose.connect(DB).then(()=>{
    console.log('Connection Sucessful!');
   
}).catch ((err) =>{
    console.log(err);
});

app.listen(PORT, "0.0.0.0", () =>{
console.log(`Connected at ${PORT}`);



});