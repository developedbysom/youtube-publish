const express = require("express")
const router = express.Router()
const {generateImage} = require("../Controllers/openAiController")
router.post("/generateimage",generateImage)
module.exports = router