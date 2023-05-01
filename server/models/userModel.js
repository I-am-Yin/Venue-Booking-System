const mongoose = require('mongoose')
const bcrypt = require('bcrypt')
const validator = require('validator')
const Schema = mongoose.Schema


const userSchema = new Schema({
   "uid": {
     "type": "String",
     required:true
   },
   "email": {
     "type": "String",
     required:true,
     unique:true
   },
   "password": {
     "type": "String",
     required:true
   },
   "name": {
     "type": "String",
     required:true
   },
   "type": {
     "type": "String",
     required:true
   },
   "currentBooking": {
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
   },
   "record": {
     "type": [
       "Mixed"
     ]
   }
 },{timestamps:true})


// static signup method


userSchema.statics.signup = async function(email, password,uid,name,type,currentBooking,record){
 // validation
 if(!email || !password){
   throw Error('All field must be filled')
 }
 if(!validator.isEmail(email)){
   throw Error('Email is not valid')
 }
 // contains Capital & lower letter & punctuation marks
 if(!validator.isStrongPassword(password)){
   throw Error('password not strong enough')
 }
 // check if the account existed ?
 const exsits = await this.findOne({email})
 if(exsits){
   throw Error('email already in use')
 }
 const salt = await bcrypt.genSalt(10) // set to 64
 const hash = await bcrypt.hash(password, salt)
 const user = await this.create({email,password: hash,uid,name,type,currentBooking,record})
 return user
}


// static login method
userSchema.statics.login = async function(email,password){
 if(!email || !password){
   throw Error('All field must be filled')
 }
 const user = await this.findOne({email})
 if(!user){
   throw Error('Incorrect email')
 }
 const match = await bcrypt.compare(password,user.password)
 if(!match){
   throw Error('Incorrect password')
 }
 return user
}


module.exports = mongoose.model('User',userSchema)


