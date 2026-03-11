import express from 'express'
import cors from 'cors'
import es from 'event-stream'
import fs from 'fs'

const port = process.env.PORT || 3000
const baseDataFolder = process.env.BASE_DATA_FOLDER || "../tti"
const app = express()
const logPath = '../../logs/data/'

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

app.get('/msgin/:date/:uuid', (req, res) => {
    const date = req.params.date
    const uuid = req.params.uuid
    var ret = []
    // get uuid from msgin
    // logs/data/2026-02-23/trace/FinancialInstruments/20260223_020232_295_59_msgin_BatchMultiFinancialInstrumentSecurity_f712aaa5-6317-4273-aabc-3e84263b2dee.xml
    var folders = fs.readdirSync(`${logPath}/${date}/trace`)
    folders.forEach(async (fo) => {
        console.log(`reading dir ${fo}`)
        var files = fs.readdirSync(`${logPath}/${date}/trace/${fo}`)
        files.forEach(fi => {
            console.log(`checking ${fi}`)
            if(fi.match(uuid)) 
                ret.push(fi)
        })
    })
    res.status(200).json(ret)
})



