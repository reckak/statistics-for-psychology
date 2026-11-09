"""Generator of quarto/_verification/check-chapter-09-excel.json (standard library only).
Run: python quarto/_verification/check-chapter-09-excel-expected.py quarto/_verification/check-chapter-09-excel.json
Expected values are computed here independently of both Excel and the R figure script:
the normal distribution through math.erfc with bisection quantiles, the chi-square upper tail
through the regularized incomplete gamma function (series and continued fraction), and the
binomial and hypergeometric probabilities through exact binomial coefficients.
Raw inputs are repeated here from the chapter tables; check-workbooks.py compares them with the saved workbook."""
import json, math, sys

QT = 1e-7


def norm_cdf(x):
    return 0.5 * math.erfc(-x / math.sqrt(2))


def norm_quant(p):
    lo, hi = -40.0, 40.0
    for _ in range(200):
        mid = (lo + hi) / 2
        if norm_cdf(mid) < p: lo = mid
        else: hi = mid
    return (lo + hi) / 2


def gamma_q(a, x):
    """Regularized upper incomplete gamma Q(a, x)."""
    if x <= 0: return 1.0
    gln = math.lgamma(a)
    if x < a + 1:
        ap, s, d = a, 1 / a, 1 / a
        for _ in range(10000):
            ap += 1; d *= x / ap; s += d
            if abs(d) < abs(s) * 1e-16: break
        return 1 - s * math.exp(-x + a * math.log(x) - gln)
    tiny = 1e-300
    b = x + 1 - a; c = 1 / tiny; d = 1 / b; h = d
    for i in range(1, 10000):
        an = -i * (i - a); b += 2
        d = an * d + b; d = tiny if abs(d) < tiny else d
        c = b + an / c; c = tiny if abs(c) < tiny else c
        d = 1 / d; delta = d * c; h *= delta
        if abs(delta - 1) < 1e-16: break
    return math.exp(-x + a * math.log(x) - gln) * h


def chi_rt(x, v):
    return gamma_q(v / 2, x / 2)


def chi_inv_rt(p, v):
    lo, hi = 0.0, 1000.0
    for _ in range(300):
        mid = (lo + hi) / 2
        if chi_rt(mid, v) > p: lo = mid
        else: hi = mid
    return (lo + hi) / 2


def binom_cdf(k, n, p):
    return sum(math.comb(n, i) * p ** i * (1 - p) ** (n - i) for i in range(0, k + 1))


def hyper(a, row, col, n):
    return math.comb(col, a) * math.comb(n - col, row - a) / math.comb(n, row)


def wilson(x, n, z):
    p = x / n; c = (p + z * z / (2 * n)) / (1 + z * z / n); h = z / (1 + z * z / n) * math.sqrt(p * (1 - p) / n + z * z / (4 * n * n))
    return c, h, c - h, c + h


Z95 = norm_quant(0.975)


def interval_cells(x, n, level=0.95, p0=0.25):
    z = norm_quant(1 - (1 - level) / 2); p = x / n; se = math.sqrt(p * (1 - p) / n); c, h, lo, hi = wilson(x, n, z)
    zs = (p - p0) / math.sqrt(p0 * (1 - p0) / n)
    return {'B7': p, 'B8': z, 'B9': se, 'B10': p - z * se, 'B11': p + z * se, 'B13': c, 'B14': h, 'B15': lo, 'B16': hi,
            'B18': zs, 'B19': 2 * (1 - norm_cdf(abs(zs)))}


def two_cells(x1, n1, x2, n2, level=0.95):
    z = norm_quant(1 - (1 - level) / 2); p1, p2 = x1 / n1, x2 / n2; d = p1 - p2
    _, _, l1, u1 = wilson(x1, n1, z); _, _, l2, u2 = wilson(x2, n2, z)
    pp = (x1 + x2) / (n1 + n2); se0 = math.sqrt(pp * (1 - pp) * (1 / n1 + 1 / n2)); zz = d / se0
    return {'B8': p1, 'B9': p2, 'B10': d, 'B11': z, 'B12': l1, 'B13': u1, 'B14': l2, 'B15': u2,
            'B16': d - math.sqrt((p1 - l1) ** 2 + (u2 - p2) ** 2), 'B17': d + math.sqrt((u1 - p1) ** 2 + (p2 - l2) ** 2),
            'B19': pp, 'B20': se0, 'B21': zz, 'B22': 2 * (1 - norm_cdf(abs(zz))), 'B23': zz * zz, 'B24': chi_rt(zz * zz, 1)}


def gof_cells(f, p0):
    n = sum(f); e = [n * q for q in p0]; contrib = [(a - b) ** 2 / b for a, b in zip(f, e)]; x = sum(contrib); v = len(f) - 1
    out = {'B7': n, 'B8': x, 'B9': v, 'B10': chi_rt(x, v), 'B11': chi_inv_rt(0.05, v), 'B12': chi_rt(x, v), 'B13': sum(p0)}
    for i in range(4): out[f'D{i+2}'] = e[i]; out[f'E{i+2}'] = contrib[i]
    return out


def table_cells(f):
    rs = [sum(r) for r in f]; cs = [sum(f[i][j] for i in range(3)) for j in range(3)]; n = sum(rs)
    out = {'E6': n}; x = 0; adjp = []
    for i in range(3):
        out[f'E{3+i}'] = rs[i]
        for j, c in enumerate('BCD'):
            e = rs[i] * cs[j] / n; contr = (f[i][j] - e) ** 2 / e; x += contr
            adj = (f[i][j] - e) / math.sqrt(e * (1 - rs[i] / n) * (1 - cs[j] / n)); padj = 2 * (1 - norm_cdf(abs(adj)))
            out[f'{c}{9+i}'] = e; out[f'{c}{14+i}'] = contr; out[f'{c}{24+i}'] = f[i][j] / rs[i]
            out[f'{c}{28+i}'] = (f[i][j] - e) / math.sqrt(e); out[f'{c}{32+i}'] = adj; out[f'{c}{37+i}'] = padj; adjp.append(padj)
    for j, c in enumerate('BCD'): out[f'{c}6'] = cs[j]
    out.update({'B17': x, 'B18': 4, 'B19': chi_rt(x, 4), 'B20': chi_rt(x, 4), 'B21': math.sqrt(x / (n * 2))})
    srt = sorted(adjp); labels = {}; go = True
    for k in range(1, 10):
        out[f'B{40+k}'] = srt[k - 1]; out[f'C{40+k}'] = 0.05 / (10 - k)
        go = go and srt[k - 1] <= 0.05 / (10 - k); labels[f'D{40+k}'] = 'zamítáme' if go else 'nezamítáme'
    return out, labels


def effect_cells(a, b, c, d, level=0.95):
    r1, r2 = a / (a + b), c / (c + d); o1, o2 = a / b, c / d; rr, orr = r1 / r2, o1 / o2; n = a + b + c + d
    x = n * (a * d - b * c) ** 2 / ((a + b) * (c + d) * (a + c) * (b + d)); z = norm_quant(1 - (1 - level) / 2)
    slr = math.sqrt(1 / a - 1 / (a + b) + 1 / c - 1 / (c + d)); slo = math.sqrt(1 / a + 1 / b + 1 / c + 1 / d)
    return {'B5': r1, 'B6': r2, 'B7': r1 - r2, 'B8': rr, 'B9': o1, 'B10': o2, 'B11': orr, 'B12': n, 'B13': x, 'B14': chi_rt(x, 1),
            'B15': math.sqrt(x / n), 'B16': (a * d - b * c) / math.sqrt((a + b) * (c + d) * (a + c) * (b + d)), 'B19': z,
            'B20': slr, 'B21': math.exp(math.log(rr) - z * slr), 'B22': math.exp(math.log(rr) + z * slr),
            'B23': slo, 'B24': math.exp(math.log(orr) - z * slo), 'B25': math.exp(math.log(orr) + z * slo)}


def mcnemar_cells(a, b, c, d):
    n = a + b + c + d; m = b + c
    out = {'B5': n, 'B6': (a + b) / n, 'B7': (a + c) / n, 'B8': (c - b) / n, 'B9': m}
    if m: out.update({'B10': min(1, 2 * binom_cdf(min(b, c), m, 0.5)), 'B11': (c - b) ** 2 / m, 'B12': chi_rt((c - b) ** 2 / m, 1)})
    return out


def fisher_cells(a, b, c, d):
    row, col, n = a + b, a + c, a + b + c + d; lo, hi = max(0, row + col - n), min(row, col)
    pr = {k: hyper(k, row, col, n) for k in range(lo, hi + 1)}; pobs = pr[a]
    out = {'B5': row, 'B6': col, 'B7': n, 'B8': lo, 'B9': hi, 'B10': pobs, 'B11': sum(v for v in pr.values() if v <= pobs * (1 + 1e-7))}
    for k, v in pr.items(): out[f'E{2+k}'] = v
    return out


cells = []
def put(sheet, d):
    for k, v in d.items(): cells.append({'sheet': sheet, 'cell': k, 'expected': v, 'tolerance': QT})
put('Interval_podilu', interval_cells(10, 20))
put('Dva_podily', two_cells(40, 100, 30, 100))
put('Dobra_shoda', gof_cells([12, 16, 21, 31], [0.25] * 4))
tab, tab_labels = table_cells([[25, 18, 12], [30, 22, 28], [10, 20, 25]])
put('Tabulka', tab)
put('Mira_souvislosti', effect_cells(56, 84, 20, 97))
put('McNemar', mcnemar_cells(38, 4, 12, 18))
put('Fisher', fisher_cells(8, 2, 3, 7))

# Czech formulas quoted in the chapter and its solutions, typed as a student would.
f = []
def F(formula, expected, tol=1e-9): f.append({'formula': formula, 'expected': expected, 'tolerance': tol})
F('=CHISQ.DIST.RT(10,1;3)', chi_rt(10.1, 3)); F('=CHISQ.INV.RT(0,05;3)', chi_inv_rt(0.05, 3), 1e-7)
F('=CHISQ.DIST.RT(4;1)', chi_rt(4, 1)); F('=CHISQ.DIST.RT(1,68;2)', chi_rt(1.68, 2))
F('=2*BINOM.DIST(4;16;0,5;PRAVDA)', 2 * binom_cdf(4, 16, 0.5)); F('=2*BINOM.DIST(3;14;0,5;PRAVDA)', 2 * binom_cdf(3, 14, 0.5))
F('=HYPGEOM.DIST(8;10;11;20;NEPRAVDA)', hyper(8, 10, 11, 20))
F('=CHISQ.TEST(Pozice!B2:B5;Dobra_shoda!D2:D5)', chi_rt(10.1, 3))
F('=CHISQ.TEST(Zvladani!B2:D4;Tabulka!B9:D11)', tab['B19'])
F('=SUMA(Pozice!B2:B5)', 80); F('=SUMA(Zvladani!B2:D4)', 190)
F('=2*(1-NORM.S.DIST(ABS(Tabulka!B34);PRAVDA))', tab['B39'])

changes = []
for x, n in ((18, 60), (72, 240), (0, 25), (1, 25), (0, 15), (40, 80)):
    changes.append({'sheet': 'Interval_podilu', 'set': {'B2': x, 'B3': n}, 'expect': interval_cells(x, n)})
for args in ((13, 49, 14, 44), (56, 140, 20, 117), (80, 200, 60, 200), (6, 8, 2, 9)):
    changes.append({'sheet': 'Dva_podily', 'set': dict(zip(('B2', 'B3', 'B4', 'B5'), args)), 'expect': two_cells(*args)})
changes.append({'sheet': 'Dobra_shoda', 'set': {'B2': 52, 'B3': 50, 'B4': 31, 'B5': 17, 'C2': 0.4, 'C3': 0.3, 'C4': 0.2, 'C5': 0.1},
                'expect': gof_cells([52, 50, 31, 17], [0.4, 0.3, 0.2, 0.1])})
u7, u7_labels = table_cells([[28, 14, 18], [22, 25, 13], [12, 30, 18]])
changes.append({'sheet': 'Tabulka', 'set': {'B3': 28, 'C3': 14, 'D3': 18, 'B4': 22, 'C4': 25, 'D4': 13, 'B5': 12, 'C5': 30, 'D5': 18},
                'expect': u7, 'labels': u7_labels})
for args in ((19, 74, 22, 187), (189, 10845, 104, 10933), (40, 60, 30, 70)):
    changes.append({'sheet': 'Mira_souvislosti', 'set': dict(zip(('B2', 'C2', 'B3', 'C3'), args)), 'expect': effect_cells(*args)})
changes.append({'sheet': 'McNemar', 'set': {'B2': 25, 'C2': 3, 'B3': 11, 'C3': 21}, 'expect': mcnemar_cells(25, 3, 11, 21)})
changes.append({'sheet': 'McNemar', 'set': {'B2': 40, 'C2': 0, 'B3': 0, 'C3': 32}, 'expect': mcnemar_cells(40, 0, 0, 32),
                'labels': {'B10': 'nelze: žádná neshodná dvojice', 'B11': 'nelze', 'B12': 'nelze'}})
fu = fisher_cells(6, 2, 2, 7)
changes.append({'sheet': 'Fisher', 'set': {'B2': 6, 'C2': 2, 'B3': 2, 'C3': 7}, 'expect': fu})
for c in changes: c['tolerance'] = QT

out = {
    'note': 'Expected values: erfc normal distribution, regularized incomplete gamma for chi-square, exact binomial and hypergeometric probabilities in Python (check-chapter-09-excel-expected.py). Not produced by Excel or R.',
    'cells': cells,
    'formulas': f,
    'errors': ['=CHISQ.TEST(Pozice!B2:B5;Pozice!B2:B4)', '=CHISQ.DIST.RT(-1;3)', '=CHISQ.INV.RT(1,5;3)'],
    'texts': [{'sheet': 'Tabulka', 'cell': c, 'expected': v} for c, v in tab_labels.items()],
    'blanks': [{'sheet': 'Fisher', 'cell': 'E2'}, {'sheet': 'Fisher', 'cell': 'E13'}],
    'locals': [{'sheet': 'Interval_podilu', 'cell': 'B14', 'formula': '=B8/(1+B8^2/B3)*ODMOCNINA(B7*(1-B7)/B3+B8^2/(4*B3^2))'},
               {'sheet': 'Dva_podily', 'cell': 'B12', 'formula': '=(B8+B11^2/(2*B3))/(1+B11^2/B3)-B11/(1+B11^2/B3)*ODMOCNINA(B8*(1-B8)/B3+B11^2/(4*B3^2))'},
               {'sheet': 'Dva_podily', 'cell': 'B16', 'formula': '=B10-ODMOCNINA((B8-B12)^2+(B15-B9)^2)'},
               {'sheet': 'Dva_podily', 'cell': 'B17', 'formula': '=B10+ODMOCNINA((B13-B8)^2+(B9-B14)^2)'},
               {'sheet': 'Dobra_shoda', 'cell': 'B12', 'formula': '=CHISQ.TEST(B2:B5;D2:D5)'},
               {'sheet': 'Tabulka', 'cell': 'B9', 'formula': '=$E3*B$6/$E$6'},
               {'sheet': 'Tabulka', 'cell': 'B32', 'formula': '=(B3-B9)/ODMOCNINA(B9*(1-$E3/$E$6)*(1-B$6/$E$6))'},
               {'sheet': 'Tabulka', 'cell': 'B21', 'formula': '=ODMOCNINA(B17/(E6*(MIN(ŘÁDKY(B3:D5);SLOUPCE(B3:D5))-1)))'},
               {'sheet': 'Fisher', 'cell': 'B11', 'formula': '=SUMIF(E2:E22;"<="&B10*(1+0,0000001))'}],
    'changes': changes,
}
open(sys.argv[1], 'w', encoding='utf-8', newline='\n').write(json.dumps(out, ensure_ascii=False, indent=1) + '\n')
print(len(cells), 'cells,', len(f), 'formulas,', len(changes), 'changes')
