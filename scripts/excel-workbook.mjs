// Project-owned declarations for native Excel. No spreadsheet package or evaluator.
// Operations are replayed, in order, by build-workbook-excel.ps1.
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { execFileSync } from 'node:child_process';

class Range {
  constructor(sheet, address) { this.sheet = sheet; this.address = address; }
  emit(kind, value) { this.sheet.book.operations.push({sheet:this.sheet.name, address:this.address, kind, value}); }
  set values(value) { this.emit('values', value); }
  set formulas(value) { this.emit('formulas', value); }
  set formulasLocal(value) { this.emit('formulasLocal', value); }
  set format(value) { this.emit('format', value); }
  get format() { return new Proxy({}, {set:(_, key, value) => {this.format = {[key]:value}; return true;}}); }
  set dataValidation(value) { this.emit('validation', value.rule); }
  setNumberFormat(value) { this.emit('numberFormat', value); }
  merge() { this.emit('merge'); }
  fillDown() { this.emit('fillDown'); }
}

export class ExcelWorkbook {
  constructor() {
    this.operations = [];
    this.sheets = [];
    this.charts = [];
    this.worksheets = {
      add: name => {
        if (this.sheets.some(s => s.name === name)) throw new Error(`Duplicate sheet: ${name}`);
        const sheet = {name, book:this, getRange:address => new Range(sheet,address),
          freezePanes:{freezeRows:rows => {sheet.freezeRows=rows;}}};
        this.sheets.push(sheet);
        return sheet;
      },
      getItem: name => {
        const sheet = this.sheets.find(s => s.name === name);
        if (!sheet) throw new Error(`Unknown sheet: ${name}`);
        return sheet;
      }
    };
  }
  addChart(spec) { this.charts.push(spec); }
  async build(chapter, out) {
    await fs.mkdir(out,{recursive:true});
    const spec = {chapter, sheets:this.sheets.map(({name,showGridLines,freezeRows}) => ({name,showGridLines,freezeRows})),
      operations:this.operations, charts:this.charts};
    const manifest = path.resolve(out,'build.json');
    await fs.writeFile(manifest,JSON.stringify(spec,null,2));
    const script = fileURLToPath(new URL('./build-workbook-excel.ps1',import.meta.url));
    execFileSync('powershell.exe',['-NoProfile','-ExecutionPolicy','Bypass','-File',script,'-Manifest',manifest],{stdio:'inherit'});
  }
}
