const express = require("express");
const testRoutes = require('./routes/testRoutes')
const userRoutes = require('./routes/userRoutes')



const app = express();
app.use(express.json())

app.use("/users", userRoutes)


module.exports = app