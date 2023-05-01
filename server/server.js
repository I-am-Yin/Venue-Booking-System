require('dotenv').config()
const express = require('express')
const mongoose = require('mongoose')
const roomRoutes = require('./routes/room.js')
const userRoutes = require('./routes/user.js')
// express app
const app = express()


// middleware
app.use(express.json())


app.use((req,res,next)=>{
   console.log(req.path, req.method)
   next()
})






app.use('/api/rooms',roomRoutes)
app.use('/api/user',userRoutes)
//conect mongodb
mongoose.connect(process.env.MONGO_URI)
   .then(()=>{
       // listen for requests
       app.listen(process.env.PORT, () => {
           console.log('connect to db & listening on port '+ process.env.PORT)
       })
   })
   .catch((error)=>{
       console.log(error)
   })









