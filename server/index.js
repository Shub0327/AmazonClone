console.log("hello");


const express = require('express');
const PORT =3000;
const app=express();

//create api
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`Connted to port ${PORT}`);
    console.log("asfasello");
})
