const express = require('express')
const {
   getAllUsers,
   getUser,
   createUser,
   deleteUser,
   updateUser,
   loginUser,
   signupUser
} = require('../controller/userController.js')
const router = express.Router()


//get all rooms
router.get('/', getAllUsers)
// get single room
router.get('/:id',getUser)
// post
router.post('/', createUser)
// delete 
router.delete('/:id',deleteUser)
//update
router.patch('/:id',updateUser)
router.post('/login', loginUser)
router.post('/signup',signupUser)
module.exports = router
