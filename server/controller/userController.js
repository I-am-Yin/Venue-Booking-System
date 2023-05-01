

const User = require('../models/userModel.js')
const mongoose = require('mongoose')
const jwt = require('jsonwebtoken')
const { hash } = require('bcrypt')


// get all users
const getAllUsers = async (req,res) =>{
   const user = await User.find({}).sort({createdAt:-1})
   res.status(200).json(user)
}


// get single user
const getUser = async (req,res) =>{
   const {id} = req.params
   if(!mongoose.Types.ObjectId.isValid(id)){
       return res.status(404).json({error:'No such user'})
   }
   const user = await User.findById(id)
   if (!user){
       return res.status(404).json({error: 'no such user'})
   }
   res.status(200).json(user)
}


// create new user
const createUser = async (req,res) =>{
   const {email,password,uid,name,type,currentBooking,record} = req.body
   try{
       const user = await User.create({email,password,uid,name,type,currentBooking,record})
       res.status(200).json(user)
   }catch(error){
       res.status(400).json({error:error.message})
   }
}


// delete a user
const deleteUser = async (req,res) =>{
   const {id} = req.params
   if(!mongoose.Types.ObjectId.isValid(id)){
       return res.status(404).json({error:'No such room'})
   }
   const user = await User.findOneAndDelete({_id: id})
   if (!user){
       return res.status(404).json({error: 'no such room'})
   }
   res.status(200).json(user)
}


// update a user
const updateUser = async (req,res) =>{
   const {id} = req.params
   if(!mongoose.Types.ObjectId.isValid(id)){
       return res.status(404).json({error:'No such room'})
   }
   const user = await User.findOneAndUpdate({_id:id},{
       ...req.body
   })
   if (!user){
       return res.status(404).json({error: 'no such room'})
   }
   res.status(200).json(user)
}
const createToken = (_id) =>{
   return jwt.sign({_id}, process.env.SECRET,{expiresIn:'3d'})
}




const loginUser = async(req,res) =>{
   const {email,password} = req.body
   try{
       const user = await User.login(email,password)
       //const token = createToken(user._id)
       res.status(200).json({user,status:true})
   }catch(error){
       res.status(400).json({error:error.message})
   }
}


const signupUser = async(req,res) =>{
   const {email,password,uid,name,type,currentBooking,record} = req.body
   try{
       const user = await User.signup(email,password,uid,name,type,currentBooking,record)
       //const token = createToken(user._id)
       res.status(200).json({user,success:true})
   }catch(error){
       res.status(400).json({error: error.message})
   }
}


module.exports = {
   getAllUsers,
   getUser,
   createUser,
   deleteUser,
   updateUser,
   loginUser,
   signupUser
}

