const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const morgan = require("morgan")
const formularioRouter = require('./routes/formulario')

const PORT = process.env.PORT || 3000;
const app = express();

app.use(morgan('dev'))

app.use(express.json());
app.use(authRouter);
app.use(formularioRouter);

const DB = "mongodb+srv://danielsanchez170298:Dansan98@medical.kcskq.mongodb.net/?retryWrites=true&w=majority&appName=medical"

mongoose
    .connect(DB)
    .then(()=>{
        console.log("Connection Successful");
    })
    .catch((e)=>{
        console.log(e);
        
    })

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
    
})