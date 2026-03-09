import express from 'express'
import { getFile, outputProcessedStats, outputProcessedStats2 } from './drread.js'
import cors from 'cors'
import random from 'random-name'

const app = express();
app.use(cors())

app.use((req, res, next) => {
  console.log('Time:', Date.now())
  next()
})

app.get('/', async (req, res, next) => {
    res.status(200).send({name: `Hello world!`})
})

app.get('/name', async (req, res, next) => {
    res.status(200).send({firstname: `${random.first()}`, lastname: `${random.last()}`})
})

app.get('/file/:file', async (req, res, next) => {
    const file = req.params.file
    var data = await getFile(file)
    res.status(200).send(data)
})

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



const port = process.env.PORT || 3000
const server = app.listen(port, async () => {
    console.log(`server started on port: ${port}`)
})





