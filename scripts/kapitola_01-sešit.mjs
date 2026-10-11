import { ExcelWorkbook } from './excel-workbook.mjs';
import fs from 'node:fs/promises';
import { addStudentInputs } from './sesity-data.mjs';
const wb=new ExcelWorkbook();wb.worksheets.add('Prehled');
const out='tmp/chapter-01-build';await fs.mkdir(out,{recursive:true});
await addStudentInputs(wb,1,out);
await wb.build(1, 'tmp/chapter-01-build');
