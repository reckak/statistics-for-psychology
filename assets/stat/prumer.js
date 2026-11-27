// Calculations for the app page quarto/app_jeden_prumer.qmd: test of one mean (z-test, one-sample and paired
// t-test), confidence interval for the mean, equivalence test (TOST) and Cohen's d with its interval.
// A dependency-free ES module shared by the page (dynamic import in its OJS cell) and by the check
// scripts/check-stat-lib.mjs, which compares it with R (scripts/app-jeden-prumer.R).
// Methods follow chapters 6–8; beyond them (explained on the page): the exact interval for d from the noncentral
// t distribution and, for paired data, Bonett's (2015) intervals for d standardized by the SD of the reference
// measurement (eq. 15) or by √((s₁² + s₂²)/2) (eq. 13) with his bias adjustments.
import { pnorm, qnorm, intervalFor } from "./podil.js";
export { pnorm, qnorm, intervalFor };

export const N_MAX = 10000;        // individual values (pairs) the page accepts
export const N_SUMMARY_MAX = 1e7;  // n entered as a summary

// log Γ(x): Lanczos approximation (g = 7, 9 terms), reflection for x < 0,5.
const LANCZOS = [0.99999999999980993, 676.5203681218851, -1259.1392167224028, 771.32342877765313, -176.61502916214059,
  12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7];
export function lgamma(x) {
  if (x < 0.5) return Math.log(Math.PI / Math.abs(Math.sin(Math.PI * x))) - lgamma(1 - x);
  x -= 1;
  let a = LANCZOS[0];
  const t = x + 7.5;
  for (let i = 1; i < 9; i++) a += LANCZOS[i] / (x + i);
  return 0.5 * Math.log(2 * Math.PI) + (x + 0.5) * Math.log(t) - t + Math.log(a);
}
const lbeta = (a, b) => lgamma(a) + lgamma(b) - lgamma(a + b);

// Continued fraction of the incomplete beta function (modified Lentz).
function betacf(a, b, x) {
  const TINY = 1e-300, EPS = 1e-16, qab = a + b, qap = a + 1, qam = a - 1;
  let c = 1, d = 1 - qab * x / qap;
  if (Math.abs(d) < TINY) d = TINY;
  d = 1 / d;
  let h = d;
  for (let m = 1; m <= 100000; m++) {
    const m2 = 2 * m;
    let aa = m * (b - m) * x / ((qam + m2) * (a + m2));
    d = 1 + aa * d; if (Math.abs(d) < TINY) d = TINY;
    c = 1 + aa / c; if (Math.abs(c) < TINY) c = TINY;
    d = 1 / d; h *= d * c;
    aa = -(a + m) * (qab + m) * x / ((a + m2) * (qap + m2));
    d = 1 + aa * d; if (Math.abs(d) < TINY) d = TINY;
    c = 1 + aa / c; if (Math.abs(c) < TINY) c = TINY;
    d = 1 / d;
    const del = d * c;
    h *= del;
    if (Math.abs(del - 1) < EPS) break;
  }
  return h;
}
// Regularized incomplete beta function I_x(a, b); lower = false gives 1 − I_x(a, b) without cancellation.
export function pbeta(x, a, b, lower = true) {
  if (x <= 0) return lower ? 0 : 1;
  if (x >= 1) return lower ? 1 : 0;
  const front = Math.exp(a * Math.log(x) + b * Math.log1p(-x) - lbeta(a, b));
  if (x < (a + 1) / (a + b + 2)) { const v = front * betacf(a, b, x) / a; return lower ? v : 1 - v; }
  const v = front * betacf(b, a, 1 - x) / b;
  return lower ? 1 - v : v;
}
export function dbeta(x, a, b) {
  if (x <= 0 || x >= 1) return 0;
  return Math.exp((a - 1) * Math.log(x) + (b - 1) * Math.log1p(-x) - lbeta(a, b));
}

// Monotone root finding: Newton steps kept inside a shrinking bracket, bisection otherwise.
// f increasing on [lo, hi] with f(lo) ≤ 0 ≤ f(hi); df its derivative (may be omitted).
function solveIncreasing(f, lo, hi, x0, df, relTol = 1e-14) {
  let x = Math.min(hi, Math.max(lo, x0));
  for (let i = 0; i < 400; i++) {
    const v = f(x);
    if (v === 0) return x;
    if (v < 0) lo = x; else hi = x;
    let next = df ? x - v / df(x) : NaN;
    if (!(next > lo && next < hi)) next = (lo + hi) / 2;
    if (Math.abs(next - x) <= relTol * Math.max(Math.abs(x), 1e-300) || hi - lo <= relTol * Math.max(Math.abs(lo), Math.abs(hi), 1e-300)) return next;
    x = next;
  }
  return x;
}

// Quantile of the beta distribution; for p > 0,5 through the mirrored distribution, which keeps precision near 1.
export function qbeta(p, a, b) {
  if (p <= 0) return 0;
  if (p >= 1) return 1;
  if (p > 0.5) return 1 - qbeta(1 - p, b, a);
  const mean = a / (a + b);
  return solveIncreasing(x => pbeta(x, a, b) - p, 0, 1, Math.min(mean, 0.5), x => dbeta(x, a, b));
}

// Student t distribution. lower = false gives the upper tail P(T > t) directly.
export function dt(t, df) {
  return Math.exp(lgamma((df + 1) / 2) - lgamma(df / 2) - 0.5 * Math.log(df * Math.PI) - (df + 1) / 2 * Math.log1p(t * t / df));
}
export function pt(t, df, lower = true) {
  if (t === Infinity) return lower ? 1 : 0;
  if (t === -Infinity) return lower ? 0 : 1;
  const tail = 0.5 * pbeta(df / (df + t * t), df / 2, 0.5);   // P(T > |t|)
  if (t === 0) return 0.5;
  return (t > 0) === lower ? 1 - tail : tail;
}
export function qt(p, df) {
  if (p === 0.5) return 0;
  if (p < 0.5) return -qt(1 - p, df);
  const q = 1 - p;
  let hi = Math.max(1, 2 * qnorm(p));
  while (pt(hi, df, false) > q) hi *= 2;
  // The upper tail decreases in t: solve −(upper tail − q) = 0 as an increasing function.
  return solveIncreasing(t => q - pt(t, df, false), 0, hi, qnorm(p), t => dt(t, df));
}

// Noncentral t distribution P(T ≤ t) with df degrees of freedom and noncentrality parameter ncp:
// T = (Z + ncp)/√(X/df), so P(T ≤ t) = ∫ Φ(t·x/√df − ncp) f(x) dx over the chi distribution of √X.
// Composite 20-point Gauss–Legendre quadrature over the bulk of the chi density; the number of panels grows
// with the steepness of Φ(t·x/√df − ncp) in x.
const GL_X = [0.0765265211334973, 0.2277858511416451, 0.3737060887154195, 0.5108670019508271, 0.6360536807265150,
  0.7463319064601508, 0.8391169718222188, 0.9122344282513259, 0.9639719272779138, 0.9931285991850949];
const GL_W = [0.1527533871307258, 0.1491729864726037, 0.1420961093183820, 0.1316886384491766, 0.1181945319615184,
  0.1019301198172404, 0.0832767415767048, 0.0626720483341091, 0.0406014298003869, 0.0176140071391521];
export function pnct(t, df, ncp) {
  if (ncp === 0) return pt(t, df);
  if (t === Infinity) return 1;
  if (t === -Infinity) return 0;
  const mode = Math.sqrt(Math.max(df - 1, 0)), lo = Math.max(0, mode - 10), hi = mode + 10;
  const k = t / Math.sqrt(df), lnorm = (df / 2 - 1) * Math.LN2 + lgamma(df / 2);
  const panels = Math.min(4000, 40 + Math.ceil(30 * Math.abs(k)));
  const h = (hi - lo) / panels;
  let sum = 0;
  for (let j = 0; j < panels; j++) {
    const mid = lo + (j + 0.5) * h, half = h / 2;
    for (let i = 0; i < 10; i++) for (const sgn of [-1, 1]) {
      const x = mid + sgn * half * GL_X[i];
      if (x <= 0) continue;
      sum += GL_W[i] * half * pnorm(k * x - ncp) * Math.exp((df - 1) * Math.log(x) - x * x / 2 - lnorm);
    }
  }
  return Math.min(1, Math.max(0, sum));
}

// Interval for the noncentrality parameter: the values δ for which the observed t would not be unusual,
// i.e. P(T ≤ t | δ) = 1 − a at the lower and = a at the upper limit (P(T ≤ t | δ) decreases in δ).
function ncpForTarget(t, df, target) {
  if (!Number.isFinite(t) || !(df > 0)) return NaN;
  const g = d => target - pnct(t, df, d);    // increasing in δ
  let step = 2 + Math.abs(t) * 0.5;
  let lo = t - step, hi = t + step;
  for (let k = 0; g(lo) > 0; k++) { if (k > 60) return NaN; lo -= step; step *= 2; }
  step = 2 + Math.abs(t) * 0.5;
  for (let k = 0; g(hi) < 0; k++) { if (k > 60) return NaN; hi += step; step *= 2; }
  return solveIncreasing(g, lo, hi, (lo + hi) / 2, null, 1e-12);
}
export function ncpInterval(t, df, conf, side = "two") {
  const a = side === "two" ? (1 - conf) / 2 : 1 - conf;
  return {
    lo: side === "upper" ? -Infinity : ncpForTarget(t, df, 1 - a),
    hi: side === "lower" ? Infinity : ncpForTarget(t, df, a)
  };
}

// Hedges' correction as in chapter 8: J = 1 − 3/(4v − 1), v = degrees of freedom of the standardizer (v ≥ 2).
export const hedgesJ = v => v >= 2 ? 1 - 3 / (4 * v - 1) : null;

// Sample mean, SD (n − 1) and n of an array of numbers.
export function describe(x) {
  const n = x.length;
  let m = 0;
  for (const v of x) m += v;
  m /= n;
  let ss = 0;
  for (const v of x) ss += (v - m) * (v - m);
  return {n, m, s: n > 1 ? Math.sqrt(ss / (n - 1)) : NaN, ss};
}

const pFromStat = (stat, alt, dist) => alt === "greater" ? dist(stat, false) : alt === "less" ? dist(stat, true) : Math.min(1, 2 * dist(-Math.abs(stat), true));
const ivRejects = (ci, v, alt) => alt === "greater" ? v < ci.lo : alt === "less" ? v > ci.hi : !(ci.lo <= v && v <= ci.hi);

// One mean from summaries. test: "t" (s estimated) or "z" (σ known). Returns the test, the interval for μ,
// the difference from μ₀ in original units and Cohen's d = (m − μ₀)/s (or /σ) with its interval.
export function meanTest({test = "t", m, s, sigma, n, mu0, alt = "two", alpha = 0.05, intervalKind = "two"}) {
  const z = test === "z", sd = z ? sigma : s, df = z ? null : n - 1;
  const se = sd / Math.sqrt(n), stat = (m - mu0) / se;
  const dist = z ? (x, lower) => (lower ? pnorm(x) : pnorm(-x)) : (x, lower) => pt(x, df, lower);
  const pValue = pFromStat(stat, alt, dist);
  const iv = intervalFor(alt, alpha, intervalKind);
  const prob = iv.side === "two" ? 1 - (1 - iv.conf) / 2 : iv.conf;
  const q = z ? qnorm(prob) : qt(prob, df), margin = q * se;
  const ci = {conf: iv.conf, side: iv.side, prob, q, margin,
    lo: iv.side === "upper" ? -Infinity : m - margin, hi: iv.side === "lower" ? Infinity : m + margin};
  const dVal = (m - mu0) / sd;
  let d;
  if (z) d = {value: dVal, lo: (ci.lo - mu0) / sd, hi: (ci.hi - mu0) / sd, method: "z", J: null};
  else {
    const nc = ncpInterval(stat, df, iv.conf, iv.side), J = hedgesJ(df);
    d = {value: dVal, lo: nc.lo / Math.sqrt(n), hi: nc.hi / Math.sqrt(n), ncpLo: nc.lo, ncpHi: nc.hi, method: "nct", J,
      g: J === null ? null : J * dVal, gLo: J === null ? null : J * nc.lo / Math.sqrt(n), gHi: J === null ? null : J * nc.hi / Math.sqrt(n)};
  }
  return {test, m, sd, s: z ? null : s, sigma: z ? sigma : null, n, mu0, alt, alpha, intervalKind, df, se, stat, pValue,
    reject: pValue <= alpha, ci, diff: m - mu0, diffLo: ci.lo - mu0, diffHi: ci.hi - mu0,
    ciRejects: ivRejects(ci, mu0, alt), d};
}

// Equivalence test (TOST, chapter 7): two one-sided tests against the bounds at level α and the interval 1 − 2α.
export function equivalence({test = "t", m, se, df, lower, upper, alpha = 0.05}) {
  const dist = test === "z" ? (x, lo) => (lo ? pnorm(x) : pnorm(-x)) : (x, lo) => pt(x, df, lo);
  const tL = (m - lower) / se, tU = (m - upper) / se;
  const pL = dist(tL, false), pU = dist(tU, true);
  const q = test === "z" ? qnorm(1 - alpha) : qt(1 - alpha, df);
  const ci = {conf: 1 - 2 * alpha, lo: m - q * se, hi: m + q * se, q};
  return {lower, upper, tL, tU, pL, pU, rejectL: pL <= alpha, rejectU: pU <= alpha, p: Math.max(pL, pU),
    equivalent: pL <= alpha && pU <= alpha, ci};
}

// Paired data: complete pairs of two measurements (x1[i], x2[i]); the difference is x1 − x2.
export function pairedDescribe(x1, x2) {
  const n = x1.length, a = describe(x1), b = describe(x2), diffs = x1.map((v, i) => v - x2[i]), dd = describe(diffs);
  let sxy = 0;
  for (let i = 0; i < n; i++) sxy += (x1[i] - a.m) * (x2[i] - b.m);
  const r = a.ss > 0 && b.ss > 0 ? sxy / Math.sqrt(a.ss * b.ss) : null;
  return {n, m1: a.m, m2: b.m, s1: a.s, s2: b.s, r, mD: dd.m, sD: dd.s, diffs};
}

// Standardized mean differences for paired data (Bonett, 2015), d = (m_D − μ₀)/standardizer:
// ref: SD of the reference measurement (eq. 7, 11, 15; bias adjustment 1 − 3/(4df − 1)),
// avg: √((s₁² + s₂²)/2) (eq. 6, 9, 13; bias adjustment √((n − 2)/df)),
// dz: SD of the differences, exact interval from the noncentral t distribution, Hedges' J.
// sRef is the SD of the reference measurement, sOther that of the other one; r their correlation.
export function pairedEffects({n, mD, sD, mu0 = 0, sRef = null, sOther = null, r = null, conf = 0.95, side = "two"}) {
  const df = n - 1, num = mD - mu0, zq = side === "two" ? qnorm(1 - (1 - conf) / 2) : qnorm(conf);
  const lim = (v, se) => ({lo: side === "upper" ? -Infinity : v - zq * se, hi: side === "lower" ? Infinity : v + zq * se});
  const t = num / (sD / Math.sqrt(n)), nc = ncpInterval(t, df, conf, side), J = hedgesJ(df);
  const dzVal = num / sD;
  const out = {zq, dz: {value: dzVal, lo: nc.lo / Math.sqrt(n), hi: nc.hi / Math.sqrt(n), J, adj: J === null ? null : J * dzVal}};
  if (sRef !== null && sRef > 0) {
    const d = num / sRef, se = Math.sqrt(d * d / (2 * df) + sD * sD / (sRef * sRef * df)), adjF = hedgesJ(df);
    out.ref = {value: d, se, ...lim(d, se), adjFactor: adjF, adj: adjF === null ? null : adjF * d};
  }
  if (sRef !== null && sOther !== null && r !== null && sRef > 0 && sOther > 0) {
    const s2 = (sRef * sRef + sOther * sOther) / 2, d = num / Math.sqrt(s2);
    const v = d * d * (sRef ** 4 + sOther ** 4 + 2 * r * r * sRef * sRef * sOther * sOther) / (8 * df * s2 * s2) + sD * sD / (s2 * df);
    const se = Math.sqrt(v), adjF = n > 2 ? Math.sqrt((n - 2) / df) : null;
    out.avg = {value: d, se, ...lim(d, se), standardizer: Math.sqrt(s2), adjFactor: adjF, adj: adjF === null ? null : adjF * d};
  }
  return out;
}
