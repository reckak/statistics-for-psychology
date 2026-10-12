import { ExcelWorkbook } from './excel-workbook.mjs';
import fs from 'node:fs/promises';
import { spawnSync } from 'node:child_process';
import { addStudentInputs } from './sesity-data.mjs';
const wb=new ExcelWorkbook();wb.worksheets.add('Prehled');
const out='tmp/chapter-01-build';await fs.mkdir(out,{recursive:true});
const sim = spawnSync('Rscript', ['--vanilla', 'scripts/kapitola_01-simulace.R'], {
  stdio:'inherit', env:{...process.env, ...(process.platform==='win32' ? {LC_ALL:'.UTF-8'} : {})}
});
if(sim.error) throw sim.error;
if(sim.status !== 0) throw new Error('Chapter 1 simulation failed');
await addStudentInputs(wb,1,out);
await wb.build(1, 'tmp/chapter-01-build');
