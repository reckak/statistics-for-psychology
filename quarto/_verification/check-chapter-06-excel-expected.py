"""Generator of quarto/_verification/check-chapter-06-excel.json (standard library only).
Run: python quarto/_verification/check-chapter-06-excel-expected.py quarto/_verification/check-chapter-06-excel.json
Expected values are computed here with exact rational binomial sums, math.erfc and a bisection
for normal quantiles, independently of both Excel and the R figure script.
Counts on the simulated sheets are fixed properties of the stored data and are listed as constants."""
import json, math, sys
from fractions import Fraction as F

def pmf(k, n, p): return math.comb(n, k) * F(p) ** k * (1 - F(p)) ** (n - k)
def cdf(k, n, p): return sum(pmf(i, n, p) for i in range(0, k + 1))
def upper(z): return 0.5 * math.erfc(z / math.sqrt(2))
def lower(z): return 0.5 * math.erfc(-z / math.sqrt(2))
def quantile(p):
    lo, hi = -12.0, 12.0
    for _ in range(200):
        mid = (lo + hi) / 2
        if lower(mid) < p: lo = mid
        else: hi = mid
    return (lo + hi) / 2

q, h, f4 = F(1, 4), F(1, 2), F(2, 5)
se_diff, z975, z05 = 2.1213, quantile(0.975), quantile(0.05)
cells = []
def add(sheet, addr, value, tol=None):
    cell = {'sheet': sheet, 'cell': addr, 'expected': float(value)}
    if tol: cell['tolerance'] = tol
    cells.append(cell)
# Quantile-based cells use a looser tolerance than probabilities.
QT = 1e-7
for a, v, t in [('B7', 1.5, None), ('B8', 2, None), ('B9', lower(2), None), ('B10', upper(2), None),
                ('B12', 35 - 1.5 * z975, QT), ('B13', 35 + 1.5 * z975, QT)]: add('Chyba', a, v, t)
zd = 6.88 / se_diff
for a, v, t in [('B7', zd, None), ('B8', 2 * upper(zd), None), ('B9', z975, QT), ('B10', z975 * se_diff, QT)]: add('Test_rozdilu', a, v, t)
for a, v in [('B7', 1 - cdf(9, 20, q)), ('B8', 9), ('B9', 1 - cdf(8, 20, q)), ('E2', 1)]: add('Binom_test', a, v)
for k in range(1, 21): add('Binom_test', f'E{2 + k}', 1 - cdf(k - 1, 20, q))
for a, v, t in [('B8', 2, None), ('B9', -2, None), ('B10', lower(-2), None), ('B11', upper(-2), None), ('B12', 2 * upper(2), None),
                ('B13', 50 + z05 * 2, QT), ('B14', 50 - z975 * 2, QT), ('B15', 50 + z975 * 2, QT), ('B16', 50 - z05 * 2, QT)]: add('Z_test', a, v, t)
crit = z975 * se_diff
def power(d, c=crit, se=se_diff): return upper((c - d) / se), lower((-c - d) / se)
up5, lo5 = power(5)
for a, v, t in [('B4', crit, QT), ('B6', up5, QT), ('B7', lo5, QT), ('B8', up5 + lo5, QT)]: add('Sila', a, v, t)
formulas = [
    ['=NORM.DIST(38;35;1,5;PRAVDA)', lower(2)], ['=NORM.INV(0,025;35;1,5)', 35 - 1.5 * z975, QT],
    ['=1-BINOM.DIST(12;25;0,4;PRAVDA)', 1 - cdf(12, 25, f4)], ['=1-BINOM.DIST(51;100;0,4;PRAVDA)', 1 - cdf(51, 100, f4)],
    ['=1-NORM.DIST(105;100;15;PRAVDA)', upper(1 / 3)], ['=1-NORM.DIST(105;100;5;PRAVDA)', upper(1)],
    ['=2*(1-NORM.S.DIST(1,8;PRAVDA))', 2 * upper(1.8)], ['=1-NORM.S.DIST(1,8;PRAVDA)', upper(1.8)],
    ['=2*(1-NORM.S.DIST(0,5;PRAVDA))', 2 * upper(0.5)],
    ['=NORM.DIST(46,71;45;2;PRAVDA)', lower((46.71 - 45) / 2)], ['=NORM.DIST(46,71;47;2;PRAVDA)', lower((46.71 - 47) / 2)],
    ['=NORM.DIST(48,355;47;1;PRAVDA)', lower(1.355)],
    ['=BINOM.INV(20;0,25;0,95)+1', 9], ['=BINOM.INV(8;0,5;0,95)+1', 7],
    ['=1-BINOM.DIST(6;8;0,5;PRAVDA)', F(9, 256)], ['=1-BINOM.DIST(5;8;0,5;PRAVDA)', F(37, 256)],
    # Counts and summaries of the stored simulated data quoted in the chapter.
    ['=COUNTIFS(Sim_rozdily!A2:A10001;">=4,16")', 261], ['=COUNTIFS(Sim_rozdily!A2:A10001;"<=-4,16")', 236],
    ['=COUNTIFS(Sim_rozdily!A2:A10001;">=6,88")', 7], ['=COUNTIFS(Sim_rozdily!A2:A10001;"<=-6,88")', 4],
    ['=COUNTIFS(Sim_prumery!D2:D10001;">38")', 243], ['=POČET(Sim_prumery!A2:D10001)', 40000], ['=POČET(Sim_rozdily!A2:A10001)', 10000],
    ['=ZAOKROUHLIT(SMODCH.VÝBĚR.S(Sim_prumery!B2:B10001);2)', 6.77], ['=ZAOKROUHLIT(SMODCH.VÝBĚR.S(Sim_prumery!C2:C10001);2)', 2.74],
    ['=ZAOKROUHLIT(SMODCH.VÝBĚR.S(Sim_prumery!D2:D10001);2)', 1.51], ['=ZAOKROUHLIT(SMODCH.VÝBĚR.S(Sim_rozdily!A2:A10001);2)', 2.12],
    ['=ZAOKROUHLIT(PRŮMĚR(Sim_vyber!A2:A31);1)', 36.5], ['=ZAOKROUHLIT(SMODCH.VÝBĚR.S(Sim_vyber!A2:A31);1)', 14.9],
    ['=POČET(Skupiny!A2:B151)', 300], ['=COUNTIFS(Skupiny!A2:A151;"<=50")', 56], ['=MIN(Skupiny!A2:A151)', 10], ['=MAX(Skupiny!A2:A151)', 397],
]
out = {
    'note': 'Expected values: exact rational binomial sums, erfc and bisection quantiles in Python (check-chapter-06-excel-expected.py); counts on Sim_ sheets are properties of the stored data. Not produced by Excel.',
    'cells': cells,
    'formulas': [dict({'formula': f[0], 'expected': float(f[1])}, **({'tolerance': f[2]} if len(f) > 2 else {})) for f in formulas],
    'errors': ['=BINOM.DIST(21;20;0,25;PRAVDA)', '=NORM.S.INV(0)', '=NORM.DIST(38;35;0;PRAVDA)'],
    'texts': [{'sheet': 'Test_rozdilu', 'cell': 'B11', 'expected': 'zamítáme nulovou hypotézu'}, {'sheet': 'Binom_test', 'cell': 'B10', 'expected': 'zamítáme nulovou hypotézu'}],
    'locals': [{'sheet': 'Chyba', 'cell': 'B9', 'formula': '=NORM.DIST(B5;B2;B7;PRAVDA)'}, {'sheet': 'Chyba', 'cell': 'B7', 'formula': '=B3/ODMOCNINA(B4)'},
               {'sheet': 'Test_rozdilu', 'cell': 'B8', 'formula': '=2*(1-NORM.S.DIST(ABS(B7);PRAVDA))'},
               {'sheet': 'Binom_test', 'cell': 'B7', 'formula': '=1-BINOM.DIST(B4-1;B2;B3;PRAVDA)'}, {'sheet': 'Binom_test', 'cell': 'B8', 'formula': '=BINOM.INV(B2;B3;1-B5)+1'},
               {'sheet': 'Z_test', 'cell': 'B10', 'formula': '=NORM.S.DIST(B9;PRAVDA)'}, {'sheet': 'Z_test', 'cell': 'B13', 'formula': '=B2+NORM.S.INV(B6)*B8'},
               {'sheet': 'Sila', 'cell': 'B6', 'formula': '=1-NORM.DIST(B4;B2;B3;PRAVDA)'}],
    'changes': [
        {'sheet': 'Chyba', 'set': {'B4': 400}, 'expect': {'B7': 0.75, 'B8': 4, 'B10': upper(4)}},
        {'sheet': 'Chyba', 'set': {'B2': 100, 'B3': 15, 'B4': 9, 'B5': 105}, 'expect': {'B7': 5, 'B8': 1, 'B10': upper(1)}},
        {'sheet': 'Test_rozdilu', 'set': {'B2': 2.9}, 'expect': {'B7': 2.9 / se_diff, 'B8': 2 * upper(2.9 / se_diff)}, 'labels': {'B11': 'nulovou hypotézu nezamítáme'}},
        {'sheet': 'Test_rozdilu', 'set': {'B2': -6.88}, 'expect': {'B7': -zd, 'B8': 2 * upper(zd)}, 'labels': {'B11': 'zamítáme nulovou hypotézu'}},
        {'sheet': 'Binom_test', 'set': {'B2': 8, 'B3': 0.5, 'B4': 7}, 'expect': {'B7': 9 / 256, 'B8': 7, 'B9': 9 / 256, 'E10': 1 / 256}, 'labels': {'B10': 'zamítáme nulovou hypotézu', 'E11': '', 'E22': ''}},
        {'sheet': 'Binom_test', 'set': {'B2': 8, 'B3': 0.5, 'B4': 6}, 'expect': {'B7': 37 / 256, 'B8': 7}, 'labels': {'B10': 'nulovou hypotézu nezamítáme'}},
        {'sheet': 'Z_test', 'set': {'B2': 100, 'B3': 15, 'B4': 36, 'B5': 104.5}, 'expect': {'B8': 2.5, 'B9': 1.8, 'B11': upper(1.8), 'B12': 2 * upper(1.8), 'B10': lower(1.8)}},
        {'sheet': 'Sila', 'set': {'B2': 0}, 'expect': {'B8': 0.05}, 'tolerance': QT},
        {'sheet': 'Sila', 'set': {'B2': 3}, 'expect': {'B8': sum(power(3))}, 'tolerance': QT},
        {'sheet': 'Sila', 'set': {'B2': 8}, 'expect': {'B8': sum(power(8))}, 'tolerance': QT},
    ],
}
open(sys.argv[1], 'w', encoding='utf-8', newline='\n').write(json.dumps(out, ensure_ascii=False, indent=1) + '\n')
print(len(cells), 'cells,', len(formulas), 'formulas')
