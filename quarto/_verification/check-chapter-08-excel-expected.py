"""Generator of quarto/_verification/check-chapter-08-excel.json (standard library only).
Run: python quarto/_verification/check-chapter-08-excel-expected.py quarto/_verification/check-chapter-08-excel.json
Expected values are computed here independently of both Excel and the R figure script:
the t distribution through the regularized incomplete beta function (continued fraction)
and quantiles by bisection, for integer and non-integer degrees of freedom.
Raw inputs are repeated here from the chapter tables; check-workbooks.py compares them with the saved workbook."""
import json, math, sys


def betacf(a, b, x):
    tiny, eps = 1e-300, 1e-16
    qab, qap, qam = a + b, a + 1, a - 1
    c, d = 1.0, 1 - qab * x / qap
    d = 1 / (d if abs(d) > tiny else tiny)
    h = d
    for m in range(1, 10000):
        m2 = 2 * m
        aa = m * (b - m) * x / ((qam + m2) * (a + m2))
        d = 1 + aa * d; d = 1 / (d if abs(d) > tiny else tiny)
        c = 1 + aa / c; c = c if abs(c) > tiny else tiny
        h *= d * c
        aa = -(a + m) * (qab + m) * x / ((a + m2) * (qap + m2))
        d = 1 + aa * d; d = 1 / (d if abs(d) > tiny else tiny)
        c = 1 + aa / c; c = c if abs(c) > tiny else tiny
        delta = d * c; h *= delta
        if abs(delta - 1) < eps:
            break
    return h


def ibeta(a, b, x):
    if x <= 0: return 0.0
    if x >= 1: return 1.0
    lbt = math.lgamma(a + b) - math.lgamma(a) - math.lgamma(b) + a * math.log(x) + b * math.log(1 - x)
    if x < (a + 1) / (a + b + 2):
        return math.exp(lbt) * betacf(a, b, x) / a
    return 1 - math.exp(lbt) * betacf(b, a, 1 - x) / b


def t_lower(t, v):
    tail = 0.5 * ibeta(v / 2, 0.5, v / (v + t * t))
    return 1 - tail if t > 0 else tail


def p2(t, v): return 2 * t_lower(-abs(t), v)


def t_quant(p, v):
    lo, hi = -200.0, 200.0
    for _ in range(300):
        mid = (lo + hi) / 2
        if t_lower(mid, v) < p: lo = mid
        else: hi = mid
    return (lo + hi) / 2


def mean(x): return sum(x) / len(x)
def sd(x):
    m = mean(x)
    return math.sqrt(sum((v - m) ** 2 for v in x) / (len(x) - 1))


QT = 1e-7
cells = []
def add(sheet, addr, value, tol=QT):
    cell = {'sheet': sheet, 'cell': addr, 'expected': float(value)}
    if tol: cell['tolerance'] = tol
    cells.append(cell)

# Paired version A (Spanek_par); student 9 lacks the second score.
bezny = [58, 44, 51, 39, 62, 47, 55, 42, 53, 49, 60, 45, 52]
kratky = [53, 42, 45, 38, 55, 44, 51, 43, None, 44, 58, 39, 50]
diffs = [b - k for b, k in zip(bezny, kratky) if k is not None]
n, m, s = len(diffs), mean(diffs), sd(diffs); se = s / math.sqrt(n); t = m / se; q = t_quant(0.975, n - 1)
for a, v in [('B2', n), ('B3', m), ('B4', s), ('B7', se), ('B8', n - 1), ('B9', t), ('B10', p2(t, n - 1)), ('B11', q),
             ('B12', m - q * se), ('B13', m + q * se), ('B14', p2(t, n - 1))]:
    add('Parovy_test', a, v)
for r, (b, k) in enumerate(zip(bezny, kratky), 2):
    if k is not None: add('Parovy_test', f'I{r}', b - k, None)


def pooled(m1, s1, n1, m2, s2, n2, level=0.95):
    sp2 = ((n1 - 1) * s1 ** 2 + (n2 - 1) * s2 ** 2) / (n1 + n2 - 2); se = math.sqrt(sp2 * (1 / n1 + 1 / n2)); v = n1 + n2 - 2
    q = t_quant(1 - (1 - level) / 2, v); t = (m1 - m2) / se
    return dict(d=m1 - m2, sp2=sp2, sp=math.sqrt(sp2), se=se, v=v, t=t, p=p2(t, v), q=q, lo=m1 - m2 - q * se, hi=m1 - m2 + q * se, cd=(m1 - m2) / math.sqrt(sp2))


def classic_cells(*args):
    r = pooled(*args)
    return {'B10': r['d'], 'B11': r['sp2'], 'B12': r['sp'], 'B13': r['se'], 'B14': r['v'], 'B15': r['t'], 'B16': r['p'], 'B17': r['q'],
            'B18': r['lo'], 'B19': r['hi'], 'B20': r['cd']}

for a, v in classic_cells(39.03, 14.6, 100, 32.15, 14.6, 100).items():
    add('Klasicky_test', a, v)

# Welch on Spanek_skupiny.
g1 = [67, 55, 54, 46, 43, 41, 57, 41, 54, 44, 40, 47, 41, 51, 45, 47, 62, 44, 49, 54, 69, 36, 56, 49, 51, 53, 58, 53, 52, 41]
g2 = [52, 55, 23, 59, 36, 51, 24, 56, 28, 34, 56, 30]
a1, a2 = sd(g1) ** 2 / len(g1), sd(g2) ** 2 / len(g2)
sew = math.sqrt(a1 + a2); vw = (a1 + a2) ** 2 / (a1 ** 2 / (len(g1) - 1) + a2 ** 2 / (len(g2) - 1)); tw = (mean(g1) - mean(g2)) / sew
qw = t_quant(0.975, vw); rp = pooled(mean(g1), sd(g1), len(g1), mean(g2), sd(g2), len(g2))
for a, v in [('B2', mean(g1)), ('B3', sd(g1)), ('B4', len(g1)), ('B5', mean(g2)), ('B6', sd(g2)), ('B7', len(g2)), ('B10', mean(g1) - mean(g2)),
             ('B11', sew), ('B12', vw), ('B13', tw), ('B14', p2(tw, vw)), ('B15', qw), ('B16', mean(g1) - mean(g2) - qw * sew),
             ('B17', mean(g1) - mean(g2) + qw * sew), ('B19', rp['p']), ('B20', t_quant(0.975, math.floor(vw)))]:
    add('Welch', a, v)

# Change in two groups (Trenink).
zi = [12, -3, 8, -4, 14, 5, 9, -2, 3, 10, -6, 7, 4, 13, 0, -6]
zk = [6, -7, 9, -3, 10, 1, -6, 5, 2, 11, -4, 3, -1, 8, 0, -2]
ti, tk = mean(zi) / (sd(zi) / 4), mean(zk) / (sd(zk) / 4); rz = pooled(mean(zi), sd(zi), 16, mean(zk), sd(zk), 16)
for a, v in [('B2', 16), ('B3', mean(zi)), ('B4', sd(zi)), ('B5', 16), ('B6', mean(zk)), ('B7', sd(zk)), ('B10', ti), ('B11', p2(ti, 15)),
             ('B12', tk), ('B13', p2(tk, 15)), ('B15', rz['d']), ('B16', rz['sp']), ('B17', rz['se']), ('B18', rz['v']), ('B19', rz['t']),
             ('B20', rz['p']), ('B21', rz['lo']), ('B22', rz['hi'])]:
    add('Zmeny', a, v)


def eq_expect(m1, s1, n1, m2, s2, n2, delta, alpha=0.05):
    r = pooled(m1, s1, n1, m2, s2, n2); v, se, d = r['v'], r['se'], r['d']
    q975, q95 = t_quant(1 - alpha / 2, v), t_quant(1 - alpha, v)
    tlo, thi = (d + delta) / se, (d - delta) / se; plo, phi = 1 - t_lower(tlo, v), t_lower(thi, v)
    return {'B11': d, 'B12': r['sp'], 'B13': se, 'B14': v, 'B15': d - q975 * se, 'B16': d + q975 * se, 'B17': p2(d / se, v),
            'B19': d - q95 * se, 'B20': d + q95 * se, 'B23': tlo, 'B24': plo, 'B25': thi, 'B26': phi, 'B27': max(plo, phi)}

for a, v in eq_expect(49.2, 10, 200, 50.1, 10, 200, 3).items():
    add('Ekvivalence_skupin', a, v)

f = []
def F(formula, value, tol=QT): f.append({'formula': formula, 'expected': float(value), 'tolerance': tol})
# Values quoted in the chapter and its solutions.
F('=T.DIST.2T(5,066;11)', p2(5.066, 11)); F('=T.DIST.2T(3,332;198)', p2(3.332, 198)); F('=T.DIST.2T(23,6;12)', p2(23.6, 12), 1e-12)
for v in (11, 198, 48, 19, 12, 21, 38, 15, 30, 24):
    F(f'=T.INV(0,975;{v})', t_quant(0.975, v))
F('=T.INV(0,95;398)', t_quant(0.95, 398)); F('=T.INV(0,975;398)', t_quant(0.975, 398))
F('=1-T.DIST(2,1;398;PRAVDA)', 1 - t_lower(2.1, 398)); F('=T.DIST(-3,9;398;PRAVDA)', t_lower(-3.9, 398), 1e-10)
F('=T.INV.2T(0,05;9,6055)', t_quant(0.975, 9)); F('=T.INV.2T(0,05;13,95)', t_quant(0.975, 13))
F('=ODMOCNINA(9,6055*(1-BETA.INV(0,05;9,6055/2;0,5))/BETA.INV(0,05;9,6055/2;0,5))', t_quant(0.975, 9.6055))
F('=T.DIST.2T(2,795;19)', p2(2.795, 19)); F('=T.DIST.2T(2,367;21)', p2(2.367, 21))
F('=T.DIST.2T(2,773;19)', p2(2.773, 19)); F('=T.DIST.2T(1,032;19)', p2(1.032, 19)); F('=T.DIST.2T(1,178;38)', p2(1.178, 38))
# Exercise data on the input sheets.
kon = [612, 685, 590, 731, 648, 577, 702, 659, None, 624, 690, 605, 668, 641, 720]
nek = [689, 742, 671, 790, 702, 660, None, 731, 698, 701, 768, 672, 735, 699, 805]
d3 = [b - a for a, b in zip(kon, nek) if a is not None and b is not None]
F('=T.TEST(U03_stroop!B2:B16;U03_stroop!C2:C16;2;1)', p2(mean(d3) / (sd(d3) / math.sqrt(len(d3))), len(d3) - 1), 1e-12)
F('=PRŮMĚR(U03_stroop!B2:B16)', mean([x for x in kon if x is not None]), 1e-10); F('=PRŮMĚR(U03_stroop!C2:C16)', mean([x for x in nek if x is not None]), 1e-10)
h1 = [78, 41, 95, 62, 54, 88, 47, 71, 39, 66]
h2 = [52, 48, 61, 44, 57, 50, 46, 55, 49, 63, 51, 45, 58, 53, 47, 60, 50, 54, 42, 56, 49, 52, 59, 48, 51]
b1, b2 = sd(h1) ** 2 / 10, sd(h2) ** 2 / 25; v6 = (b1 + b2) ** 2 / (b1 ** 2 / 9 + b2 ** 2 / 24)
F('=T.TEST(U06_hudba!A2:A11;U06_hudba!B2:B26;2;3)', p2((mean(h1) - mean(h2)) / math.sqrt(b1 + b2), v6), 1e-10)
F('=T.TEST(U06_hudba!A2:A11;U06_hudba!B2:B26;2;2)', pooled(mean(h1), sd(h1), 10, mean(h2), sd(h2), 25)['p'], 1e-10)
F('=SMODCH.VÝBĚR.S(U06_hudba!A2:A11)', sd(h1), 1e-10); F('=SMODCH.VÝBĚR.S(U06_hudba!B2:B26)', sd(h2), 1e-10)

changes = [
    # Vedle_sebe, U05 and U09 summaries entered into the classic sheet.
    {'sheet': 'Klasicky_test', 'set': {'B2': 52, 'B3': 10, 'B4': 25, 'B5': 46, 'B6': 10, 'B7': 25}, 'expect': classic_cells(52, 10, 25, 46, 10, 25)},
    {'sheet': 'Klasicky_test', 'set': {'B2': 9.64, 'B3': 3.17, 'B4': 11, 'B5': 6.58, 'B6': 3.03, 'B7': 12}, 'expect': classic_cells(9.64, 3.17, 11, 6.58, 3.03, 12)},
    {'sheet': 'Klasicky_test', 'set': {'B2': 3.1, 'B3': 5, 'B4': 20, 'B5': 1.2, 'B6': 5.2, 'B7': 20}, 'expect': classic_cells(3.1, 5, 20, 1.2, 5.2, 20)},
    {'sheet': 'Parovy_test', 'set': {'B5': 0.9}, 'expect': {'B12': m - t_quant(0.95, n - 1) * se, 'B13': m + t_quant(0.95, n - 1) * se}},
]
for c in changes: c['tolerance'] = QT
labels = {'velka': ('nulovou hypotézu nezamítáme', 'ekvivalence doložena'), 'mala': ('nulovou hypotézu nezamítáme', 'ekvivalence nedoložena')}
e = eq_expect(49.2, 10, 30, 50.1, 10, 30, 3)
changes.append({'sheet': 'Ekvivalence_skupin', 'set': {'B5': 30, 'B8': 30}, 'expect': {k: e[k] for k in ('B15', 'B16', 'B17', 'B19', 'B20', 'B27')},
                'tolerance': QT, 'labels': {'B18': labels['mala'][0], 'B21': labels['mala'][1]}})
for nn, verdict in ((250, 'ekvivalence doložena'), (40, 'ekvivalence nedoložena')):
    e = eq_expect(30.6, 8, nn, 30, 8, nn, 2)
    changes.append({'sheet': 'Ekvivalence_skupin', 'set': {'B2': 2, 'B3': 30.6, 'B4': 8, 'B5': nn, 'B6': 30, 'B7': 8, 'B8': nn},
                    'expect': {k: e[k] for k in ('B15', 'B16', 'B19', 'B20', 'B27')}, 'tolerance': QT,
                    'labels': {'B18': 'nulovou hypotézu nezamítáme', 'B21': verdict}})
for alpha in (0.01, 0.10):
    e = eq_expect(49.2, 10, 200, 50.1, 10, 200, 3, alpha)
    diff, equiv = f'{100*(1-alpha):.0f}', f'{100*(1-2*alpha):.0f}'
    changes.append({'sheet': 'Ekvivalence_skupin', 'set': {'B9': alpha}, 'expect': {k: e[k] for k in ('B15', 'B16', 'B19', 'B20')}, 'tolerance': QT,
                    'labels': {'A15': f'Test rozdílu: dolní mez {diff}% intervalu', 'A19': f'Test ekvivalence: dolní mez {equiv}% intervalu',
                               'D19': f'{equiv}% interval slouží testu ekvivalence:'}})

out = {
    'note': 'Expected values: regularized incomplete beta (continued fraction) for the t distribution and bisection quantiles in Python (check-chapter-08-excel-expected.py), including non-integer Welch degrees of freedom. Not produced by Excel.',
    'cells': cells,
    'formulas': f,
    'errors': ['=T.TEST(U03_stroop!B2:B16;U03_stroop!C2:C15;2;1)', '=BETA.INV(0;5;0,5)', '=T.DIST.2T(-2;24)'],
    'texts': [{'sheet': 'Ekvivalence_skupin', 'cell': 'B18', 'expected': 'nulovou hypotézu nezamítáme'}, {'sheet': 'Ekvivalence_skupin', 'cell': 'B21', 'expected': 'ekvivalence doložena'}],
    'blanks': [{'sheet': 'Parovy_test', 'cell': c} for c in ('G10', 'H10', 'I10')] + [{'sheet': 'Spanek_par', 'cell': 'C10'}],
    'locals': [{'sheet': 'Parovy_test', 'cell': 'G2', 'formula': '=KDYŽ(A(JE.ČISLO(Spanek_par!B2);JE.ČISLO(Spanek_par!C2));Spanek_par!B2;"")'},
               {'sheet': 'Parovy_test', 'cell': 'I2', 'formula': '=KDYŽ(G2="";"";G2-H2)'},
               {'sheet': 'Parovy_test', 'cell': 'B14', 'formula': '=T.TEST(G2:G14;H2:H14;2;1)'},
               {'sheet': 'Klasicky_test', 'cell': 'B11', 'formula': '=((B4-1)*B3^2+(B7-1)*B6^2)/(B4+B7-2)'},
               {'sheet': 'Welch', 'cell': 'B12', 'formula': '=(B3^2/B4+B6^2/B7)^2/((B3^2/B4)^2/(B4-1)+(B6^2/B7)^2/(B7-1))'},
               {'sheet': 'Welch', 'cell': 'B14', 'formula': '=T.TEST(Spanek_skupiny!A2:A31;Spanek_skupiny!B2:B13;2;3)'},
               {'sheet': 'Welch', 'cell': 'B15', 'formula': '=ODMOCNINA(B12*(1-BETA.INV(1-B8;B12/2;0,5))/BETA.INV(1-B8;B12/2;0,5))'},
               {'sheet': 'Ekvivalence_skupin', 'cell': 'B21', 'formula': '=KDYŽ(A(B19>=-B2;B20<=B2);"ekvivalence doložena";"ekvivalence nedoložena")'}],
    'changes': changes,
}
open(sys.argv[1], 'w', encoding='utf-8', newline='\n').write(json.dumps(out, ensure_ascii=False, indent=1) + '\n')
print(len(cells), 'cells,', len(f), 'formulas,', len(changes), 'changes')
