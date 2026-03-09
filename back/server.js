import express from 'express'
import cors from 'cors'
import es from 'event-stream'
import fs from 'fs'

import { getXmlUuid } from './read.js'
import { outputProcessedStats, outputProcessedStats2, outputProcessedGetErrors, outputProcessedGetErrorList } from './drread.js'

const port = process.env.PORT || 3000
const baseDataFolder = process.env.BASE_DATA_FOLDER || "../data"
const app = express()


var myLogger = function (req, res, next) {
    const { url, path: routePath } = req
    console.log(url, routePath)
    next()
}

app.use(myLogger)

app.use(cors())
console.log(`${loadFile('2026-02-01')} lines loaded`)
app.listen(port, '0.0.0.0', () => {
    console.log(`Server is running on port ${port}`);
});

//*************************************************************

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.get('/dates', (req, res) => {
    const dates = fs.readdirSync(`${baseDataFolder}/`).filter(file => fs.statSync(`${baseDataFolder}/${file}`).isDirectory).sort((a,b) => -a.localeCompare(b)).filter(v => v.startsWith("20"))
    res.send(dates)
})


app.get('/load/:folder', (req, res) => {
    lines = []
    fs.createReadStream(`${baseDataFolder}/${req.params.folder}/index.txt`).on('error', (err) => {
        res.status(404).json(err)
    })
        .pipe(es.split())
        .pipe(es.map(function (line, next) {
            var tokens = line.split('/')
            lines.push({ folder: tokens.slice(0, -1).join("/"), file: tokens[tokens.length - 1] })
            next(null, line);
        })).pipe(es.wait(function (err, body) {
            console.log(lines.length);
            // decompose "20250829_013916_049_48_msgin_BatchAAAFlow_86caba26-278d-4bc3-bfed-f0aa84254b62.xml"
            ttimsgs = lines.filter(l => l.folder.startsWith('trace')).map(l => l.file.split('_')).filter(t => t.length > 6).map(t => {
                return { date: t[0], time: t[1], milli: t[2], thread: t[3], categ: t[4], flow: t[5], id: t[6].slice(0, -4) }
            })
            res.status(200).json({ cnt: lines.length });
        }))
})

app.get('/folders', (req, res) => {
    var ret = {}
    lines.forEach(f => { f.folder in ret ? ret[f.folder] += 1 : ret[f.folder] = 0 })
    res.status(200).json(ret);
})

app.get('/tti/bytype', (req, res) => {
    var ret = {}
    ttimsgs.forEach(m => { m.categ in ret ? ret[m.categ] += 1 : ret[m.categ] = 0 })
    res.status(200).json(ret);
})

app.get('/stat', (req, res) => {
    res.status(200).json(msgByFolder());
})

app.get('/stat/0', (req, res) => {
    res.status(200).json(msgByFolderAndCateg());
})
app.get('/stat/1', (req, res) => {
    res.status(200).json(msgByFlow());
})
app.get('/stat/2', (req, res) => {
    res.status(200).json(msgByMin());
})
app.get('/tti/by5minandcateg', (req, res) => {
    res.status(200).json(msgBy5MinAndCateg());
})
app.get('/tti/by5min', (req, res) => {
    res.status(200).json(msgBy5Min());
})
app.get('/tti/orders', (req, res) => {
    res.status(200).json(getOrders());
})

app.get('/tti/xsltstats', (req, res) => {
    var ret = {}
    ttimsgs.forEach(m => {
        ret[m.id] ? ret[m.id]['count'] = ret[m.id]['count']+1 : ret[m.id] = {count:1, flow:m.flow}
    })
    res.status(200).send(`hello ${Object.keys(ret).length}`);
    /*
    var ret2 = {}
    const keys = Object.keys(ret)
    keys.forEach(k => {
        ret2[k] ? ret2[k]['count'] = ret2[k]['count']+1 : ret2[k] = {count:1, flow:ret[k]['flow'    ]}
    })
    res.status(200).json(ret2);
    */
})

app.get('/xmluuid/:date', async (req, res) => {
    res.status(200).json(await gwpTimeSpent(req.params.date));
})

var lines = []
var ttimsgs = []

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})

function loadFile(date) {
    lines = []
    fs.createReadStream(`${baseDataFolder}/${date}/index.txt`).on('error', (err) => {
        res.status(404).json(err)
    })
        .pipe(es.split())
        .pipe(es.map(function (line, next) {
            var tokens = line.split('/')
            lines.push({ folder: tokens.slice(0, -1).join("/"), file: tokens[tokens.length - 1] })
            next(null, line);
        })).pipe(es.wait(function (err, body) {
            console.log(lines.length);
            // decompose "20250829_013916_049_48_msgin_BatchAAAFlow_86caba26-278d-4bc3-bfed-f0aa84254b62.xml"
            ttimsgs = lines.filter(l => l.folder.startsWith('trace')).map(l => l.file.split('_')).filter(t => t.length > 6).map(t => {
                return { date: t[0], time: t[1], milli: t[2], thread: t[3], categ: t[4], flow: t[5], id: t[6].slice(0, -4) }
            })
            return lines.length
        }))
}

function msgByFolder() {
    var folders = [... new Set(lines.map(l => l.folder))]
    var stat = []
    folders.forEach(f => {
        stat.push({ folder: f, count: lines.filter(l => l.folder === f).length })
    })
    return stat
}

function msgByFolderAndCateg(folder) {
    var ret = []
    var categ = [... new Set(ttimsgs.map(m => m.categ))]
    categ.forEach(c => {
        ret.push({ categ: c, count: ttimsgs.filter(l => l.categ === c).length })
    })
    return ret
}

function msgByFlow() {
    var ret = []
    var flows = [... new Set(ttimsgs.map(m => m.flow))]
    flows.forEach(f => {
        ret.push({ flow: f, count: ttimsgs.filter(l => l.flow === f).length })
    })
    return ret
}

function msgByMin() {
    var ret = []
    var mins = [... new Set(ttimsgs.map(m => m.time.slice(0, 4)))].sort()
    mins.forEach(m => {
        ret.push({ min: m, count: ttimsgs.filter(l => l.time.startsWith(m)).length })
    })
    return ret
}

function msgBy5Min() {
    var ret = {}
    for (var h = 0; h < 24; h++) {
        for (var m = 0; m < 60; m += 5) {
            const min = String(h).padStart(2, '0') + ':' + String(m).padStart(2, '0')
            ret[min] = 0
        }
    }
    ttimsgs.forEach(m => {
        var key = m.time.slice(0, 2) + ':' + m.time[2]
        if (m.time[3] < 5)
            key += '0'
        else
            key += '5'
        ret[key] = ret[key] + 1
    })
    return ret
}

function msgBy5MinAndCateg() {
    var ret = {}
    for (var h = 0; h < 24; h++) {
        for (var m = 0; m < 60; m += 5) {
            const min = String(h).padStart(2, '0') + ':' + String(m).padStart(2, '0')
            ret[min] = { msgin: 0, prefilter: 0, postfiler: 0, postmap: 0, postprocess: 0, adapterin: 0, adapterout: 0, msgout: 0 }
        }
    }
    ttimsgs.forEach(m => {
        var key = m.time.slice(0, 2) + ':' + m.time[2]
        if (m.time[3] < 5)
            key += '0'
        else
            key += '5'
        ret[key][m.categ] = ret[key][m.categ] + 1
    })
    return ret
}

export function getOrders() {
    var ret = []
    ttimsgs.forEach(m => {
        if (m.flow.startsWith('F2B'))
            ret.push(m)
    })
    return ret
}

async function gwpTimeSpent(date) {
    var ret = await getXmlUuid(date)
    var ret2 = {}
    for (var h = 0; h < 24; h++) {
        for (var m = 0; m < 60; m += 5) {
            const min = String(h).padStart(2, '0') + ':' + String(m).padStart(2, '0')
            ret2[min] = { avg: 0, sum: 0, cnt: 0 }
        }
    }
    ret.forEach((r) => {
        if(r.diff != null && r.diff > 0) {
            var x = Math.floor(r.tin/100)
            var y = Math.floor(x/10)*10
            var d = ((x-y) >= 5 ? y + 5 : y).toString().padStart(4, '0')
            var min = d.substring(0, 2) + ":" + d.substring(2,4)
            ret2[min].cnt = ret2[min].cnt + 1
            ret2[min].sum = ret2[min].sum + r.diff
            ret2[min].avg = Math.floor(ret2[min].sum/ret2[min].cnt)
        }
    })
    return ret2
}

app.get('/output/stats', async (req, res, next) => {
    const data = await outputProcessedStats()
    var ret = []
    data.forEach(d => {

      const recF = ret.find((el) => el.folder === d.folder)
      if (recF == undefined) {
        ret.push({ folder: d.folder, cnt: d.cnt, err: d.err, suc: d.suc})
      }
      else {
        recF.cnt = recF.cnt + d.cnt
        recF.err = recF.err + d.err
        recF.suc = recF.suc + d.suc
      }
    })
    ret.forEach(r => {
      r.per = (100 - 100 * r.err/(r.suc + r.err)).toFixed(2)
    })
    res.status(200).send(ret)
})

app.get('/output/stats2', async (req, res, next) => {
    const data = await outputProcessedStats2()
    data.forEach(r => {
      r.per = (100 - 100 * r.err/(r.suc + r.err)).toFixed(2)
    })
    res.status(200).send(data)
})

app.get('/output/errors/:day', async (req, res, next) => {
    const data = await outputProcessedGetErrors(req.params.day)
    res.status(200).send(data)
})

app.get('/output/errors/:day/:text', async (req, res, next) => {
    const data = await outputProcessedGetErrorList(req.params.day, req.params.text)
    res.status(200).send(data)
})

