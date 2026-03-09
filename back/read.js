import * as fs from 'fs'
import * as readline from 'readline'
import * as xml2json from 'xml2json'

const baseDataFolder = process.env.BASE_DATA_FOLDER || "../data"

// common shit
/**
 * reads a file .
 * @constructor
 * @param {string} title - The title of the book.
 * @param {string} author - The author of the book.
 */
export function getXmlFile(file) {
  return new Promise((resolve) => {
    fs.readFile(`${file}`, 'utf8', function (err, data) {
      var json = xml2json.toJson(data, { "object": true });
      resolve(json)
    })
  })
}

// gwpack stuff

/**
 * get the list of uuid from the xml folder for a given day
 * @param {string} day 
 */
export async function getXmlUuid(day) {
  var promises = []
  var files
  try {
    var files = fs.readdirSync(`${baseDataFolder}/${day}/xml`)
  } catch (err) {
    return []
  }
  files.forEach(fi => {
    promises.push(getOutputAttribute(`${baseDataFolder}/${day}/xml/${fi}`))
  })
  const ret = await Promise.all(promises)
  var ret2 = []
  ret.forEach(r => ret2.push(r[0]))
  var odf = fs.readdirSync(`${baseDataFolder}/${day}/output_processed`)
  //  console.dir(odf, {'maxArrayLength': null})
  ret2.forEach(r => {
    var elm = odf.find(v => v.includes(r.output))
    if (elm != undefined) {
      r.processed = elm
    }
    else {
      r.processed = 'n/a'
    }
  })

  ret2.forEach(r => {
    const tin = r.file.split("_")[1]
    const tout = r.processed.split("_")[1]
    r.tout = tout
    r.tin = tin
    r.diff = tout - tin
  })

  return ret2
}

function getOutputAttribute(file) {
  return new Promise((resolve) => {
    var ret = []
    fs.readFile(file, 'utf8', function (err, data) {
      var json = xml2json.toJson(data, { "object": true });
      Object.keys(json).forEach((k, v) => {
        const tk = file.split("/")
        ret.push({ output: json[k].output, file: tk[tk.length - 1] })
      })
      resolve(ret)
    })
  })
}

export async function outputProcessedStats() {
  const promises = []
  var folders = fs.readdirSync(`${baseDataFolder}`)
  folders.forEach(async (fo) => {
    if (fs.existsSync(`${baseDataFolder}/${fo}/output_processed`)) {
      var files = fs.readdirSync(`${baseDataFolder}/${fo}/output_processed`)
      files.forEach(fi => {
        promises.push(scanSucErr(fo, fi))
      })
    }
  })
  const ret = await Promise.all(promises)
  return ret
}

function scanSucErr(fo, fi) {
  const fileName = `${baseDataFolder}/${fo}/output_processed/${fi}`
  return new Promise((resolve) => {
    var cnt = 0, suc = 0, err = 0
    var lineReader = readline.createInterface({
      input: fs.createReadStream(fileName)
    });

    lineReader.on('line', function (line) {
      cnt = cnt + 1
      if (line.startsWith("SUC"))
        suc = suc + 1
      if (line.startsWith("ERR"))
        err = err + 1
    });

    lineReader.on('close', function () {
      resolve({ folder: fo, file: fi, cnt: cnt, suc: suc, err: err })
    });
  })
}



export async function outputProcessedStats2() {
  const promises = []
  var folders = fs.readdirSync(`${baseDataFolder}/static/output_processed`)
  folders.forEach(async (fo) => {
    var files = fs.readdirSync(`${baseDataFolder}/static/output_processed/${fo}`)
    files.forEach(fi => {
      promises.push(scanCmdSucErr(fo, fi))
    })
  })
  const ret = await Promise.all(promises)
  var ret2 = []
  ret.forEach(p => {
    p.forEach(r => {
      var elm = ret2.find(v => v.cmd === r.cmd)
      if (elm != undefined) {
        elm.suc = elm.suc + r.suc
        elm.err = elm.err + r.err
      }
      else {
        ret2.push(r)
      }
    })
  })
  return ret2
}

function scanCmdSucErr(fo, fi) {
  const fileName = `${fo}/${fi}`
  return new Promise((resolve) => {
    var ret = []
    var currRet
    var lineReader = readline.createInterface({
      input: fs.createReadStream(fileName)
    });

    lineReader.on('line', function (line) {
      if (line.startsWith("CMD")) {
        currRet = ret.find((el) => el.cmd === line.substring(4))
        if (currRet == undefined) {
          currRet = ret[ret.push({ cmd: line.substring(4), suc: 0, err: 0 }) - 1]
        }
      }
      if (line.startsWith("SUC"))
        currRet.suc = currRet.suc + 1
      if (line.startsWith("ERR"))
        currRet.err = currRet.err + 1
    });

    lineReader.on('close', function () {
      resolve(ret)
    });
  })
}

export async function outputProcessedStats3(date) {
  const promises = []
  const fo = `${baseDataFolder}/${date}/output_processed`
  var files = fs.readdirSync(fo)
  files.forEach(fi => {
    promises.push(scanCmdSucErr(fo, fi))
  })
  const ret = await Promise.all(promises)
  var ret2 = []
  ret.forEach(p => {
    p.forEach(r => {
      var elm = ret2.find(v => v.cmd === r.cmd)
      if (elm != undefined) {
        elm.suc = elm.suc + r.suc
        elm.err = elm.err + r.err
      }
      else {
        ret2.push(r)
      }
    })
  })
  return ret2
}

function onP(m, tm) {
  return new Promise((resolve) => {
    setTimeout(() => {
      console.log(m)
      resolve(1)
    }, tm)
  })
}



async function getPrice() {
  const [choice, prices] = await Promise.all([
    promptForDishChoice(),
    fetchPrices(),
  ]);
  return prices[choice];
}



export async function o() {
  const ret = await Promise.all([
    scanSingleFile('${baseDataFolder}/static/output_processed/ACCOUNT/20251022_192947_00007_Fi-Batch-cashAccount1007000500055127x47x0x1761154186144.output'),
    scanSingleFile('${baseDataFolder}/static/output_processed/ACCOUNT/20251022_192947_00006_Fi-Batch-cashAccount1007000500032053x47x0x1761154185454.output')
  ])
  return ret
}


export async function opStatsForDay(day) {
  const promises = []
  var files = fs.readdirSync(`${baseDataFolder}/${day}/output_processed`)
  files.forEach(fi => {
    promises.push(scanSucErr2(`${baseDataFolder}/${day}/output_processed/${fi}`))
  })
  const ret = await Promise.all(promises)
  return ret
}

function scanSucErr2(fi) {
  return new Promise((resolve) => {
    var cnt = 0, suc = 0, err = 0
    var lineReader = readline.createInterface({
      input: fs.createReadStream(fi)
    });

    lineReader.on('line', function (line) {
      cnt = cnt + 1
      if (line.startsWith("SUC"))
        suc = suc + 1
      if (line.startsWith("ERR"))
        err = err + 1
    });

    lineReader.on('close', function () {
      resolve({ file: fi, cnt: cnt, suc: suc, err: err })
    });
  })
}




// TTI stuff

function scanTraceFolder(date) {
  var ret = []
  var folders = fs.readdirSync(`${baseDataFolder}/${date}/trace`)
  folders.forEach(async (fo) => {
    var files = fs.readdirSync(`${baseDataFolder}/${date}/trace/${fo}`)
    files.forEach(fi => {
      const tokens = fi.split('_')
      ret.push({ date: tokens[0], time: tokens[1], millis: tokens[2], thread: tokens[3], type: tokens[4], flow: tokens[5], uuid: tokens[6] })
    })
  })
  return ret
}

//msgin,out,etc
export async function ttiStats(date) {
  const ret = scanTraceFolder(date)
  var ret2 = []
  ret.forEach(r => {
    var elm = ret2.find(v => v.type === r.type)
    if (elm != undefined) {
      elm.count = elm.count + 1
    }
    else {
      ret2.push({ type: r.type, count: 1 })
    }

  })
  return ret2
}

//msgin by flow
export async function ttiStatsByFlow(date) {
  const ret = scanTraceFolder(date)
  var ret2 = []
  ret.forEach(r => {
    var elm = ret2.find(v => v.flow === r.flow)
    if (elm != undefined) {
      elm.count = elm.count + 1
    }
    else {
      ret2.push({ flow: r.flow, count: 1 })
    }

  })
  return ret2
}


