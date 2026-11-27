// Normality diagnostics for the app page quarto/app_jeden_prumer.qmd (individual values or paired differences).
// A dependency-free ES module checked against R by scripts/check-stat-lib.mjs (scripts/app-jeden-prumer.R):
// quartiles by linear interpolation and the 1,5 IQR boxplot of chapter 3, skewness and excess kurtosis as Excel's
// SKEW and KURT (chapter 3), the normal Q–Q plot of chapter 4 with positions (i − 0,5)/n and the line m + s·z,
// simultaneous 95 % bands as in qqplotr (Almeida et al., 2018; bandType "ks" and "ts" with given mean and SD),
// the Shapiro–Wilk test as R's shapiro.test (Royston, 1995) and a Gaussian kernel density estimate with R's
// default bandwidth bw.nrd0.
import { pnorm, qnorm, qbeta, describe } from "./prumer.js";
import { TS_CONF, TS_N, TS_GAMMA } from "./qq-ts-gamma.js";

export const SW_MIN = 3, SW_MAX = 5000, BAND_MAX = 5000;

// Quantile by linear interpolation (Excel PERCENTIL.INC, R type 7) of sorted values.
export function quantile7(sorted, p) {
  const h = (sorted.length - 1) * p, lo = Math.floor(h), hi = Math.ceil(h);
  return sorted[lo] + (h - lo) * (sorted[hi] - sorted[lo]);
}

// Boxplot of chapter 3: box from Q1 to Q3, whiskers to the most extreme values within 1,5 IQR of the box.
export function boxStats(sorted) {
  const q1 = quantile7(sorted, 0.25), med = quantile7(sorted, 0.5), q3 = quantile7(sorted, 0.75), iqr = q3 - q1;
  const lf = q1 - 1.5 * iqr, uf = q3 + 1.5 * iqr;
  const inside = sorted.filter(v => v >= lf && v <= uf);
  return {q1, med, q3, iqr, lowerFence: lf, upperFence: uf, whiskerLo: inside[0], whiskerHi: inside[inside.length - 1],
    outliers: sorted.filter(v => v < lf || v > uf)};
}

// Corrected skewness (SKEW, n ≥ 3) and excess kurtosis (KURT, n ≥ 4) as in Excel; null if undefined.
export function shape(x) {
  const {n, m, s} = describe(x);
  if (!(s > 0)) return {skew: null, kurt: null};
  let s3 = 0, s4 = 0;
  for (const v of x) { const z = (v - m) / s; s3 += z ** 3; s4 += z ** 4; }
  const skew = n >= 3 ? n / ((n - 1) * (n - 2)) * s3 : null;
  const kurt = n >= 4 ? n * (n + 1) / ((n - 1) * (n - 2) * (n - 3)) * s4 - 3 * (n - 1) ** 2 / ((n - 2) * (n - 3)) : null;
  return {skew, kurt};
}

// Shapiro–Wilk W test: algorithm AS R94 (Royston, 1995) as implemented in R's swilk.c, for 3 ≤ n ≤ 5000.
const poly = (cc, x) => { let r = cc[0]; if (cc.length > 1) { let p = x * cc[cc.length - 1]; for (let j = cc.length - 2; j > 0; j--) p = (p + cc[j]) * x; r += p; } return r; };
export function shapiroWilk(values) {
  const x = [...values].sort((a, b) => a - b), n = x.length;
  if (n < SW_MIN || n > SW_MAX) return null;
  const range = x[n - 1] - x[0];
  if (range < 1e-10 * Math.max(1, Math.abs(x[0]))) return null;
  const nn2 = Math.floor(n / 2), a = new Float64Array(nn2 + 1), an = n;
  const g = [-2.273, 0.459], c1 = [0, 0.221157, -0.147981, -2.07119, 4.434685, -2.706056],
    c2 = [0, 0.042981, -0.293762, -1.752461, 5.682633, -3.582633], c3 = [0.544, -0.39978, 0.025054, -6.714e-4],
    c4 = [1.3822, -0.77857, 0.062767, -0.0020322], c5 = [-1.5861, -0.31082, -0.083751, 0.0038915], c6 = [-0.4803, -0.082676, 0.0030302];
  if (n === 3) a[1] = Math.SQRT1_2;
  else {
    const an25 = an + 0.25;
    let summ2 = 0;
    for (let i = 1; i <= nn2; i++) { a[i] = qnorm((i - 0.375) / an25); summ2 += a[i] * a[i]; }
    summ2 *= 2;
    const ssumm2 = Math.sqrt(summ2), rsn = 1 / Math.sqrt(an), a1 = poly(c1, rsn) - a[1] / ssumm2;
    let i1, fac;
    if (n > 5) {
      i1 = 3;
      const a2 = -a[2] / ssumm2 + poly(c2, rsn);
      fac = Math.sqrt((summ2 - 2 * a[1] * a[1] - 2 * a[2] * a[2]) / (1 - 2 * a1 * a1 - 2 * a2 * a2));
      a[2] = a2;
    } else {
      i1 = 2;
      fac = Math.sqrt((summ2 - 2 * a[1] * a[1]) / (1 - 2 * a1 * a1));
    }
    a[1] = a1;
    for (let i = i1; i <= nn2; i++) a[i] /= -fac;
  }
  // W as the squared correlation between the ordered values and the coefficients.
  let sa = 0, sx = 0;
  for (let i = 0; i < n; i++) {
    const j = n - 1 - i;
    sx += x[i] / range;
    if (i !== j) sa += Math.sign(i - j) * a[1 + Math.min(i, j)];
  }
  sa /= n; sx /= n;
  let ssa = 0, ssx = 0, sax = 0;
  for (let i = 0; i < n; i++) {
    const j = n - 1 - i, asa = i !== j ? Math.sign(i - j) * a[1 + Math.min(i, j)] - sa : -sa, xsx = x[i] / range - sx;
    ssa += asa * asa; ssx += xsx * xsx; sax += asa * xsx;
  }
  const ssassx = Math.sqrt(ssa * ssx), w1 = (ssassx - sax) * (ssassx + sax) / (ssa * ssx), w = 1 - w1;
  let p;
  if (n === 3) p = Math.max(0, 1.90985931710274 * (Math.asin(Math.sqrt(w)) - 1.04719755119660));
  else {
    let y = Math.log(w1), m, s;
    const xx = Math.log(an);
    if (n <= 11) {
      const gamma = poly(g, an);
      if (y >= gamma) return {w, p: 1e-99, n};
      y = -Math.log(gamma - y);
      m = poly(c3, an); s = Math.exp(poly(c4, an));
    } else {
      m = poly(c5, xx); s = Math.exp(poly(c6, xx));
    }
    p = pnorm(-(y - m) / s);
  }
  return {w, p, n};
}

// Gaussian kernel density estimate with R's default bandwidth bw.nrd0 (exact sums, no binning).
export function bwNrd0(x) {
  const sorted = [...x].sort((a, b) => a - b), {s} = describe(x);
  let lo = Math.min(s, (quantile7(sorted, 0.75) - quantile7(sorted, 0.25)) / 1.34);
  if (!(lo > 0)) lo = s > 0 ? s : Math.abs(sorted[0]) > 0 ? Math.abs(sorted[0]) : 1;
  return 0.9 * lo * Math.pow(x.length, -0.2);
}
export function kde(x, grid, bw = bwNrd0(x)) {
  const n = x.length, c = 1 / (n * bw * Math.sqrt(2 * Math.PI));
  return grid.map(g => { let sum = 0; for (const v of x) { const u = (g - v) / bw; sum += Math.exp(-u * u / 2); } return c * sum; });
}

// Normal Q–Q plot of chapter 4: z_i = Φ⁻¹((i − 0,5)/n) against the sorted values, reference line m + s·z.
export function qqPoints(values) {
  const x = [...values].sort((a, b) => a - b), n = x.length, {m, s} = describe(x);
  return x.map((v, k) => { const z = qnorm((k + 0.5) / n), line = m + s * z; return {i: k + 1, z, x: v, line, resid: v - line}; });
}

// Pointwise level γ(n) of the tail-sensitive band: table from scripts/qq-ts-gamma.R, linear in log n and log γ.
export function tsGamma(n) {
  if (n <= TS_N[0]) return TS_GAMMA[0];
  for (let k = 1; k < TS_N.length; k++) if (n <= TS_N[k]) {
    if (n === TS_N[k]) return TS_GAMMA[k];
    const f = (Math.log(n) - Math.log(TS_N[k - 1])) / (Math.log(TS_N[k]) - Math.log(TS_N[k - 1]));
    return Math.exp(Math.log(TS_GAMMA[k - 1]) + f * (Math.log(TS_GAMMA[k]) - Math.log(TS_GAMMA[k - 1])));
  }
  return TS_GAMMA[TS_GAMMA.length - 1];
}

// Simultaneous 95 % band for the normal Q–Q plot in standard units (z): add m + s·(…) for original units.
// "ts": tail-sensitive band, ranks i between the quantiles γ and 1 − γ of Beta(i, n + 1 − i);
// "ks": band from the Kolmogorov–Smirnov bound ε = √(ln(2/(1 − conf))/(2n)) around (i − 0,5)/n.
// Limits beyond the normal range are ±Infinity.
const bandCache = new Map();
export function qqBand(n, type = "ts") {
  const key = `${type}:${n}`;
  if (bandCache.has(key)) return bandCache.get(key);
  let lo, hi;
  if (type === "ks") {
    const eps = Math.sqrt(Math.log(2 / (1 - TS_CONF)) / (2 * n));
    lo = Array.from({length: n}, (_, k) => { const p = (k + 0.5) / n - eps; return p > 0 ? qnorm(p) : -Infinity; });
    hi = Array.from({length: n}, (_, k) => { const p = (k + 0.5) / n + eps; return p < 1 ? qnorm(p) : Infinity; });
  } else {
    const g = tsGamma(n);
    lo = Array.from({length: n}, (_, k) => qnorm(qbeta(g, k + 1, n - k)));
    hi = lo.map((_, k) => -lo[n - 1 - k]);   // symmetry: upper limit of rank i = −lower limit of rank n + 1 − i
  }
  const res = {type, n, conf: TS_CONF, gamma: type === "ts" ? tsGamma(n) : null, lo, hi};
  bandCache.set(key, res);
  if (bandCache.size > 40) bandCache.delete(bandCache.keys().next().value);
  return res;
}
