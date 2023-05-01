const express = require('express')
const { createRoom, getAllRooms,getRoom,deleteRoom,updateRoom } = require('../controller/roomController.js')
const router = express.Router()


// get all rooms
router.get('/', getAllRooms)
// get single room
router.get('/:id',getRoom)
// post
router.post('/', createRoom)
// delete 
router.delete('/:id',deleteRoom)
//update
router.patch('/:id',updateRoom)


module.exports = router

