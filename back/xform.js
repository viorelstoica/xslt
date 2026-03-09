import * as fs from 'fs'
import { Xslt, XmlParser } from 'xslt-processor'
import {inspect} from "util"
import { execSync } from 'child_process'

//const xmlFile = '../data/2025-11-26/trace/AA_instruments_operations/20251126_014740_102_156_postfilter_BatchTransactionAALendingsIntPayment_009ab17d-001e-4a3f-8d98-04cfb7bc3e6e.xml'
//const xslFile = '../xslt/TransactionAALendingsIntPayment/TransactionAALendingsIntPayment-Map.xsl'

const xmlFile = '../data/2026-02-03/trace/AAAFlow/20260203_000601_547_1405_msgin_BatchAAAFlow_01036db5-acf2-4c15-9720-f7782b729682.xml'
const xslFile = '../xslt/TransactionAALendingsIntPayment/TransactionAALendingsIntPayment-Filter.xsl'

const xmlString = fs.readFileSync(xmlFile).toString()
const xslString = fs.readFileSync(xslFile).toString()

//console.log(xmlString)
//console.log(xsltString)

const options = {
  escape: false,
  selfClosingTags: true,
  parameters: [{ name: 'myparam', value: '123' }],
  outputMethod: 'html'
};
const xslt = new Xslt(options);
const xmlParser = new XmlParser();
// Either

var pXml = xmlParser.xmlParse(xmlString)
const pXsl = xmlParser.xmlParse(xslString)

//console.log(inspect(pXml))
//console.log(Object.keys(pXml))
//console.log(pXml.documentElement)

//const outXmlString = await xslt.xsltProcess(pXml, pXsl)
//console.log(outXmlString)
/*
// Or
xslt.xsltProcess(
	xmlParser.xmlParse(xmlString),
	xmlParser.xmlParse(xsltString)
).then(output => {
  console.log(output)
});
*/




const output = execSync(`xsltproc ${xslFile} ${xmlFile}`, { encoding: 'utf-8',  maxBuffer: 10485770 })
console.log(output)
pXml = xmlParser.xmlParse(xmlString)
console.log(pXml)

