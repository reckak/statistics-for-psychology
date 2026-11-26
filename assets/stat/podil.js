// Calculations for the app page quarto/app_jeden_podil.qmd: test of one proportion.
// A dependency-free ES module shared by the page (dynamic import in its OJS cell) and by the check
// scripts/check-stat-lib.mjs, which compares it with R (scripts/app-jeden-podil.R).
// Methods follow chapters 6 and 9: score test with the standard error from π₀, exact binomial test
// (two-sided p-value by the rule of R's binom.test), Wilson interval (two-sided or one-sided as R's
// prop.test(correct = FALSE)), expected counts n·π₀ and n·(1 − π₀).

export const N_MAX = 100000;

// Standard normal distribution function: Hart's algorithm 5666 as given by West (2005), double precision.
export function pnorm(x) {
  const a = Math.abs(x);
  let c;
  if (a > 37) c = 0;
  else {
    const e = Math.exp(-a * a / 2);
    if (a < 7.07106781186547) {
      let n = 3.52624965998911e-02 * a + 0.700383064443688;
      n = n * a + 6.37396220353165; n = n * a + 33.912866078383; n = n * a + 112.079291497871;
      n = n * a + 221.213596169931; n = n * a + 220.206867912376;
      let d = 8.83883476483184e-02 * a + 1.75566716318264;
      d = d * a + 16.064177579207; d = d * a + 86.7807322029461; d = d * a + 296.564248779674;
      d = d * a + 637.333633378831; d = d * a + 793.826512519948; d = d * a + 440.413735824752;
      c = e * n / d;
    } else {
      let b = a + 0.65;
      b = a + 4 / b; b = a + 3 / b; b = a + 2 / b; b = a + 1 / b;
      c = e / b / 2.506628274631;
    }
  }
  return x > 0 ? 1 - c : c;
}

// Standard normal quantile: Acklam's approximation refined by one Halley step; the upper half by symmetry.
const SQRT2PI = Math.sqrt(2 * Math.PI);
export function qnorm(p) {
  if (p > 0.5) return -qnorm(1 - p);
  const a = [-39.69683028665376, 220.9460984245205, -275.9285104469687, 138.3577518672690, -30.66479806614716, 2.506628277459239];
  const b = [-54.47609879822406, 161.5858368580409, -155.6989798598866, 66.80131188771972, -13.28068155288572];
  const c = [-0.007784894002430293, -0.3223964580411365, -2.400758277161838, -2.549732539343734, 4.374664141464968, 2.938163982698783];
  const d = [0.007784695709041462, 0.3224671290700398, 2.445134137142996, 3.754408661907416];
  const lim = 0.02425;
  let x;
  if (p < lim) { const q = Math.sqrt(-2 * Math.log(p)); x = (((((c[0]*q+c[1])*q+c[2])*q+c[3])*q+c[4])*q+c[5]) / ((((d[0]*q+d[1])*q+d[2])*q+d[3])*q+1); }
  else { const q = p - 0.5, r = q * q; x = (((((a[0]*r+a[1])*r+a[2])*r+a[3])*r+a[4])*r+a[5])*q / (((((b[0]*r+b[1])*r+b[2])*r+b[3])*r+b[4])*r+1); }
  const u = (pnorm(x) - p) * SQRT2PI * Math.exp(x * x / 2);
  return x - u / (1 + x * u / 2);
}

// log(k!) grown on demand and all binomial probabilities P(X = k), k = 0, …, n, for 0 < π < 1.
let logFact = new Float64Array([0]);
function ensureLogFact(n) {
  if (logFact.length > n) return;
  const next = new Float64Array(n + 1);
  next.set(logFact);
  for (let i = logFact.length; i <= n; i++) next[i] = next[i - 1] + Math.log(i);
  logFact = next;
}
// The table log(0!), …, log(n!) (shared with assets/stat/dva-podily.js for the hypergeometric distribution).
export function logFactorials(n) { ensureLogFact(n); return logFact; }
export function pmfAll(n, pi) {
  ensureLogFact(n);
  const out = new Float64Array(n + 1), lp = Math.log(pi), lq = Math.log1p(-pi);
  for (let k = 0; k <= n; k++) out[k] = Math.exp(logFact[n] - logFact[k] - logFact[n - k] + k * lp + (n - k) * lq);
  return out;
}
// Sum of pmf[from..to] with Kahan compensation.
function sumRange(pmf, from, to) {
  let s = 0, c = 0;
  for (let k = Math.max(0, from); k <= Math.min(pmf.length - 1, to); k++) { const y = pmf[k] - c, t = s + y; c = (t - s) - y; s = t; }
  return s;
}

// Exact binomial test. alt: "two" (π ≠ π₀), "greater" (π > π₀), "less" (π < π₀).
// The two-sided p-value follows R's binom.test: the sum of P(X = i) over all counts i that are
// at most as probable as the observed count (relative tolerance 1 + 1e-7). `regions` lists the
// count ranges [from, to] that make up the p-value; they are highlighted in the page's chart.
export function binomTest(k, n, pi0, alt, pmf = pmfAll(n, pi0)) {
  if (alt === "greater") return {p: Math.min(1, sumRange(pmf, k, n)), regions: [[k, n]]};
  if (alt === "less") return {p: Math.min(1, sumRange(pmf, 0, k)), regions: [[0, k]]};
  const relErr = 1 + 1e-7, d = pmf[k], m = n * pi0;
  if (k === m) return {p: 1, regions: [[0, n]]};
  if (k < m) {
    let y = 0;
    for (let i = Math.ceil(m); i <= n; i++) if (pmf[i] <= d * relErr) y++;
    const regions = [[0, k], ...(y > 0 ? [[n - y + 1, n]] : [])];
    return {p: Math.min(1, sumRange(pmf, 0, k) + sumRange(pmf, n - y + 1, n)), regions};
  }
  let y = 0;
  for (let i = 0; i <= Math.floor(m); i++) if (pmf[i] <= d * relErr) y++;
  const regions = [...(y > 0 ? [[0, y - 1]] : []), [k, n]];
  return {p: Math.min(1, sumRange(pmf, 0, y - 1) + sumRange(pmf, k, n)), regions};
}

// Score test (z-test for a proportion with the standard error computed from π₀); chi² = z² for two categories.
export function scoreTest(k, n, pi0, alt) {
  const p = k / n, se0 = Math.sqrt(pi0 * (1 - pi0) / n), z = (p - pi0) / se0;
  const pv = alt === "greater" ? pnorm(-z) : alt === "less" ? pnorm(z) : Math.min(1, 2 * pnorm(-Math.abs(z)));
  return {p, se0, z, chi2: z * z, pValue: pv};
}

// Wilson interval at confidence level `conf`. side: "two" (both limits), "lower" (lower limit, upper = 1),
// "upper" (upper limit, lower = 0). The quantile is z_{1−(1−conf)/2} for two sides and z_{conf} for one,
// as in R's prop.test(correct = FALSE); limits are clipped to [0, 1] like there.
export function wilson(k, n, conf, side = "two") {
  const z = side === "two" ? qnorm(1 - (1 - conf) / 2) : qnorm(conf);
  const p = k / n, a = z * z / n, mid = (p + a / 2) / (1 + a), half = z / (1 + a) * Math.sqrt(p * (1 - p) / n + z * z / (4 * n * n));
  const lo = Math.max(0, mid - half), hi = Math.min(1, mid + half);
  return {z, mid, half, conf, side, lo: side === "upper" ? 0 : lo, hi: side === "lower" ? 1 : hi};
}

// Which interval belongs to the chosen alternative hypothesis.
// Two-sided H₁: two-sided interval at 1 − α. One-sided H₁: either the two-sided interval at 1 − 2α
// (intervalKind "two", the default) or the one-sided interval at 1 − α (intervalKind "one").
export function intervalFor(alt, alpha, intervalKind = "two") {
  if (alt === "two") return {conf: 1 - alpha, side: "two"};
  if (intervalKind === "one") return {conf: 1 - alpha, side: alt === "greater" ? "lower" : "upper"};
  return {conf: 1 - 2 * alpha, side: "two"};
}

// Everything the page shows for one input. counts: [c1, c2]; success: 0 or 1 (index of the success category).
export function proportionTest({counts, success, pi0, alt, alpha, intervalKind = "two"}) {
  const n = counts[0] + counts[1], k = counts[success];
  const pmf = pmfAll(n, pi0);
  const score = scoreTest(k, n, pi0, alt);
  const exact = binomTest(k, n, pi0, alt, pmf);
  const iv = intervalFor(alt, alpha, intervalKind);
  const ci = wilson(k, n, iv.conf, iv.side);
  const expected = [n * pi0, n * (1 - pi0)];
  return {
    n, k, p: k / n, pi0, alt, alpha, intervalKind,
    diff: k / n - pi0, diffLo: ci.lo - pi0, diffHi: ci.hi - pi0,
    score: {...score, reject: score.pValue <= alpha},
    exact: {...exact, reject: exact.p <= alpha},
    ci, expected, expectedOk: expected[0] >= 5 && expected[1] >= 5,
    pi0Inside: ci.lo <= pi0 && pi0 <= ci.hi,
    // The interval's verdict in the direction of H₁: π₀ below the lower limit (π > π₀), above the upper
    // limit (π < π₀) or outside the interval (π ≠ π₀). It agrees with the score test at the same α.
    ciRejects: alt === "greater" ? pi0 < ci.lo : alt === "less" ? pi0 > ci.hi : !(ci.lo <= pi0 && pi0 <= ci.hi),
    pmf
  };
}
