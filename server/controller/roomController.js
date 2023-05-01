const Room = require('../models/roomModel.js')
const mongoose = require('mongoose')
// get all rooms
const getAllRooms = async (req,res) =>{
   const room = await Room.find({}).sort({createdAt:-1})
   res.status(200).json(room)
}


// get single room
const getRoom = async (req,res) =>{
   const {id} = req.params
   if(!mongoose.Types.ObjectId.isValid(id)){
       return res.status(404).json({error:'No such room'})
   }
   const room = await Room.findById(id)
   if (!room){
       return res.status(404).json({error: 'no such room'})
   }
   res.status(200).json(room)
}


// create new room
const createRoom = async (req,res) => {
   const {rid,cat,reason,dates,startTime,endTime,available} = req.body
   try{
       const room = await Room.create({rid,cat,reason,dates,startTime,endTime,available})
       res.status(200).json(room)
   }catch(error){
       res.status(400).json({error: error.message})
   }
}


// delete a room
const deleteRoom = async (req,res) =>{
   const {id} = req.params
   if(!mongoose.Types.ObjectId.isValid(id)){
       return res.status(404).json({error:'No such room'})
   }
   const room = await Room.findOneAndDelete({_id: id})
   if (!room){
       return res.status(404).json({error: 'no such room'})
   }
   res.status(200).json(room)
}


// update a room
const updateRoom = async (req,res) =>{
   const {id} = req.params
   if(!mongoose.Types.ObjectId.isValid(id)){
       return res.status(404).json({error:'No such room'})
   }
   const room = await Room.findOneAndUpdate({_id:id},{
       ...req.body
   })
   if (!room){
       return res.status(404).json({error: 'no such room'})
   }
   res.status(200).json(room)
}


module.exports = {
   getAllRooms,
   getRoom,
   createRoom,
   deleteRoom,
   updateRoom
}


