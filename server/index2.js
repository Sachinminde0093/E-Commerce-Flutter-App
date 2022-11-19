const mongoose = require('mongoose')
mongoose.connect("mongodb://localhost:27017/user",(err,res)=>{
    if(!err){
        console.log("success");
    }else{
        console.log(err);
    }
})
