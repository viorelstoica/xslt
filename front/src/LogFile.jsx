import LogRecord from "./LogRecord"

export default class LogFile {
  constructor() {
    this.records = []
  }

  addRecord(line) {
    this.records.push(new LogRecord(line))
  }

  getCount() {
    return this.records.length
  }

  clear() {
    return this.records.length = 0
  }

  getDays() {
    var days = {}
    this.records.forEach(x => {
      days[x.date] = days[x.date] ? days[x.date] + 1 : 1
    })
    console.log(`getDays: ${days}`)
    return days
  }

  getTypePerDay() {
    var types = {}
    this.records.forEach(x => {
      if(!(x.date in types))
        types[x.date] = {}
      types[x.date][x.type] = types[x.date][x.type] ? types[x.date][x.type] + 1 : 1
    })
    return types
  }
}