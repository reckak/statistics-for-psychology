// Calculations for the app page quarto/app_dva_podily.qmd: comparison of two independent proportions.
// A dependency-free ES module shared by the page (dynamic import in its OJS cell) and by the check
// scripts/check-stat-lib.mjs, which compares it with R (scripts/app-dva-podily.R).
// Data: a 2 × 2 table, rows = groups (group 2 is the reference group of the ratios), columns = outcome,
// x₁ and x₂ = counts of the chosen outcome category ("success") in groups of sizes n₁ and n₂.
// Methods follow chapter 9 (Newcombe interval, test with the pooled proportion, Fisher's exact test,
// risk ratio and odds ratio with log intervals, φ). Beyond the chapter, agreed for the app on 2026-11-26:
// a tested difference δ₀ ≠ 0 in H₀ (score test of Farrington and Manning, which for δ₀ = 0 is exactly
// the test with the pooled proportion) and, for smaller samples, the exact unconditional score test and
// the interval from inverting it (Agresti & Min, 2001, Biometrics 57, 963–971, sections 5 and 7).

import { pnorm, qnorm, wilson, intervalFor, logFactorials, N_MAX } from "./podil.js";
export { intervalFor, N_MAX };

// The exact unconditional procedure enumerates all (n₁ + 1)(n₂ + 1) tables; it runs for groups up to this size.
export const EXACT_MAX = 200;

const pFromZ = (z, alt) => alt === "greater" ? pnorm(-z) : alt === "less" ? pnorm(z) : Math.min(1, 2 * pnorm(-Math.abs(z)));

// Maximum likelihood estimates of π₁ and π₂ under the restriction π₁ − π₂ = δ, as in the score statistic of
// Agresti & Min (2001, p. 967): the root of a cubic equation in closed form (Farrington & Manning, 1990,
// Statistics in Medicine 9, 1447–1454; checked against a numerical solution in scripts/app-dva-podily.R). For δ = 0 both equal the pooled
// proportion. If rounding ever puts the closed form outside the admissible range, the score equation
// (decreasing in π₂) is solved by bisection instead.
export function restricted(x1, n1, x2, n2, delta) {
  if (delta === 0) { const p = (x1 + x2) / (n1 + n2); return {p1: p, p2: p}; }
  const lo = Math.max(0, delta), hi = Math.min(1, 1 + delta);
  const p1 = x1 / n1, p2 = x2 / n2, th = n2 / n1, d = delta;
  const a = 1 + th, b = -(1 + th + p1 + th * p2 + d * (th + 2)), c = d * d + d * (2 * p1 + th + 1) + p1 + th * p2, e = -p1 * d * (1 + d);
  const v = b * b * b / (27 * a * a * a) - b * c / (6 * a * a) + e / (2 * a);
  const u = (v < 0 ? -1 : 1) * Math.sqrt(Math.max(0, b * b / (9 * a * a) - c / (3 * a)));
  let r1 = NaN;
  if (u !== 0) { const w = (Math.PI + Math.acos(Math.max(-1, Math.min(1, v / (u * u * u))))) / 3; r1 = 2 * u * Math.cos(w) - b / (3 * a); }
  else r1 = -b / (3 * a);
  if (!(r1 >= lo - 1e-9 && r1 <= hi + 1e-9)) r1 = restrictedBisect(x1, n1, x2, n2, delta);
  r1 = Math.min(hi, Math.max(lo, r1));
  return {p1: r1, p2: Math.min(1, Math.max(0, r1 - delta))};
}
function restrictedBisect(x1, n1, x2, n2, d) {
  // Derivative of the log-likelihood with respect to π₁ (π₂ = π₁ − d); terms with a zero count drop out.
  const g = t => (x1 ? x1 / t : 0) - (n1 - x1 ? (n1 - x1) / (1 - t) : 0) + (x2 ? x2 / (t - d) : 0) - (n2 - x2 ? (n2 - x2) / (1 - t + d) : 0);
  let lo = Math.max(0, d), hi = Math.min(1, 1 + d);
  const eps = 1e-15;
  if (g(lo + eps) <= 0) return lo;
  if (g(hi - eps) >= 0) return hi;
  for (let i = 0; i < 200 && hi - lo > 1e-16; i++) { const m = (lo + hi) / 2; if (g(m) > 0) lo = m; else hi = m; }
  return (lo + hi) / 2;
}

// Score test of H₀: π₁ − π₂ = δ₀. The standard error is computed from the restricted estimates; for δ₀ = 0
// it is √(p(1 − p)(1/n₁ + 1/n₂)) with the pooled proportion p and z² equals Pearson's chi-square.
// se0 = 0 (with δ₀ = 0: all cases in one outcome category) leaves the test undefined (z = NaN).
export function scoreDiffTest(x1, n1, x2, n2, delta, alt) {
  const r = restricted(x1, n1, x2, n2, delta);
  const se0 = Math.sqrt(r.p1 * (1 - r.p1) / n1 + r.p2 * (1 - r.p2) / n2);
  const diff = x1 / n1 - x2 / n2, z = se0 > 0 ? (diff - delta) / se0 : NaN;
  return {p1t: r.p1, p2t: r.p2, se0, diff, z, chi2: z * z, pValue: Number.isFinite(z) ? pFromZ(z, alt) : NaN};
}

// Fisher's exact test: hypergeometric distribution of x₁ given all margins. Two-sided p-value by the rule of
// R's fisher.test (tables at most as probable as the observed one, relative tolerance 1 + 1e-7); one-sided
// "greater" (π₁ > π₂) = P(X ≥ x₁), "less" = P(X ≤ x₁). Returns the support and probabilities for the chart.
export function fisherTest(x1, n1, x2, n2, alt) {
  const m = x1 + x2, N = n1 + n2, lo = Math.max(0, m - n2), hi = Math.min(n1, m);
  const lf = logFactorials(N), lch = (n, k) => lf[n] - lf[k] - lf[n - k], den = lch(N, m);
  const d = []; for (let i = lo; i <= hi; i++) d.push(Math.exp(lch(n1, i) + lch(n2, m - i) - den));
  const tot = d.reduce((s, v) => s + v, 0);
  for (let i = 0; i < d.length; i++) d[i] /= tot;
  const obs = d[x1 - lo], relErr = 1 + 1e-7;
  const inP = d.map((v, j) => alt === "greater" ? lo + j >= x1 : alt === "less" ? lo + j <= x1 : v <= obs * relErr);
  const p = Math.min(1, d.reduce((s, v, j) => s + (inP[j] ? v : 0), 0));
  return {p, lo, hi, d, inP, obs};
}

// Newcombe's hybrid score interval for π₁ − π₂ from the Wilson intervals of both groups (chapter 9):
// lower = (p₁ − p₂) − √((p₁ − l₁)² + (u₂ − p₂)²), upper = (p₁ − p₂) + √((u₁ − p₁)² + (p₂ − l₂)²).
// side "two": both limits at confidence conf; "lower"/"upper": one-sided interval at conf, i.e. Wilson limits
// with the quantile z_conf, the other limit −1 or 1 (as DescTools::BinomDiffCI with sides "left"/"right").
export function newcombe(x1, n1, x2, n2, conf, side = "two") {
  const c = side === "two" ? conf : 2 * conf - 1;
  const w1 = wilson(x1, n1, c), w2 = wilson(x2, n2, c);
  const p1 = x1 / n1, p2 = x2 / n2, d = p1 - p2;
  const down = Math.sqrt((p1 - w1.lo) ** 2 + (w2.hi - p2) ** 2), up = Math.sqrt((w1.hi - p1) ** 2 + (p2 - w2.lo) ** 2);
  return {conf, side, z: w1.z, w1, w2, d, down, up, lo: side === "upper" ? -1 : d - down, hi: side === "lower" ? 1 : d + up};
}

// Risk ratio p₁/p₂ and odds ratio with intervals on the log scale (chapter 9, optional extension):
// SE(ln RR) = √(1/a − 1/n₁ + 1/c − 1/n₂), SE(ln OR) = √(1/a + 1/b + 1/c + 1/d). A ratio or its interval is
// null where a zero count makes it undefined. One-sided intervals have the other limit 0 or ∞.
export function ratios(a, b, c, d, conf, side = "two") {
  const n1 = a + b, n2 = c + d, z = side === "two" ? qnorm(1 - (1 - conf) / 2) : qnorm(conf);
  const iv = (est, se) => {
    if (!(est > 0) || !Number.isFinite(se)) return null;
    const lo = Math.exp(Math.log(est) - z * se), hi = Math.exp(Math.log(est) + z * se);
    return {lo: side === "upper" ? 0 : lo, hi: side === "lower" ? Infinity : hi};
  };
  const rr = c > 0 ? (a / n1) / (c / n2) : null, seRR = a > 0 && c > 0 ? Math.sqrt(1 / a - 1 / n1 + 1 / c - 1 / n2) : null;
  const or = b > 0 && c > 0 ? (a * d) / (b * c) : null, seOR = a > 0 && b > 0 && c > 0 && d > 0 ? Math.sqrt(1 / a + 1 / b + 1 / c + 1 / d) : null;
  return {z, rr, seRR, rrCi: rr !== null && seRR !== null ? iv(rr, seRR) : null, or, seOR, orCi: or !== null && seOR !== null ? iv(or, seOR) : null};
}

// Signed φ from the cell counts (chapter 9); null when a margin is zero.
export function phi(a, b, c, d) {
  const den = Math.sqrt((a + b) * (c + d) * (a + c) * (b + d));
  return den > 0 ? (a * d - b * c) / den : null;
}

// ---- Exact unconditional score test and interval (Agresti & Min, 2001) ----

// Binomial probabilities P(X = k), k = 0, …, n, including π = 0 and π = 1.
function binomPmf(n, pi, lf) {
  const out = new Float64Array(n + 1);
  if (pi <= 0) { out[0] = 1; return out; }
  if (pi >= 1) { out[n] = 1; return out; }
  const lp = Math.log(pi), lq = Math.log1p(-pi);
  for (let k = 0; k <= n; k++) out[k] = Math.exp(lf[n] - lf[k] - lf[n - k] + k * lp + (n - k) * lq);
  return out;
}

// Score statistic T for every table (i, j), i = 0…n₁, j = 0…n₂, at the tested difference δ. A table whose
// standard error is zero (only possible with δ = 0: all cases in one category) gets T = 0.
function statMatrix(n1, n2, delta) {
  const T = new Float64Array((n1 + 1) * (n2 + 1));
  for (let i = 0; i <= n1; i++) for (let j = 0; j <= n2; j++) {
    const r = restricted(i, n1, j, n2, delta);
    const se = Math.sqrt(r.p1 * (1 - r.p1) / n1 + r.p2 * (1 - r.p2) / n2), num = i / n1 - j / n2 - delta;
    T[i * (n2 + 1) + j] = se > 0 ? num / se : 0;
  }
  return T;
}

// The tables at least as extreme as the observed one, stored for each i as runs [from, to] of j.
// alt "two": |T| ≥ |t₀|; "greater": T ≥ t₀; "less": T ≤ t₀ (a relative tolerance of 1e-9 keeps ties in).
function rejectionRuns(T, n1, n2, t0, alt) {
  const tol = 1e-9 * Math.max(1, Math.abs(t0));
  const inR = alt === "greater" ? t => t >= t0 - tol : alt === "less" ? t => t <= t0 + tol : t => Math.abs(t) >= Math.abs(t0) - tol;
  const runs = [];
  for (let i = 0; i <= n1; i++) {
    const r = [];
    let start = -1;
    for (let j = 0; j <= n2 + 1; j++) {
      const hit = j <= n2 && inR(T[i * (n2 + 1) + j]);
      if (hit && start < 0) start = j;
      if (!hit && start >= 0) { r.push(start, j - 1); start = -1; }
    }
    runs.push(r);
  }
  return runs;
}

// Probability of the rejection region when π₂ = q and π₁ = q + δ.
function regionProb(runs, n1, n2, delta, q, lf) {
  const f1 = binomPmf(n1, Math.min(1, Math.max(0, q + delta)), lf), f2 = binomPmf(n2, q, lf);
  const C = new Float64Array(n2 + 2);
  for (let j = 0; j <= n2; j++) C[j + 1] = C[j] + f2[j];
  let s = 0;
  for (let i = 0; i <= n1; i++) {
    if (f1[i] === 0) continue;
    const r = runs[i];
    let t = 0;
    for (let k = 0; k < r.length; k += 2) t += C[r[k + 1] + 1] - C[r[k]];
    s += f1[i] * t;
  }
  return Math.min(1, Math.max(0, s));
}

// p-value of the exact unconditional score test of H₀: π₁ − π₂ = δ: the largest probability of the rejection
// region over the nuisance parameter π₂ ∈ [max(0, −δ), min(1, 1 − δ)]: a grid of GRID values, then golden-section
// refinement around the best grid point.
const GRID = 200;
export function exactUncondP(x1, n1, x2, n2, delta, alt, cache = new Map()) {
  const lf = logFactorials(Math.max(n1, n2));
  let T = cache.get(delta);
  if (!T) { T = statMatrix(n1, n2, delta); cache.set(delta, T); }
  const t0 = T[x1 * (n2 + 1) + x2], runs = rejectionRuns(T, n1, n2, t0, alt);
  const lo = Math.max(0, -delta), hi = Math.min(1, 1 - delta);
  const f = q => regionProb(runs, n1, n2, delta, q, lf);
  let best = -1, bestK = 0;
  const step = (hi - lo) / (GRID - 1);
  for (let k = 0; k < GRID; k++) { const v = f(lo + k * step); if (v > best) { best = v; bestK = k; } }
  // Golden-section search for the maximum between the neighbours of the best grid point.
  let a = lo + Math.max(0, bestK - 1) * step, b = lo + Math.min(GRID - 1, bestK + 1) * step;
  const g = (Math.sqrt(5) - 1) / 2;
  let c = b - g * (b - a), d = a + g * (b - a), fc = f(c), fd = f(d);
  for (let it = 0; it < 60 && b - a > 1e-12; it++) {
    if (fc > fd) { b = d; d = c; fd = fc; c = b - g * (b - a); fc = f(c); }
    else { a = c; c = d; fc = fd; d = a + g * (b - a); fd = f(d); }
  }
  return {p: Math.min(1, Math.max(best, fc, fd)), t0, nuisance: fc > fd ? c : d};
}

// Confidence interval for π₁ − π₂ from inverting the exact test: all δ whose p-value exceeds a.
// side "two": two-sided test at level a (interval at 1 − a); "lower": test with H₁ π₁ − π₂ > δ, lower limit,
// upper limit 1; "upper": test with H₁ π₁ − π₂ < δ, upper limit, lower limit −1 (tail method, section 7).
// Each limit is found by bisection from the estimate outwards; a scan beyond it looks for further accepted
// values, and the interval runs from the lowest to the highest accepted value, as in Agresti & Min.
export function exactInterval(x1, n1, x2, n2, a, side = "two") {
  const cache = new Map(), alt = side === "two" ? "two" : side === "lower" ? "greater" : "less";
  const accept = dl => exactUncondP(x1, n1, x2, n2, dl, alt, cache).p > a;
  const dhat = x1 / n1 - x2 / n2, EPS = 1e-9, TOL = 1e-7, SCAN = 12;
  const limit = dir => {               // dir −1: lower limit, +1: upper limit
    const edge = dir < 0 ? -1 + EPS : 1 - EPS;
    if (Math.abs(dhat - (dir < 0 ? -1 : 1)) < 1e-12) return dir < 0 ? -1 : 1;
    if (accept(edge)) return dir < 0 ? -1 : 1;
    // Bisection between the accepted estimate (T = 0) and the rejected edge.
    let inn = dhat, out = edge;
    if (!accept(inn)) {                // possible for one-sided tests only: move inwards until accepted
      const other = dir < 0 ? 1 - EPS : -1 + EPS;
      for (let k = 1; k <= 40 && !accept(inn); k++) inn = dhat + (other - dhat) * k / 40;
    }
    while (Math.abs(inn - out) > TOL) { const m = (inn + out) / 2; if (accept(m)) inn = m; else out = m; }
    // Scan the rest of the range (the edge itself is rejected) for accepted values further out,
    // outermost first; the limit is then the outer end of the outermost accepted piece.
    const at = k => out + (edge - out) * k / SCAN;
    for (let k = SCAN - 1; k >= 1; k--) {
      if (!accept(at(k))) continue;
      let i2 = at(k), o2 = at(k + 1);
      while (Math.abs(i2 - o2) > TOL) { const m = (i2 + o2) / 2; if (accept(m)) i2 = m; else o2 = m; }
      return i2;
    }
    return inn;
  };
  return {conf: 1 - a, side, lo: side === "upper" ? -1 : limit(-1), hi: side === "lower" ? 1 : limit(1)};
}

// Exact unconditional procedure for the page: p-value of the chosen test at δ₀ and the interval that belongs to it.
// Two-sided H₁: two-sided interval at 1 − α. One-sided H₁: always the one-sided interval at 1 − α from inverting
// the one-sided test (Agresti & Min, section 7), so that the interval decides exactly as the exact test. Unlike the
// Newcombe interval, the two-sided exact interval at 1 − 2α need not share this limit (the choice intervalKind
// therefore does not apply here).
export function exactProcedure({x1, n1, x2, n2, delta0, alt, alpha}) {
  if (n1 > EXACT_MAX || n2 > EXACT_MAX) return null;
  const test = exactUncondP(x1, n1, x2, n2, delta0, alt);
  const iv = intervalFor(alt, alpha, "one");
  const ci = exactInterval(x1, n1, x2, n2, 1 - iv.conf, iv.side);
  const ciRejects = alt === "greater" ? delta0 < ci.lo : alt === "less" ? delta0 > ci.hi : !(ci.lo <= delta0 && delta0 <= ci.hi);
  return {p: test.p, t0: test.t0, reject: test.p <= alpha, ci, ciRejects};
}

// Everything the page shows except the exact unconditional procedure (computed separately, it takes longer).
// cells: [[a, b], [c, d]] with rows = groups and column 0 = the chosen outcome category.
export function twoProportions({cells, delta0 = 0, alt = "two", alpha = 0.05, intervalKind = "two"}) {
  const [[a, b], [c, d]] = cells, n1 = a + b, n2 = c + d, N = n1 + n2;
  const p1 = a / n1, p2 = c / n2, diff = p1 - p2;
  const score = scoreDiffTest(a, n1, c, n2, delta0, alt);
  const fisher = delta0 === 0 ? fisherTest(a, n1, c, n2, alt) : null;
  const iv = intervalFor(alt, alpha, intervalKind);
  const ci = newcombe(a, n1, c, n2, iv.conf, iv.side);
  const colSums = [a + c, b + d];
  // Expected counts under H₀ from the restricted estimates; for δ₀ = 0 these are f_j+ · f_+l / n of chapter 9.
  const expected = [[n1 * score.p1t, n1 * (1 - score.p1t)], [n2 * score.p2t, n2 * (1 - score.p2t)]];
  return {
    cells, n1, n2, N, colSums, p1, p2, diff, delta0, alt, alpha, intervalKind,
    score: {...score, reject: Number.isFinite(score.pValue) && score.pValue <= alpha},
    fisher: fisher && {...fisher, reject: fisher.p <= alpha},
    ci, ciRejects: alt === "greater" ? delta0 < ci.lo : alt === "less" ? delta0 > ci.hi : !(ci.lo <= delta0 && delta0 <= ci.hi),
    ratios: ratios(a, b, c, d, iv.conf, iv.side), phi: phi(a, b, c, d),
    expected, expectedOk: expected.flat().every(e => e >= 5),
    exactAvailable: n1 <= EXACT_MAX && n2 <= EXACT_MAX
  };
}
