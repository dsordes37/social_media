const express = require("express");
const app = express();
app.use(express.json())



app.get("/", (req, res)=>{
    res.send("olá, mundo")
})


app.listen(3000, ()=>{
    console.log("rodando em http://localhost:3000")
})