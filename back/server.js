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

app.get('/dates', (req, res) => {
    let folders = fs.readdirSync(`${logPath}/`).sort((a, b) => a > b ? -1 : a < b ? 1 : 0)
    res.status(200).json(folders)
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
        var files = fs.readdirSync(`${logPath}/${date}/trace/${fo}`)
        files.forEach(fi => {
            if(fi.match(uuid)) {
                let tokens = fi.split("_")
                ret.push({date: tokens[0].slice(0,4)+'-'+tokens[0].slice(4,6)+'-'+tokens[0].slice(6,8), time: tokens[1].slice(0,2)+':'+tokens[1].slice(2,4)+':'+tokens[1].slice(4,6), milli: tokens[2], thread: tokens[3], step: tokens[4], flow: tokens[5], uuid: tokens[6].slice(0, tokens[6].length-4)})
            }
        })
    })
    /*
    in the front we need something like:
    {
    "category": "d",
    "start": new Date("2019-01-10 06:15").getTime(),
    "end": new Date("2019-01-10 06:30").getTime(),
    "settings": { "fill": colorSet.getIndex(14) },
    "icon": water,
    "text": "Drink water"
    },
    */
    var ret2 = []
    ret.forEach(e => {

    })
    res.status(200).json(ret)
})

app.get('/msgin/:date', (req, res) => {
    const date = req.params.date
    var ret = []
    var folders = fs.readdirSync(`${logPath}/${date}/trace`)
    folders.forEach(async (fo) => {
        var files = fs.readdirSync(`${logPath}/${date}/trace/${fo}`)
        files.forEach(fi => {
            if(fi.match('msgin')) {
                let tokens = fi.split("_")
                ret.push({ 
                    date: tokens[0].slice(0,4)+'-'+tokens[0].slice(4,6)+'-'+tokens[0].slice(6,8), 
                    time: tokens[1].slice(0,2)+':'+tokens[1].slice(2,4)+':'+tokens[1].slice(4,6), 
                    milli: tokens[2], 
                    thread: tokens[3], 
                    step: tokens[4], 
                    flow: tokens[5], 
                    //uuid: tokens[6].slice(0, tokens[6].length-4)
                })
            }
        })
    })
    res.status(200).json(ret)
})


