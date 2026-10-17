"""Generator of quarto/_verification/check-chapter-07-excel.json (standard library only).
Run: python quarto/_verification/check-chapter-07-excel-expected.py quarto/_verification/check-chapter-07-excel.json
Expected values are computed here independently of both Excel and the R figure script:
the t distribution through the regularized incomplete beta function (continued fraction),
the normal distribution through math.erfc, and quantiles by bisection.
Counts on the simulated sheet are fixed properties of the stored data and are listed as constants."""
import json, math, sys


def upper_z(z): return 0.5 * math.erfc(z / math.sqrt(2))
def lower_z(z): return 0.5 * math.erfc(-z / math.sqrt(2))


def betacf(a, b, x):
    # Modified Lentz continued fraction for the incomplete beta function.
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
    """P(T <= t) for Student's t with v degrees of freedom."""
    tail = 0.5 * ibeta(v / 2, 0.5, v / (v + t * t))
    return 1 - tail if t > 0 else tail


def t_quant(p, v):
    lo, hi = -200.0, 200.0
    for _ in range(300):
        mid = (lo + hi) / 2
        if t_lower(mid, v) < p: lo = mid
        else: hi = mid
    return (lo + hi) / 2


def z_quant(p):
    lo, hi = -12.0, 12.0
    for _ in range(200):
        mid = (lo + hi) / 2
        if lower_z(mid) < p: lo = mid
        else: hi = mid
    return (lo + hi) / 2


QT = 1e-7
cells = []
def add(sheet, addr, value, tol=None):
    cell = {'sheet': sheet, 'cell': addr, 'expected': float(value)}
    if tol: cell['tolerance'] = tol
    cells.append(cell)

z975 = z_quant(0.975)
for a, v, t in [('B7', 2, None), ('B8', z975, QT), ('B9', 2 * z975, QT), ('B10', 46 - 2 * z975, QT), ('B11', 46 + 2 * z975, QT)]:
    add('Interval_z', a, v, t)
q24 = t_quant(0.975, 24)
for a, v, t in [('B7', 2, None), ('B8', 24, None), ('B9', q24, QT), ('B10', 2 * q24, QT), ('B11', 46 - 2 * q24, QT), ('B12', 46 + 2 * q24, QT)]:
    add('Interval_t', a, v, t)
for a, v, t in [('B8', 2, None), ('B9', 24, None), ('B10', -2, None), ('B11', t_lower(-2, 24), QT), ('B12', 1 - t_lower(-2, 24), QT),
                ('B13', 2 * t_lower(-2, 24), QT), ('B14', q24, QT)]:
    add('T_test', a, v, t)


def eq_expect(m, s, n, mu0=50, delta=3):
    se, v = s / math.sqrt(n), n - 1
    q975, q95 = t_quant(0.975, v), t_quant(0.95, v)
    tl, tu = (m - (mu0 - delta)) / se, (m - (mu0 + delta)) / se
    pl, pu = 1 - t_lower(tl, v), t_lower(tu, v)
    return {'B9': se, 'B10': v, 'B11': mu0 - delta, 'B12': mu0 + delta,
            'B14': m - q975 * se, 'B15': m + q975 * se, 'B16': 2 * t_lower(-abs((m - mu0) / se), v),
            'B18': m - q95 * se, 'B19': m + q95 * se, 'B22': tl, 'B23': pl, 'B24': tu, 'B25': pu, 'B26': max(pl, pu)}

for a, v in eq_expect(48.5, 10, 400).items():
    add('Ekvivalence', a, v, QT if a not in ('B10', 'B11', 'B12') else None)

f = []
def F(formula, value, tol=QT): f.append({'formula': formula, 'expected': float(value), 'tolerance': tol})
# Quantiles and probabilities quoted in the chapter and its solutions.
for v in (4, 9, 24, 99, 29, 15, 19, 55, 149, 199, 399):
    F(f'=T.INV(0,975;{v})', t_quant(0.975, v))
for v in (24, 29, 149, 199, 399):
    F(f'=T.INV(0,95;{v})', t_quant(0.95, v))
F('=T.INV(0,05;24)', t_quant(0.05, 24)); F('=T.INV(0,025;10)', t_quant(0.025, 10)); F('=T.INV(0,975;10)', t_quant(0.975, 10))
F('=T.DIST(-2;24;PRAVDA)', t_lower(-2, 24)); F('=T.DIST.2T(2;24)', 2 * t_lower(-2, 24))
F('=T.DIST.2T(2;15)', 2 * t_lower(-2, 15)); F('=1-T.DIST(2;15;PRAVDA)', t_lower(-2, 15))
F('=T.DIST.2T(2,453;55)', 2 * t_lower(-2.453, 55))
F('=1-T.DIST(3;399;PRAVDA)', 1 - t_lower(3, 399)); F('=T.DIST(-9;399;PRAVDA)', t_lower(-9, 399), 1e-12)
F('=1-T.DIST(5,307;149;PRAVDA)', 1 - t_lower(5.307, 149), 1e-9); F('=T.DIST(-2,858;149;PRAVDA)', t_lower(-2.858, 149))
F('=1-T.DIST(2,373;29;PRAVDA)', 1 - t_lower(2.373, 29)); F('=T.DIST(-1,278;29;PRAVDA)', t_lower(-1.278, 29))
F('=1-T.DIST(1,697;199;PRAVDA)', 1 - t_lower(1.697, 199))
F('=T.DIST.2T(3,151;19)', 2 * t_lower(-3.151, 19))
F('=NORM.S.INV(0,995)', z_quant(0.995)); F('=NORM.S.INV(0,95)', z_quant(0.95))
for mean in (15, 16, 17, 14, 13):
    F(f'=1-NORM.DIST(25;{mean};6;PRAVDA)', upper_z((25 - mean) / 6))
for mean in (47, 50, 53):
    F(f'=NORM.DIST(40;{mean};10;PRAVDA)', lower_z((40 - mean) / 10))
# Exercise data on the input sheets.
words = [12, 15, 9, 14, 11, 13, 16, 10, 12, 14]
anx = [18, 22, 25, 19, 24, 21, 27, 17, 23, 20, 26, 22, 19, 28, 21, 24, 18, 25, 23, 22]
def sd(x):
    m = sum(x) / len(x)
    return math.sqrt(sum((v - m) ** 2 for v in x) / (len(x) - 1))
F('=PRŮMĚR(U05_slova!A2:A11)', sum(words) / 10, 1e-12); F('=SMODCH.VÝBĚR.S(U05_slova!A2:A11)', sd(words), 1e-12)
F('=PRŮMĚR(U07_uzkost!A2:A21)', sum(anx) / 20, 1e-12); F('=SMODCH.VÝBĚR.S(U07_uzkost!A2:A21)', sd(anx), 1e-12)
m7, s7 = sum(anx) / 20, sd(anx)
F('=T.DIST.2T(ABS((PRŮMĚR(U07_uzkost!A2:A21)-20)/(SMODCH.VÝBĚR.S(U07_uzkost!A2:A21)/ODMOCNINA(20)));19)', 2 * t_lower(-abs((m7 - 20) / (s7 / math.sqrt(20))), 19))
# Counts of intervals that captured mu on the stored simulated sheet.
F('=SUMA(Sim_intervaly!E2:E101)', 94, 0); F('=SUMA(Sim_intervaly!H2:H101)', 96, 0)
F('=COUNTIFS(Sim_intervaly!C2:C101;"<=47";Sim_intervaly!D2:D101;">=47")', 94, 0)
F('=COUNTIFS(Sim_intervaly!F2:F101;"<=47";Sim_intervaly!G2:G101;">=47")', 96, 0)
F('=POČET(Sim_intervaly!A2:H101)', 800, 0)

changes = [
    {'sheet': 'Interval_z', 'set': {'B4': 100}, 'expect': {'B7': 1, 'B10': 46 - z975, 'B11': 46 + z975}, 'tolerance': QT},
    {'sheet': 'Interval_z', 'set': {'B2': 104.5, 'B3': 15, 'B4': 36, 'B5': 0.99}, 'expect': {'B7': 2.5, 'B10': 104.5 - 2.5 * z_quant(0.995), 'B11': 104.5 + 2.5 * z_quant(0.995)}, 'tolerance': QT},
    {'sheet': 'Interval_t', 'set': {'B5': 0.9}, 'expect': {'B11': 46 - 2 * t_quant(0.95, 24), 'B12': 46 + 2 * t_quant(0.95, 24)}, 'tolerance': QT},
    {'sheet': 'Interval_t', 'set': {'B2': 104.125, 'B3': 12.584, 'B4': 56}, 'expect': {'B8': 55, 'B11': 104.125 - t_quant(0.975, 55) * 12.584 / math.sqrt(56), 'B12': 104.125 + t_quant(0.975, 55) * 12.584 / math.sqrt(56)}, 'tolerance': QT},
    {'sheet': 'T_test', 'set': {'B2': 100, 'B3': 104.125, 'B4': 12.584, 'B5': 56}, 'expect': {'B9': 55, 'B10': 4.125 / (12.584 / math.sqrt(56)), 'B13': 2 * t_lower(-4.125 / (12.584 / math.sqrt(56)), 55)}, 'tolerance': QT},
    {'sheet': 'T_test', 'set': {'B2': 30, 'B3': 32.4, 'B4': 4.8, 'B5': 16}, 'expect': {'B8': 1.2, 'B10': 2, 'B13': 2 * t_lower(-2, 15), 'B14': t_quant(0.975, 15)}, 'tolerance': QT},
]
labels = {'A': ('nulovou hypotézu nezamítáme', 'ekvivalence nedoložena'), 'C': ('nulovou hypotézu nezamítáme', 'ekvivalence doložena'),
          'D': ('zamítáme nulovou hypotézu', 'ekvivalence nedoložena'), 'E': ('zamítáme nulovou hypotézu', 'ekvivalence nedoložena')}
for name, (m, n) in {'A': (46, 25), 'C': (50.4, 400), 'D': (44, 100), 'E': (47, 100)}.items():
    e = eq_expect(m, 10, n)
    changes.append({'sheet': 'Ekvivalence', 'set': {'B4': m, 'B6': n}, 'expect': {k: e[k] for k in ('B14', 'B15', 'B16', 'B18', 'B19', 'B26')},
                    'tolerance': QT, 'labels': {'B17': labels[name][0], 'B20': labels[name][1]}})
for n in (150, 30):
    e = eq_expect(25.6, 6, n, 25, 2)
    changes.append({'sheet': 'Ekvivalence', 'set': {'B2': 25, 'B3': 2, 'B4': 25.6, 'B5': 6, 'B6': n}, 'expect': {k: e[k] for k in ('B14', 'B15', 'B16', 'B18', 'B19', 'B23', 'B25', 'B26')},
                    'tolerance': QT, 'labels': {'B17': 'nulovou hypotézu nezamítáme', 'B20': 'ekvivalence doložena' if n == 150 else 'ekvivalence nedoložena'}})

out = {
    'note': 'Expected values: regularized incomplete beta (continued fraction) for the t distribution, erfc for the normal distribution and bisection quantiles in Python (check-chapter-07-excel-expected.py); counts on Sim_intervaly are properties of the stored data. Not produced by Excel.',
    'cells': cells,
    'formulas': f,
    'errors': ['=T.INV(0;24)', '=T.INV(0,975;0)', '=T.DIST.2T(-2;24)'],
    'texts': [{'sheet': 'Ekvivalence', 'cell': 'B17', 'expected': 'zamítáme nulovou hypotézu'}, {'sheet': 'Ekvivalence', 'cell': 'B20', 'expected': 'ekvivalence doložena'}],
    'locals': [{'sheet': 'Interval_z', 'cell': 'B8', 'formula': '=NORM.S.INV(1-(1-B5)/2)'},
               {'sheet': 'Interval_t', 'cell': 'B7', 'formula': '=B3/ODMOCNINA(B4)'}, {'sheet': 'Interval_t', 'cell': 'B9', 'formula': '=T.INV(1-(1-B5)/2;B8)'},
               {'sheet': 'T_test', 'cell': 'B11', 'formula': '=T.DIST(B10;B9;PRAVDA)'}, {'sheet': 'T_test', 'cell': 'B13', 'formula': '=T.DIST.2T(ABS(B10);B9)'},
               {'sheet': 'T_test', 'cell': 'B14', 'formula': '=T.INV.2T(B6;B9)'},
               {'sheet': 'Ekvivalence', 'cell': 'B18', 'formula': '=B4-T.INV(1-B7;B10)*B9'},
               {'sheet': 'Ekvivalence', 'cell': 'B20', 'formula': '=KDYŽ(A(B18>B11;B19<B12);"ekvivalence doložena";"ekvivalence nedoložena")'},
               {'sheet': 'Ekvivalence', 'cell': 'B26', 'formula': '=MAX(B23;B25)'}],
    'changes': changes,
}
open(sys.argv[1], 'w', encoding='utf-8', newline='\n').write(json.dumps(out, ensure_ascii=False, indent=1) + '\n')
print(len(cells), 'cells,', len(f), 'formulas,', len(changes), 'changes')
