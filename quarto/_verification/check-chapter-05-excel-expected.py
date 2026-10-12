"""Generator of quarto/_verification/check-chapter-05-excel.json (standard library only).
Run: python quarto/_verification/check-chapter-05-excel-expected.py quarto/_verification/check-chapter-05-excel.json
Expected values are computed here with exact rational binomial sums and math.erfc,
independently of both Excel and the R figure script."""
import json, math, sys
from fractions import Fraction as F

def pmf(k, n, p): return math.comb(n, k) * F(p) ** k * (1 - F(p)) ** (n - k)
def cdf(k, n, p): return sum(pmf(i, n, p) for i in range(0, k + 1))
def upper_norm(z): return 0.5 * math.erfc(z / math.sqrt(2))
q, h, t, f6 = F(1, 4), F(1, 2), F(1, 5), F(3, 5)
cells = []
def add(sheet, addr, value): cells.append({'sheet': sheet, 'cell': addr, 'expected': float(value)})
for a, v in {'B7': 100, 'B8': 900, 'B9': 95, 'B10': 5, 'B11': 90, 'B12': 810, 'B13': 185, 'B14': 815,
             'B16': F(95, 185), 'B17': F(810, 815), 'B19': F(185, 1000), 'B20': F(95, 185)}.items(): add('Bayes', a, v)
for k in range(6):
    add('Binom', f'B{6 + k}', pmf(k, 5, q)); add('Binom', f'C{6 + k}', cdf(k, 5, q)); add('Binom', f'D{6 + k}', 1 - cdf(k, 5, q) + pmf(k, 5, q))
for a, v in {'B13': 1, 'B14': F(5, 4), 'B15': math.sqrt(5 * .25 * .75), 'B17': 120, 'B18': 10, 'B19': pmf(2, 5, q)}.items(): add('Binom', a, v)
for a, v in {'B7': pmf(5, 20, q), 'B8': cdf(5, 20, q), 'B9': 1 - cdf(9, 20, q), 'B10': 1 - cdf(9, 20, q), 'B11': 5,
             'B12': math.sqrt(20 * .25 * .75), 'B13': 8}.items(): add('Binom_20', a, v)
for k in range(21): add('Binom_20', f'E{2 + k}', pmf(k, 20, q))
sd = math.sqrt(48)
for a, v in {'B6': 120, 'B7': 80, 'B8': sd, 'B9': 15 / sd, 'B10': upper_norm(15 / sd), 'B11': 1 - cdf(134, 200, f6),
             'B12': upper_norm(14.5 / sd), 'B14': 0.675, 'B15': math.sqrt(.6 * .4 / 200), 'B16': 15 / sd}.items(): add('Aproximace', a, v)
formulas = [
    ['=FAKTORIÁL(5)', 120], ['=FAKTORIÁL(0)', 1], ['=FAKTORIÁL(10)', 3628800],
    ['=KOMBINACE(5;2)', 10], ['=KOMBINACE(4;3)', 4], ['=KOMBINACE(100;3)', 161700], ['=PERMUTACE(100;3)', 970200], ['=PERMUTACE(5;2)', 20],
    ['=BINOM.DIST(2;5;0,25;NEPRAVDA)', pmf(2, 5, q)], ['=BINOM.DIST(2;5;0,25;PRAVDA)', cdf(2, 5, q)],
    ['=BINOM.DIST.RANGE(20;0,25;10;20)', 1 - cdf(9, 20, q)], ['=BINOM.INV(20;0,25;0,95)', 8],
    ['=BINOM.DIST(7;20;0,25;PRAVDA)', cdf(7, 20, q)], ['=BINOM.DIST(8;20;0,25;PRAVDA)', cdf(8, 20, q)],
    ['=BINOM.DIST(9;10;0,5;NEPRAVDA)', pmf(9, 10, h)], ['=1-BINOM.DIST(8;10;0,5;PRAVDA)', 1 - cdf(8, 10, h)],
    ['=BINOM.DIST(120;200;0,6;NEPRAVDA)', pmf(120, 200, f6)],
    ['=1-NORM.S.DIST(2,165;PRAVDA)', upper_norm(2.165)], ['=1-BINOM.DIST(134;200;0,6;PRAVDA)', 1 - cdf(134, 200, f6)],
    ['=BINOM.DIST(3;15;0,2;NEPRAVDA)', pmf(3, 15, t)], ['=BINOM.DIST(3;15;0,2;PRAVDA)', cdf(3, 15, t)],
    ['=1-BINOM.DIST(6;15;0,2;PRAVDA)', 1 - cdf(6, 15, t)], ['=BINOM.DIST.RANGE(15;0,2;7;15)', 1 - cdf(6, 15, t)],
    ['=1-NORM.S.DIST(3;PRAVDA)', upper_norm(3)], ['=1-BINOM.DIST(64;100;0,5;PRAVDA)', 1 - cdf(64, 100, h)],
    ['=1-NORM.S.DIST(2,9;PRAVDA)', upper_norm(2.9)],
    ['=1-BINOM.DIST(9;20;0,25;PRAVDA)', 1 - cdf(9, 20, q)], ['=1-NORM.S.DIST(5/ODMOCNINA(3,75);PRAVDA)', upper_norm(5 / math.sqrt(3.75))],
]
out = {
    'note': 'Expected values: exact rational binomial sums and erfc in Python (check-chapter-05-excel-expected.py); not produced by Excel or R.',
    'cells': cells,
    'formulas': [{'formula': f, 'expected': float(v)} for f, v in formulas],
    'errors': ['=BINOM.DIST(6;5;0,25;NEPRAVDA)', '=BINOM.DIST(2;5;1,2;NEPRAVDA)', '=KOMBINACE(2;5)', '=FAKTORIÁL(-1)', '=BINOM.INV(20;0,25;1)'],
    'changes': [
        {'sheet': 'Bayes', 'set': {'B2': 10000, 'B3': 0.01}, 'expect': {'B9': 95, 'B11': 990, 'B13': 1085, 'B16': 95 / 1085, 'B20': 95 / 1085, 'B17': 8910 / 8915}},
        {'sheet': 'Bayes', 'set': {'B2': 10000, 'B3': 0.1}, 'expect': {'B9': 950, 'B11': 900, 'B16': 950 / 1850}},
        {'sheet': 'Binom', 'set': {'B3': 0.5}, 'expect': {'B8': float(pmf(2, 5, h)), 'B13': 1, 'B14': 2.5, 'B19': float(pmf(2, 5, h))}},
        {'sheet': 'Binom_20', 'set': {'B4': 6, 'B5': 11},
         'expect': {'B7': float(pmf(6, 20, q)), 'B8': float(cdf(6, 20, q)), 'B9': float(1-cdf(10, 20, q)), 'B10': float(1-cdf(10, 20, q))},
         'labels': {'A7': 'Právě: P(X = 6)', 'A8': 'Nejvýše: P(X ≤ 6)', 'A9': 'Alespoň: P(X ≥ 11)', 'A19': 'Alespoň 11 = 1 − nejvýše 10, proto B5 − 1.'}},
        {'sheet': 'Binom', 'set': {'B3': 0}, 'expect': {'B6': 1, 'B13': 1, 'B19': 0}},
        {'sheet': 'Binom', 'set': {'B3': 1}, 'expect': {'B11': 1, 'B13': 1, 'B19': 0}},
        {'sheet': 'Binom_20', 'set': {'B4': 0, 'B5': 1}, 'expect': {'B7': float(pmf(0, 20, q)), 'B9': float(1-pmf(0, 20, q))}},
        {'sheet': 'Binom_20', 'set': {'B4': 20, 'B5': 20}, 'expect': {'B7': float(pmf(20, 20, q)), 'B8': 1, 'B9': float(pmf(20, 20, q))}},
        {'sheet': 'Binom_20', 'set': {'B3': 1, 'B4': 0}, 'expect': {'B7': 0, 'B9': 1, 'B10': 1, 'B13': 20, 'E2': 0, 'E22': 1}},
        {'sheet': 'Binom_20', 'set': {'B3': 0, 'B4': 0}, 'expect': {'B7': 1, 'B9': 0, 'B10': 0, 'B13': 0, 'E2': 1, 'E22': 0}},
        {'sheet': 'Binom_20', 'set': {'B3': 0.5}, 'expect': {'B9': float(1 - cdf(9, 20, h)), 'B10': float(1 - cdf(9, 20, h)), 'B11': 10}},
        {'sheet': 'Aproximace', 'set': {'B2': 100, 'B3': 0.5, 'B4': 65}, 'expect': {'B8': 5, 'B9': 3, 'B10': upper_norm(3), 'B11': float(1 - cdf(64, 100, h)), 'B12': upper_norm(2.9), 'B15': 0.05, 'B16': 3}},
    ],
}
open(sys.argv[1], 'w', encoding='utf-8', newline='\n').write(json.dumps(out, ensure_ascii=False, indent=1) + '\n')
print(len(cells), 'cells,', len(formulas), 'formulas')
