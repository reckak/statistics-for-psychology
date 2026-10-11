// Run from the project root using the bundled artifact-tool runtime.
import fs from 'node:fs/promises';
import { createRequire } from 'node:module';
import { pathToFileURL } from 'node:url';
import { addStudentInputs } from './sesity-data.mjs';
const require=createRequire(import.meta.url);
const {Workbook,SpreadsheetFile}=await import(pathToFileURL(process.env.ARTIFACT_TOOL_MODULE||require.resolve('@oai/artifact-tool')).href);
const wb=Workbook.create();wb.worksheets.add('Prehled');
const out='tmp/chapter-01-build';await fs.mkdir(out,{recursive:true});
await addStudentInputs(wb,1,out);
wb.recalculate();
await (await SpreadsheetFile.exportXlsx(wb)).save('data/kapitola_01.xlsx');
await fs.rename('data/kapitola_01.xlsx.inspect.ndjson',`${out}/export.ndjson`).catch(e=>{if(e.code!=='ENOENT')throw e;});
