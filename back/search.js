import { execSync } from 'child_process'

const output = execSync('grep -l 336469-000 ../data/2025-11-27/output_processed/*', { encoding: 'utf-8' })
var lines = output.split(/\r?\n|\r|\n/g)
lines.forEach(l => {
    if(l.length > 0) {
        console.log(l)
        const uuid = execSync(`grep "^REM XML_Description" ${l}`, { encoding: 'utf-8' })
        const tokens = uuid.split('+')
        console.log(tokens[1])
        const trace = execSync(`find ../data/2025-11-27/trace | grep ${tokens[1]}`, { encoding: 'utf-8' })
        console.log(trace)
    }
})

