const mongoose = require('mongoose')
const Schema = mongoose.Schema


const roomSchema = new Schema(
   {
       "rid": {
         "type": "String"
       },
       "cat": {
         "type": "String"
       },
       "reason": {
         "type": "String"
       },
       "dates": {
         "type": "String"
       },
       "startTime": {
         "type": "String"
       },
       "endTime": {
         "type": "String"
       },
       "available": {
         "type": "Boolean"
       }
     },{timestamps:true})


module.exports = mongoose.model('Room',roomSchema)

