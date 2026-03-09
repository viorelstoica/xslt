import { getFile, o, outputProcessedStats, outputProcessedStats2, outputProcessedStats3, ttiStats } from './drread.js'

async function test0() {
    var data = await getFile('file')
    console.log(data)
}

async function test1() {
    const data = await outputProcessedStats()
    console.log(data)
}

async function test2() {
    const data = await outputProcessedStats2()
    console.log(data)
}

async function test3() {
    const data = await outputProcessedStats3(process.argv[2])
    console.log(data)
}

async function test4() {
    const ret = await ttiStats('2026-02-26')
    console.log(ret)
}
test2()