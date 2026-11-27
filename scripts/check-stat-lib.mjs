// Checks the calculations of the app pages against reference values from R. Run from the project root:
// node scripts/check-stat-lib.mjs
// - quarto/app_jeden_podil.qmd (module assets/stat/podil.js): the array REFERENCE is the output of
//   Rscript --vanilla scripts/app-jeden-podil.R; update it from there.
// - quarto/app_dva_podily.qmd (module assets/stat/dva-podily.js): scripts/reference/app-dva-podily.json is written
//   by Rscript --vanilla scripts/app-dva-podily.R.
// - quarto/app_jeden_prumer.qmd (modules assets/stat/prumer.js and normalita.js): scripts/reference/app-jeden-prumer.json
//   is written by Rscript --vanilla scripts/app-jeden-prumer.R (after scripts/qq-ts-gamma.R).
import { readFileSync } from 'node:fs';
import { scoreTest, binomTest, wilson, intervalFor, proportionTest, pmfAll } from '../assets/stat/podil.js';
import * as D from '../assets/stat/dva-podily.js';
import * as P from '../assets/stat/prumer.js';
import * as N from '../assets/stat/normalita.js';

// R (scripts/app-jeden-podil.R): [k, n, pi0, alt] -> [z, score p-value, exact p-value,
//   Wilson 95 % lo, hi, Wilson 90 % lo, hi, one-sided 95 % lower limit, one-sided 95 % upper limit]
const REFERENCE = [
  [[10, 20, 0.25, "two"], [2.58198889747161, 0.00982327450751926, 0.0170356288826952, 0.299298008198212, 0.700701991801788, 0.327403767885156, 0.672596232114844, 0.327403767885156, 0.672596232114844]],
  [[10, 20, 0.25, "greater"], [2.58198889747161, 0.00491163725375962, 0.0138644169437612, 0.299298008198212, 0.700701991801788, 0.327403767885156, 0.672596232114844, 0.327403767885156, 0.672596232114844]],
  [[10, 20, 0.25, "less"], [2.58198889747161, 0.99508836274624, 0.996057858335917, 0.299298008198212, 0.700701991801788, 0.327403767885156, 0.672596232114844, 0.327403767885156, 0.672596232114844]],
  [[7, 8, 0.5, "two"], [2.12132034355964, 0.0338948535246893, 0.0703125, 0.529111817787146, 0.977582508549943, 0.588856625669988, 0.97160067626219, 0.588856625669988, 0.97160067626219]],
  [[7, 8, 0.5, "greater"], [2.12132034355964, 0.0169474267623446, 0.03515625, 0.529111817787146, 0.977582508549943, 0.588856625669988, 0.97160067626219, 0.588856625669988, 0.97160067626219]],
  [[7, 8, 0.5, "less"], [2.12132034355964, 0.983052573237655, 0.99609375, 0.529111817787146, 0.977582508549943, 0.588856625669988, 0.97160067626219, 0.588856625669988, 0.97160067626219]],
  [[6, 8, 0.5, "two"], [1.41421356237309, 0.157299207050284, 0.2890625, 0.409275430310169, 0.928520787247891, 0.460153045487181, 0.913485155800938, 0.460153045487181, 0.913485155800938]],
  [[6, 8, 0.5, "greater"], [1.41421356237309, 0.0786496035251426, 0.14453125, 0.409275430310169, 0.928520787247891, 0.460153045487181, 0.913485155800938, 0.460153045487181, 0.913485155800938]],
  [[6, 8, 0.5, "less"], [1.41421356237309, 0.921350396474857, 0.96484375, 0.409275430310169, 0.928520787247891, 0.460153045487181, 0.913485155800938, 0.460153045487181, 0.913485155800938]],
  [[106, 329, 0.25, "two"], [3.02388331687634, 0.00249552667432244, 0.00333146034071948, 0.273994657958207, 0.374486632760359, 0.281409195731402, 0.365868330047447, 0.281409195731402, 0.365868330047447]],
  [[106, 329, 0.25, "greater"], [3.02388331687634, 0.00124776333716122, 0.00193221542288028, 0.273994657958207, 0.374486632760359, 0.281409195731402, 0.365868330047447, 0.281409195731402, 0.365868330047447]],
  [[106, 329, 0.25, "less"], [3.02388331687634, 0.998752236662839, 0.998692462042994, 0.273994657958207, 0.374486632760359, 0.281409195731402, 0.365868330047447, 0.281409195731402, 0.365868330047447]],
  [[0, 15, 0.1, "two"], [-1.29099444873581, 0.196705602458947, 0.38995220120104, 0, 0.203883301035849, 0, 0.15280770461014, 0, 0.15280770461014]],
  [[0, 15, 0.1, "greater"], [-1.29099444873581, 0.901647198770527, 1, 0, 0.203883301035849, 0, 0.15280770461014, 0, 0.15280770461014]],
  [[0, 15, 0.1, "less"], [-1.29099444873581, 0.0983528012294734, 0.205891132094649, 0, 0.203883301035849, 0, 0.15280770461014, 0, 0.15280770461014]],
  [[25, 25, 0.9, "two"], [1.66666666666667, 0.0955807045456296, 0.16978341996465, 0.866807749060952, 1, 0.902346493993949, 1, 0.902346493993949, 1]],
  [[25, 25, 0.9, "greater"], [1.66666666666667, 0.0477903522728147, 0.0717897987691853, 0.866807749060952, 1, 0.902346493993949, 1, 0.902346493993949, 1]],
  [[25, 25, 0.9, "less"], [1.66666666666667, 0.952209647727185, 1, 0.866807749060952, 1, 0.902346493993949, 1, 0.902346493993949, 1]],
  [[0, 25, 0.3, "two"], [-3.27326835353989, 0.0010631149171586, 0.000232731069439667, 0, 0.133192250939048, 0, 0.0976535060060509, 0, 0.0976535060060509]],
  [[0, 25, 0.3, "greater"], [-3.27326835353989, 0.999468442541421, 1, 0, 0.133192250939048, 0, 0.0976535060060509, 0, 0.0976535060060509]],
  [[0, 25, 0.3, "less"], [-3.27326835353989, 0.000531557458579302, 0.000134106861966396, 0, 0.133192250939048, 0, 0.0976535060060509, 0, 0.0976535060060509]],
  [[1, 25, 0.04, "two"], [0, 1, 1, 0.00709623350198726, 0.195440637361937, 0.00897486843424125, 0.160866357091326, 0.00897486843424125, 0.160866357091326]],
  [[1, 25, 0.04, "greater"], [0, 0.5, 0.639603283141982, 0.00709623350198726, 0.195440637361937, 0.00897486843424125, 0.160866357091326, 0.00897486843424125, 0.160866357091326]],
  [[1, 25, 0.04, "less"], [0, 0.5, 0.735809963585121, 0.00709623350198726, 0.195440637361937, 0.00897486843424125, 0.160866357091326, 0.00897486843424125, 0.160866357091326]],
  [[3, 10, 0.333333333333333, "two"], [-0.223606797749979, 0.823063273758122, 1, 0.107791267406301, 0.603221852538855, 0.126876583903198, 0.558300204130165, 0.126876583903198, 0.558300204130165]],
  [[3, 10, 0.333333333333333, "greater"], [-0.223606797749979, 0.588468363120939, 0.700858608951887, 0.107791267406301, 0.603221852538855, 0.126876583903198, 0.558300204130165, 0.126876583903198, 0.558300204130165]],
  [[3, 10, 0.333333333333333, "less"], [-0.223606797749979, 0.411531636879061, 0.559264339785602, 0.107791267406301, 0.603221852538855, 0.126876583903198, 0.558300204130165, 0.126876583903198, 0.558300204130165]],
  [[31, 80, 0.25, "two"], [2.84018778721877, 0.00450869836490423, 0.00642128013158996, 0.288245651253051, 0.497063427892443, 0.30298859063287, 0.479371826235792, 0.30298859063287, 0.479371826235792]],
  [[31, 80, 0.25, "greater"], [2.84018778721877, 0.00225434918245212, 0.00458198556817979, 0.288245651253051, 0.497063427892443, 0.30298859063287, 0.479371826235792, 0.30298859063287, 0.479371826235792]],
  [[31, 80, 0.25, "less"], [2.84018778721877, 0.997745650817548, 0.997760857832424, 0.288245651253051, 0.497063427892443, 0.30298859063287, 0.479371826235792, 0.30298859063287, 0.479371826235792]],
  [[12, 80, 0.25, "two"], [-2.06559111797729, 0.0388671038124172, 0.0387359340695777, 0.0879404050616355, 0.244132285613233, 0.0958599436812198, 0.227039131021287, 0.0958599436812198, 0.227039131021287]],
  [[12, 80, 0.25, "greater"], [-2.06559111797729, 0.980566448093791, 0.989358906107808, 0.0879404050616355, 0.244132285613233, 0.0958599436812198, 0.227039131021287, 0.0958599436812198, 0.227039131021287]],
  [[12, 80, 0.25, "less"], [-2.06559111797729, 0.0194335519062086, 0.0221062208495862, 0.0879404050616355, 0.244132285613233, 0.0958599436812198, 0.227039131021287, 0.0958599436812198, 0.227039131021287]],
  [[56, 140, 0.5, "two"], [-2.36643191323985, 0.0179604775260788, 0.0221549559805596, 0.322566810514292, 0.48277442955959, 0.334414517108853, 0.469377267552919, 0.334414517108853, 0.469377267552919]],
  [[56, 140, 0.5, "greater"], [-2.36643191323985, 0.991019761236961, 0.993021332937579, 0.322566810514292, 0.48277442955959, 0.334414517108853, 0.469377267552919, 0.334414517108853, 0.469377267552919]],
  [[56, 140, 0.5, "less"], [-2.36643191323985, 0.00898023876303938, 0.0110774779902798, 0.322566810514292, 0.48277442955959, 0.334414517108853, 0.469377267552919, 0.334414517108853, 0.469377267552919]],
  [[4, 16, 0.5, "two"], [-2, 0.0455002638963585, 0.076812744140625, 0.10182067491213, 0.494983165355088, 0.117555804465337, 0.454763491168467, 0.117555804465337, 0.454763491168467]],
  [[4, 16, 0.5, "greater"], [-2, 0.977249868051821, 0.989364624023438, 0.10182067491213, 0.494983165355088, 0.117555804465337, 0.454763491168467, 0.117555804465337, 0.454763491168467]],
  [[4, 16, 0.5, "less"], [-2, 0.0227501319481792, 0.0384063720703125, 0.10182067491213, 0.494983165355088, 0.117555804465337, 0.454763491168467, 0.117555804465337, 0.454763491168467]],
  [[18, 60, 0.3, "two"], [0, 1, 1, 0.198981661387691, 0.425087079469145, 0.213050630109286, 0.404208089328022, 0.213050630109286, 0.404208089328022]],
  [[18, 60, 0.3, "greater"], [0, 0.5, 0.548563722027956, 0.198981661387691, 0.425087079469145, 0.213050630109286, 0.404208089328022, 0.213050630109286, 0.404208089328022]],
  [[18, 60, 0.3, "less"], [0, 0.5, 0.563239901565025, 0.198981661387691, 0.425087079469145, 0.213050630109286, 0.404208089328022, 0.213050630109286, 0.404208089328022]],
  [[500, 1000, 0.52, "two"], [-1.26592420885458, 0.205540218222619, 0.20573578942774, 0.469069600368104, 0.530930399631896, 0.47402769147842, 0.52597230852158, 0.47402769147842, 0.52597230852158]],
  [[500, 1000, 0.52, "greater"], [-1.26592420885458, 0.897229890888691, 0.902746008640386, 0.469069600368104, 0.530930399631896, 0.47402769147842, 0.52597230852158, 0.47402769147842, 0.52597230852158]],
  [[500, 1000, 0.52, "less"], [-1.26592420885458, 0.102770109111309, 0.108581063254378, 0.469069600368104, 0.530930399631896, 0.47402769147842, 0.52597230852158, 0.47402769147842, 0.52597230852158]],
  [[2, 40, 0.2, "two"], [-2.37170824512628, 0.0177060658073666, 0.0158579911483344, 0.0138206673861484, 0.16503877369141, 0.0166862822149395, 0.140331821565973, 0.0166862822149395, 0.140331821565973]],
  [[2, 40, 0.2, "greater"], [-2.37170824512628, 0.991146967096317, 0.998537849204637, 0.0138206673861484, 0.16503877369141, 0.0166862822149395, 0.140331821565973, 0.0166862822149395, 0.140331821565973]],
  [[2, 40, 0.2, "less"], [-2.37170824512628, 0.00885303290368331, 0.00794213727481488, 0.0138206673861484, 0.16503877369141, 0.0166862822149395, 0.140331821565973, 0.0166862822149395, 0.140331821565973]],
  [[5000, 10000, 0.49, "two"], [2.00040012004002, 0.0454570754450173, 0.0465416850167411, 0.490202061815405, 0.509797938184595, 0.491776844195279, 0.508223155804721, 0.491776844195279, 0.508223155804721]],
  [[5000, 10000, 0.49, "greater"], [2.00040012004002, 0.0227285377225087, 0.0232817125192691, 0.490202061815405, 0.509797938184595, 0.491776844195279, 0.508223155804721, 0.491776844195279, 0.508223155804721]],
  [[5000, 10000, 0.49, "less"], [2.00040012004002, 0.977271462277491, 0.97779764787012, 0.490202061815405, 0.509797938184595, 0.491776844195279, 0.508223155804721, 0.491776844195279, 0.508223155804721]],
  [[13, 20, 0.6, "two"], [0.456435464587639, 0.648076868139146, 0.820294212245311, 0.432854276685236, 0.818808175898918, 0.466512688848472, 0.797739959943239, 0.466512688848472, 0.797739959943239]],
  [[13, 20, 0.6, "greater"], [0.456435464587639, 0.324038434069573, 0.415892937557535, 0.432854276685236, 0.818808175898918, 0.466512688848472, 0.797739959943239, 0.466512688848472, 0.797739959943239]],
  [[13, 20, 0.6, "less"], [0.456435464587639, 0.675961565930427, 0.749989328062178, 0.432854276685236, 0.818808175898918, 0.466512688848472, 0.797739959943239, 0.466512688848472, 0.797739959943239]],
  [[1, 1, 0.5, "two"], [1, 0.317310507862914, 1, 0.206549314377238, 1, 0.269865948784054, 1, 0.269865948784054, 1]],
  [[1, 1, 0.5, "greater"], [1, 0.158655253931457, 0.5, 0.206549314377238, 1, 0.269865948784054, 1, 0.269865948784054, 1]],
  [[1, 1, 0.5, "less"], [1, 0.841344746068543, 1, 0.206549314377238, 1, 0.269865948784054, 1, 0.269865948784054, 1]],
  [[0, 1, 0.2, "two"], [-0.5, 0.617075077451974, 1, 0, 0.793450685622763, 0, 0.730134051215946, 0, 0.730134051215946]],
  [[0, 1, 0.2, "greater"], [-0.5, 0.691462461274013, 1, 0, 0.793450685622763, 0, 0.730134051215946, 0, 0.730134051215946]],
  [[0, 1, 0.2, "less"], [-0.5, 0.308537538725987, 0.8, 0, 0.793450685622763, 0, 0.730134051215946, 0, 0.730134051215946]]
];

let failures = 0, checks = 0;
const near = (got, want, msg, tol = 1e-9) => {
  checks++;
  const ok = Number.isFinite(got) && Math.abs(got - want) <= tol * Math.max(1, Math.abs(want));
  if (!ok) { failures++; console.error(`FAIL ${msg}: ${got} vs ${want}`); }
};
const eq = (got, want, msg) => { checks++; if (JSON.stringify(got) !== JSON.stringify(want)) { failures++; console.error(`FAIL ${msg}: ${JSON.stringify(got)} vs ${JSON.stringify(want)}`); } };

for (const [[k, n, pi0, alt], v] of REFERENCE) {
  const tag = `${k} z ${n}, π₀ = ${pi0}, ${alt}`;
  const s = scoreTest(k, n, pi0, alt);
  near(s.z, v[0], `${tag}: z`);
  near(s.pValue, v[1], `${tag}: score p-value`);
  near(binomTest(k, n, pi0, alt).p, v[2], `${tag}: exact p-value`);
  const w95 = wilson(k, n, 0.95), w90 = wilson(k, n, 0.90), lo = wilson(k, n, 0.95, "lower"), hi = wilson(k, n, 0.95, "upper");
  near(w95.lo, v[3], `${tag}: Wilson 95 % lo`); near(w95.hi, v[4], `${tag}: Wilson 95 % hi`);
  near(w90.lo, v[5], `${tag}: Wilson 90 % lo`); near(w90.hi, v[6], `${tag}: Wilson 90 % hi`);
  near(lo.lo, v[7], `${tag}: one-sided lower limit`); eq(lo.hi, 1, `${tag}: one-sided lower interval ends at 1`);
  near(hi.hi, v[8], `${tag}: one-sided upper limit`); eq(hi.lo, 0, `${tag}: one-sided upper interval starts at 0`);
  // The highlighted regions of the exact test sum to its p-value.
  const pmf = pmfAll(n, pi0), t = binomTest(k, n, pi0, alt, pmf);
  const regionSum = t.regions.reduce((a, [f, l]) => { for (let i = f; i <= l; i++) a += pmf[i]; return a; }, 0);
  near(Math.min(1, regionSum), t.p, `${tag}: regions sum to the exact p-value`, 1e-12);
}

// The interval's verdict in the direction of H₁ agrees with the score test for every case, alternative and interval kind.
for (const [[k, n, pi0, alt]] of REFERENCE) for (const kind of ["two", "one"]) for (const alpha of [0.05, 0.1]) {
  const r = proportionTest({counts: [k, n - k], success: 0, pi0, alt, alpha, intervalKind: kind});
  eq(r.ciRejects, r.score.reject, `${k} z ${n}, π₀ = ${pi0}, ${alt}, ${kind}, α = ${alpha}: interval agrees with the score test`);
}
// 1 z 18 against 0,25 with H1 π > π₀: π₀ lies outside the 90 % interval, but below the upper limit only; no rejection.
const r18 = proportionTest({counts: [1, 17], success: 0, pi0: 0.25, alt: "greater", alpha: 0.05});
eq([r18.pi0Inside, r18.ciRejects, r18.score.reject], [false, false, false], "1 z 18: π₀ outside on the other side");

// Interval chosen for the hypothesis and α.
eq(intervalFor("two", 0.05), {conf: 0.95, side: "two"}, "two-sided H1");
eq(intervalFor("greater", 0.05), {conf: 0.9, side: "two"}, "one-sided H1, default two-sided interval at 1 − 2α");
eq(intervalFor("greater", 0.05, "one"), {conf: 0.95, side: "lower"}, "H1 π > π₀, one-sided interval");
eq(intervalFor("less", 0.05, "one"), {conf: 0.95, side: "upper"}, "H1 π < π₀, one-sided interval");

// The page's main example: 10 correct and 10 wrong answers, π₀ = 0,25, H1 π > π₀ (chapters 6 and 9).
const r = proportionTest({counts: [10, 10], success: 0, pi0: 0.25, alt: "greater", alpha: 0.05});
eq([r.n, r.k], [20, 10], "example: n and k");
near(r.exact.p, 0.0138644169437612, "example: exact p-value as in chapter 6 (0,014)");
near(r.ci.lo, 0.327403767885156, "example: lower limit of the 90 % Wilson interval");
eq([r.score.reject, r.exact.reject, r.pi0Inside, r.expectedOk], [true, true, false, true], "example: decisions and conditions");
near(r.expected[0], 5, "example: expected count n·π₀"); near(r.expected[1], 15, "example: expected count n·(1 − π₀)");
near(r.diff, 0.25, "example: difference p − π₀");
// Success is the second category.
const r2 = proportionTest({counts: [3, 7], success: 1, pi0: 0.5, alt: "two", alpha: 0.05});
eq([r2.n, r2.k], [10, 7], "second category as success");
// Chapter 9: two-sided score test of 10 z 20 against 0,25 gives z = 2,582 and p = 0,0098; chi² = z².
const s9 = scoreTest(10, 20, 0.25, "two");
near(s9.chi2, 6.66666666666667, "chi-square equals z²");
// Large n stays finite.
const big = proportionTest({counts: [50000, 50000], success: 0, pi0: 0.5, alt: "two", alpha: 0.05});
near(big.exact.p, 1, "n = 100 000, k = n·π₀: exact p-value 1");

// ---- Two independent proportions (assets/stat/dva-podily.js) ----
const REF2 = JSON.parse(readFileSync(new URL('./reference/app-dva-podily.json', import.meta.url), 'utf8'));
const nearOrNull = (got, want, msg, tol = 1e-9) => want === null ? eq(got === null || !Number.isFinite(got) ? null : got, null, msg) : near(got, want, msg, tol);
for (const [name, c] of Object.entries(REF2.cases)) {
  const [[a, b], [cc, d]] = c.cells, n1 = a + b, n2 = cc + d;
  for (const sc of c.score) {
    const tag = `${name}, δ₀ = ${sc.delta}, ${sc.alt}`;
    const t = D.scoreDiffTest(a, n1, cc, n2, sc.delta, sc.alt);
    near(t.p1t, sc.p1t, `${tag}: restricted p₁`); near(t.p2t, sc.p2t, `${tag}: restricted p₂`);
    near(t.se0, sc.se0, `${tag}: SE₀`);
    nearOrNull(t.z, sc.z, `${tag}: z`); nearOrNull(t.pValue, sc.p, `${tag}: p-value`);
  }
  if (c.fisher) for (const [alt, p] of Object.entries(c.fisher)) near(D.fisherTest(a, n1, cc, n2, alt).p, p, `${name}, ${alt}: Fisher p-value`);
  const nc = (conf, side) => D.newcombe(a, n1, cc, n2, conf, side);
  // DescTools does not clip the Wilson limits to [0, 1]; at a proportion of 1 its limits exceed 1 by ~1e-8.
  const nearN = (got, want, msg) => near(got, want, msg, 1e-7);
  const w = c.newcombe;
  nearN(nc(0.95).lo, w.two95[0], `${name}: Newcombe 95 % lo`); nearN(nc(0.95).hi, w.two95[1], `${name}: Newcombe 95 % hi`);
  nearN(nc(0.90).lo, w.two90[0], `${name}: Newcombe 90 % lo`); nearN(nc(0.90).hi, w.two90[1], `${name}: Newcombe 90 % hi`);
  nearN(nc(0.95, "lower").lo, w.lower95[0], `${name}: one-sided lower limit`); eq(nc(0.95, "lower").hi, w.lower95[1], `${name}: one-sided lower interval ends at 1`);
  nearN(nc(0.95, "upper").hi, w.upper95[1], `${name}: one-sided upper limit`); eq(nc(0.95, "upper").lo, w.upper95[0], `${name}: one-sided upper interval starts at −1`);
  const r = D.ratios(a, b, cc, d, 0.95);
  nearOrNull(r.rr, c.rr, `${name}: risk ratio`); nearOrNull(r.or, c.or, `${name}: odds ratio`);
  nearOrNull(r.rrCi ? r.rrCi.lo : null, c.rrCi[0], `${name}: RR lo`); nearOrNull(r.rrCi ? r.rrCi.hi : null, c.rrCi[1], `${name}: RR hi`);
  nearOrNull(r.orCi ? r.orCi.lo : null, c.orCi[0], `${name}: OR lo`); nearOrNull(r.orCi ? r.orCi.hi : null, c.orCi[1], `${name}: OR hi`);
  nearOrNull(D.phi(a, b, cc, d), c.phi, `${name}: φ`);
}
// For δ₀ = 0 the module's test is the test with the pooled proportion (checked against prop.test in R) and χ² = z².
const st = REF2.cases.stres;
const R0 = D.twoProportions({cells: st.cells});
near(R0.score.chi2, st.score[0].z ** 2, "stres: χ² = z²");
// Chapter 9 numbers (rounded as printed there).
const r3 = (v, dg = 3) => Number(v.toFixed(dg));
eq([r3(R0.score.z, 2), r3(R0.score.pValue), r3(R0.ci.lo), r3(R0.ci.hi), r3(R0.fisher.p, 2)], [1.48, 0.138, -0.032, 0.227, 0.18], "chapter 9: stress example");
eq(r3(D.fisherTest(8, 10, 3, 10, "two").p), 0.07, "chapter 9: pilot study Fisher 0,070");
const Dn = D.twoProportions({cells: REF2.cases.daniels.cells});
eq([r3(Dn.ratios.rr, 2), r3(Dn.ratios.rrCi.lo, 2), r3(Dn.ratios.rrCi.hi, 2), r3(Dn.ratios.or, 2), r3(Dn.ratios.orCi.lo, 2), r3(Dn.ratios.orCi.hi, 2), r3(Dn.phi, 2), r3(Dn.ci.lo), r3(Dn.ci.hi)],
  [2.34, 1.5, 3.66, 3.23, 1.8, 5.82, 0.25, 0.119, 0.33], "chapter 9: Daniels example");
const R2x = D.twoProportions({cells: REF2.cases.dvojnasobek.cells});
eq([r3(R2x.score.pValue), r3(R2x.ci.lo), r3(R2x.ci.hi)], [0.036, 0.007, 0.191], "chapter 9: twice the sample");
// Fisher regions sum to the p-value; Fisher only for δ₀ = 0.
for (const alt of ["two", "greater", "less"]) { const f = D.fisherTest(8, 10, 3, 10, alt); near(Math.min(1, f.d.reduce((s, v, j) => s + (f.inP[j] ? v : 0), 0)), f.p, `pilot ${alt}: Fisher regions`, 1e-12); }
eq(D.twoProportions({cells: st.cells, delta0: 0.1}).fisher, null, "no Fisher test for δ₀ ≠ 0");
// All cases in one category with δ₀ = 0: the score test is undefined.
const allZero = D.twoProportions({cells: [[0, 15], [0, 20]]});
eq([Number.isNaN(allZero.score.z), allZero.score.reject, allZero.phi], [true, false, null], "zero column: test undefined");

// Exact unconditional test: p-values against the package Exact (fine nuisance grid).
for (const e of REF2.exact) {
  const [[a, b], [cc, d]] = REF2.cases[e.case].cells;
  const r = D.exactUncondP(a, a + b, cc, cc + d, e.delta, e.alt);
  const tag = `exact ${e.case}, δ = ${e.delta}, ${e.alt}`;
  near(r.t0, e.t, `${tag}: statistic`, 1e-6);
  // The module includes the ends of the nuisance range and refines the maximum, so its supremum is equal to or
  // slightly above the package's grid maximum (never below). Skipped: ties t₀ = 0 (observed difference = δ),
  // where the package's result depends on rounding of tied statistics.
  if (Math.abs(r.t0) < 1e-9) continue;
  checks++;
  if (!(r.p >= e.p - 1e-7 && r.p <= e.p + 1e-3)) { failures++; console.error(`FAIL ${tag}: p-value ${r.p} vs ${e.p}`); }
}
// Intervals: Agresti & Min (2001), table 3, n₁ = n₂ = 10, inverted two-sided score test (3 decimals).
const TABLE3 = [[5, 0, 0.132, 0.778], [5, 1, -0.001, 0.700], [5, 2, -0.142, 0.646], [5, 3, -0.249, 0.560], [5, 4, -0.349, 0.507], [5, 5, -0.419, 0.419],
  [2, 0, -0.132, 0.525], [2, 1, -0.265, 0.441], [2, 2, -0.377, 0.377], [2, 3, -0.455, 0.296], [2, 4, -0.551, 0.224]];
for (const [x1, x2, lo, hi] of TABLE3) {
  const iv = D.exactInterval(x1, 10, x2, 10, 0.05);
  near(r3(iv.lo), lo, `Agresti & Min table 3, ${x1} and ${x2}: lower limit`, 1.01e-3); near(r3(iv.hi), hi, `Agresti & Min table 3, ${x1} and ${x2}: upper limit`, 1.01e-3);
}
// Against the package Exact: same limits where p(δ) has no narrow peak above α. For the stress data the module's
// lower limit lies further out: p(−0,0381) > 0,05 (checked above against Exact) and, as in Agresti & Min, the
// interval runs to the outermost accepted values.
for (const [name, ci] of Object.entries(REF2.exactCi)) {
  const [[a, b], [cc, d]] = REF2.cases[name].cells, iv = D.exactInterval(a, a + b, cc, cc + d, 0.05);
  near(iv.hi, ci[1], `exact interval ${name}: upper limit vs Exact`, 1e-4);
  if (name === "stres") { checks++; if (!(iv.lo < ci[0] && iv.lo < -0.038 && iv.lo > -0.0383)) { failures++; console.error(`FAIL stres exact lower limit ${iv.lo}`); } }
  else near(iv.lo, ci[0], `exact interval ${name}: lower limit vs Exact`, 1e-4);
}
// The exact procedure for the page: one-sided H₁ with the noninferiority preset and the size limit.
const ni = D.exactProcedure({x1: 66, n1: 100, x2: 70, n2: 100, delta0: -0.1, alt: "greater", alpha: 0.05, intervalKind: "one"});
eq([ni.reject, ni.ciRejects, ni.ci.hi], [false, false, 1], "noninferiority preset: exact test and one-sided 95 % interval");
// With a one-sided H₁ the exact interval is always one-sided (it then decides exactly as the exact test).
const ni2 = D.exactProcedure({x1: 66, n1: 100, x2: 70, n2: 100, delta0: -0.1, alt: "greater", alpha: 0.05});
eq([ni2.ci.side, ni2.ci.conf.toFixed(2), ni2.ci.lo < -0.1], ["lower", "0.95", true], "noninferiority preset: one-sided 95 % exact interval reaches below δ₀");
for (const [x1, x2] of [[6, 1], [8, 3], [60, 45], [66, 70], [0, 4], [10, 10]]) for (const alt of ["greater", "less"]) for (const delta0 of [-0.2, 0, 0.1]) {
  const e = D.exactProcedure({x1, n1: x1 > 10 ? 100 : 10, x2, n2: x2 > 10 ? 100 : 10, delta0, alt, alpha: 0.05});
  eq(e.ciRejects, e.reject, `exact ${x1}, ${x2}, ${alt}, δ₀ = ${delta0}: one-sided interval agrees with the exact test`);
}
eq(D.exactProcedure({x1: 189, n1: 11034, x2: 104, n2: 11037, delta0: 0, alt: "two", alpha: 0.05}), null, "exact procedure only up to EXACT_MAX");

// ---------- Test of one mean: quarto/app_jeden_prumer.qmd (assets/stat/prumer.js, assets/stat/normalita.js) ----------
// scripts/reference/app-jeden-prumer.json is written by Rscript --vanilla scripts/app-jeden-prumer.R.
const REF3 = JSON.parse(readFileSync(new URL("./reference/app-jeden-prumer.json", import.meta.url), "utf8"));
const inf = v => v === "Inf" ? Infinity : v === "-Inf" ? -Infinity : v;
const nearInf = (got, want, msg, tol = 1e-9) => { want = inf(want); if (!Number.isFinite(want)) eq(got, want, msg); else near(got, want, msg, tol); };
for (const c of REF3.means) {
  const i = c.input, tag = `${c.case} ${i.test} ${i.alt} ${i.kind} α = ${i.alpha}`;
  const r = P.meanTest({test: i.test, m: i.m, s: i.sd, sigma: i.sd, n: i.n, mu0: i.mu0, alt: i.alt, alpha: i.alpha, intervalKind: i.kind});
  near(r.se, c.se, `${tag}: SE`); near(r.stat, c.stat, `${tag}: statistic`); near(r.pValue, c.p, `${tag}: p-value`);
  near(r.ci.q, c.q, `${tag}: quantile`, 1e-10);
  nearInf(r.ci.lo, c.lo, `${tag}: CI lo`); nearInf(r.ci.hi, c.hi, `${tag}: CI hi`);
  near(r.d.value, c.d, `${tag}: d`);
  // The exact interval for d: both sides solve P(T ≤ t | δ) = target to 1e-12; tolerance for the quadrature.
  nearInf(r.d.lo, c.dlo, `${tag}: d lo`, 1e-7); nearInf(r.d.hi, c.dhi, `${tag}: d hi`, 1e-7);
  if (c.J !== null) near(r.d.J, c.J, `${tag}: Hedges J`); else eq(r.d.J ?? null, null, `${tag}: no Hedges J`);
  eq(r.ciRejects, r.reject, `${tag}: interval agrees with the test`);
}
for (const [name, e] of Object.entries(REF3.tost)) {
  const x = e.data === "uzkost" ? P.describe(REF3.diag.uzkost.x) : {m: e.m, s: e.s, n: e.n};
  const r = P.equivalence({test: "t", m: x.m, se: x.s / Math.sqrt(x.n), df: x.n - 1, lower: e.lower, upper: e.upper, alpha: e.alpha});
  near(r.tL, e.tL, `TOST ${name}: tL`); near(r.tU, e.tU, `TOST ${name}: tU`); near(r.pL, e.pL, `TOST ${name}: pL`); near(r.pU, e.pU, `TOST ${name}: pU`);
  near(r.ci.lo, e.lo, `TOST ${name}: 90 % lo`); near(r.ci.hi, e.hi, `TOST ${name}: 90 % hi`);
  eq(r.equivalent, r.ci.lo >= e.lower && r.ci.hi <= e.upper, `TOST ${name}: decision equals the interval rule`);
}
eq(P.equivalence({test: "t", m: 48.5, se: 10 / 20, df: 399, lower: 47, upper: 53, alpha: 0.05}).equivalent, true, "chapter 7: online version equivalent");
for (const c of REF3.paired) {
  const tag = `paired ${c.case} ${c.side}`, pd = P.pairedDescribe(c.x1, c.x2);
  near(pd.mD, c.mD, `${tag}: m_D`); near(pd.sD, c.sD, `${tag}: s_D`); near(pd.s1, c.s1, `${tag}: s1`); near(pd.r, c.r, `${tag}: r`);
  const pe = P.pairedEffects({n: pd.n, mD: pd.mD, sD: pd.sD, sRef: pd.s1, sOther: pd.s2, r: pd.r, conf: c.conf, side: c.side});
  const chk = (got, want, what, tol = 1e-9) => { near(got.value, want[0], `${tag}: ${what}`); nearInf(got.lo, want[1], `${tag}: ${what} lo`, tol); nearInf(got.hi, want[2], `${tag}: ${what} hi`, tol); };
  chk(pe.ref, c.ref, "d (reference SD)"); near(pe.ref.adj, c.ref[3], `${tag}: adjusted d (reference SD)`);
  chk(pe.avg, c.avg, "d (average variance)"); near(pe.avg.adj, c.avg[3], `${tag}: adjusted d (average variance)`);
  chk(pe.dz, c.dz, "dz", 1e-7);
}
// Chapter 8 numbers (variant A and anorexia).
const A = REF3.paired.find(c => c.case === "spanek" && c.side === "two");
const pdA = P.pairedDescribe(A.x1, A.x2), mA = P.meanTest({m: pdA.mD, s: pdA.sD, n: pdA.n, mu0: 0});
eq([Number(mA.stat.toFixed(2)), Number(mA.ci.lo.toFixed(2)), Number(mA.ci.hi.toFixed(2))], [5.07, 1.98, 5.02], "chapter 8: variant A paired t-test");
const an = P.pairedEffects({n: 17, mD: 3.295, sD: 3.247, sRef: 2.276});
eq([Number(an.ref.value.toFixed(2)), Number(an.dz.value.toFixed(2))], [1.45, 1.01], "chapter 8: anorexia d 1,45 and 1,01");
// Chapter 7, exercise 7.
const u7 = P.describe(REF3.diag.uzkost.x), r7 = P.meanTest({m: u7.m, s: u7.s, n: u7.n, mu0: 20});
eq([Number(r7.stat.toFixed(2)), Number(r7.pValue.toFixed(3)), Number(r7.ci.lo.toFixed(2)), Number(r7.ci.hi.toFixed(2))], [3.15, 0.005, 20.74, 23.66], "chapter 7: exercise 7");
// Normality diagnostics.
for (const [name, d] of Object.entries(REF3.diag)) {
  const x = d.x, sorted = [...x].sort((a, b) => a - b), b = N.boxStats(sorted), sh = N.shape(x), sw = N.shapiroWilk(x);
  near(b.q1, d.q[0], `${name}: Q1`); near(b.med, d.q[1], `${name}: median`); near(b.q3, d.q[2], `${name}: Q3`);
  near(b.whiskerLo, d.whiskerLo, `${name}: lower whisker`); near(b.whiskerHi, d.whiskerHi, `${name}: upper whisker`); eq(b.outliers.length, d.nOut, `${name}: outliers`);
  if (d.skew !== null) near(sh.skew, d.skew, `${name}: SKEW`); else eq(sh.skew, null, `${name}: no SKEW`);
  if (d.kurt !== null) near(sh.kurt, d.kurt, `${name}: KURT`); else eq(sh.kurt, null, `${name}: no KURT`);
  near(sw.w, d.W, `${name}: Shapiro–Wilk W`); near(sw.p, d.pW, `${name}: Shapiro–Wilk p`, 1e-7);
  near(N.bwNrd0(x), d.bw, `${name}: bandwidth`);
  N.kde(x, d.grid).forEach((v, k) => near(v, d.dens[k], `${name}: density ${k}`, 1e-10));
  N.kde(x, d.grid.slice(1, 6)).forEach((v, k) => { checks++; if (Math.abs(v - d.densR[k]) > 0.02 * Math.max(...d.dens)) { failures++; console.error(`FAIL ${name}: density vs density() ${v} ${d.densR[k]}`); } });
  if (x.length > 10 && x.length <= N.BAND_MAX) {
    const m = d.m, s = d.s, ks = N.qqBand(x.length, "ks");
    ks.lo.forEach((z, k) => { const w = inf(d.ksLo[k]); if (Number.isFinite(w)) near(m + s * z, w, `${name}: KS band lo ${k}`); else eq(z, -Infinity, `${name}: KS band lo ${k} infinite`); });
    ks.hi.forEach((z, k) => { const w = inf(d.ksHi[k]); if (Number.isFinite(w)) near(m + s * z, w, `${name}: KS band hi ${k}`); else eq(z, Infinity, `${name}: KS band hi ${k} infinite`); });
  }
}
for (const c of REF3.sw) { const r = N.shapiroWilk(c.x); near(r.w, c.W, `Shapiro–Wilk n = ${c.x.length}: W`); near(r.p, c.p, `Shapiro–Wilk n = ${c.x.length}: p`, 1e-7); }
// Tail-sensitive band from the table: the same qbeta limits as in R for the same γ.
for (const [n, bnd] of Object.entries(REF3.bands)) {
  const ts = N.qqBand(Number(n), "ts");
  near(ts.gamma, bnd.gamma, `ts band n = ${n}: γ`, 1e-12);
  ts.lo.forEach((z, k) => near(z, bnd.lo[k], `ts band n = ${n}: lo ${k}`, 1e-8));
  ts.hi.forEach((z, k) => near(z, bnd.hi[k], `ts band n = ${n}: hi ${k}`, 1e-8));
}
for (const c of Object.values(REF3.coverage)) {
  checks++;
  if (!(Math.abs(c.ts - 0.95) <= 0.012)) { failures++; console.error(`FAIL ts band coverage n = ${c.n}: ${c.ts}`); }
  console.log(`n = ${c.n}: simultaneous coverage of the tail-sensitive band ${c.ts}, KS band ${c.ks} (m and s estimated)`);
}

console.log(`${checks} checks, ${failures} failures`);
if (failures) process.exit(1);
