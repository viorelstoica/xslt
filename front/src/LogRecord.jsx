export default class LogRecord {
    // 20250527_183920_489_49_msgin_MultiFullPartialExecution_3e57a7ac-bdce-47db-9238-c3fe8e0c1f67.xml
    constructor(b) {
        var tokens = b.split("_")
        this.date = tokens[0]
        this.time = tokens[1]
        this.milli = tokens[2]
        this.thread = tokens[3]
        this.type = tokens[4]
        this.flow = tokens[5]
        //this.uuid = tokens[6].replace(".xml","")
    }
}