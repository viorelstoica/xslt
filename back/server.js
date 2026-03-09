import express from 'express'
import cors from 'cors'
import es from 'event-stream'
import fs from 'fs'

const port = process.env.PORT || 3000
const baseDataFolder = process.env.BASE_DATA_FOLDER || "../tti"
const app = express()

var myLogger = function (req, res, next) {
    const { url, path: routePath } = req
    console.log(url, routePath)
    next()
}
app.use(myLogger)

app.use(cors())

app.listen(port, '0.0.0.0', () => {
    console.log(`Server is running on port ${port}`);
});

//*************************************************************

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.get('/file/:name', (req, res) => {
    fs.readFile(`${baseDataFolder}/${req.params.name}`, 'utf8', (err, data) => {
        if (err) {
            res.status(404).json(err)
            return
        }
        res.status(200).json(data)
    })
})
