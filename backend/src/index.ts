import express from "express";
import dotenv from "dotenv";


dotenv.config();
const app = express();



app.get("/",(req,res)=>{
    res.send("home pages are not save");
})

app.listen(process.env.PORT, () => {
    console.log("Server started on port 8000")
})
