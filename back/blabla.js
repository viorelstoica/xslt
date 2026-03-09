import { getXmlFile, getXmlUuid, outputProcessedStats, outputProcessedStats2, outputProcessedStats3, ttiStats, ttiStatsByFlow } from './read.js'
import { opStatsForDay } from './read.js'
import 'util'

async function test0() {
    var data = await getXmlFile('../data/2025-11-25/xml/20251125_212454_497_89_MultiCustomer_92aa2782-0cc7-47cf-8392-8f4ca66953fd.xml')
    Object.keys(data).forEach((k, v) => { console.log(data[k]['output'])})
    console.log(data)
}
//test0()

async function test1() {
    const data = await outputProcessedStats()
    console.log(data)
}

async function test2(day) {
    const data = await outputProcessedStats3(day)
    console.log(data)
}

async function test3(day) {
    const ret = await ttiStats(day)
    console.log(ret)
}
//test3(process.argv[2])

async function test4(day) {
    const ret = await opStatsForDay(day)
    console.dir(ret, {'maxArrayLength': null})
}

async function test5(day) {
    const ret = await ttiStatsByFlow(day)
    console.log(ret)
}

async function test6() {
    var ret = await getXmlUuid('2026-02-01')
    console.dir(ret, {'maxArrayLength': null})
}

test1()
//test2(process.argv[2])
//test3(process.argv[2])
//test4(process.argv[2])
//test5(process.argv[2])
//test6()
