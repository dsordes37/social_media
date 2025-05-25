const testController = require('../controllers/testController');
const express = require('express');
const router = express.Router();


router.get('/', testController.getAllUsers)

module.exports = router