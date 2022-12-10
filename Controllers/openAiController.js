const { response } = require("express")
const { Configuration, OpenAIApi } = require("openai")
const configuration = new Configuration({
    apiKey: process.env.API_KEY
})
const openai = new OpenAIApi(configuration)

const generateImage = async (req, res) => {
    const { prompt, size } = req.body
    try {
        const response = await openai.createImage({
            prompt: prompt,
            n: 1,
            size: size
        })

        const URL = response.data.data[0].url
        res.status(201).json({
            success: true,
            url: URL
        })
    } catch (error) {
        res.status(400).json({
            success: false,
            error: error
        })
    }

}

module.exports = { generateImage }