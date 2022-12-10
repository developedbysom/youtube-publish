const express = require("express")
const dotenv = require("dotenv").config()
const app = express()
const port = process.env.PORT || 5000
app.use(express.json())
app.use(express.urlencoded({ extended: false }))

app.use("/openai", require("./Routes/OpenAIRoute"))

app.listen(port, console.log(`App is listening on port ${port}`))