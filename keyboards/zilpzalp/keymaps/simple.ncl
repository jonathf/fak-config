let {
  tap, hold, td, combo, macro, ..
} = import "fak/keycode.ncl" in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let trans = tap.trans & hold.trans in
let none = tap.none & hold.none in
let MO = hold.reg.layer in
let me = tap.custom.media in

let c = {
  A = md.ralt & kc.A & hold.reg.behavior {},
  C = md.lalt & kc.C & hold.reg.behavior {},
  V = md.lctl & kc.V & hold.reg.behavior {},
  B = hold.reg.layer 1 & kc.B & hold.reg.behavior {},
  G = md.lgui & kc.G & hold.reg.behavior {},
  H = md.lgui & kc.H & hold.reg.behavior {},
  N = hold.reg.layer 1 & kc.N & hold.reg.behavior {},
  M = md.lctl & kc.M & hold.reg.behavior {},
  DOT = md.lalt & kc.DOT & hold.reg.behavior {},
  P = md.ralt & kc.P & hold.reg.behavior {},
} in

let combos = [
  [kc.Q,    0,  1],
  [kc.X,    1,  2],
  [kc.INS,  5,  6],
  [kc.DEL,  6,  7],
  [kc.ESC,  9, 10],
  [kc.TAB, 10, 11],
  [kc.ENT, 14, 15],
  [kc.BSPC,15, 16],
  [kc.Z,   18, 19],
  [tm.ralt & kc.W, 19, 20],
  [tm.ralt & kc.Z, 21, 22],
  [tm.ralt & kc.L, 22, 23],
] in

let thumbs = [
  tap.custom.fak.CWTG & hold.reg.layer 0 & md.lgui & md.lctl & md.lalt & hold.reg.behavior {},
  kc.SPC & hold.reg.layer 4 & hold.reg.behavior {},
  tap.sticky.layer 2 & hold.reg.layer 2 & hold.reg.behavior {},
  tap.sticky.layer 3 & hold.reg.layer 3 & hold.reg.behavior {},
] in

{
  virtual_keys = combos |> std.array.map (fun c =>
    combo.make 50 (std.array.split_at 1 c).right),
  layers = [
    [
            kc.W, kc.E, kc.R, kc.T, kc.Y, kc.U, kc.I, kc.O,
       c.A, kc.S, kc.D, kc.F, c.G,  c.H,  kc.J, kc.K, kc.L, kc.P,
            c.C,  c.V,  c.B,              c.N,  c.M,  c.DOT,
    ],
    [
                      tm.lsft & kc.W, tm.lsft & kc.E, tm.lsft & kc.R, tm.lsft & kc.T, tm.lsft & kc.Y, tm.lsft & kc.U, tm.lsft & kc.I, tm.lsft & kc.O,
      tm.lsft & kc.A, tm.lsft & kc.S, tm.lsft & kc.D, tm.lsft & kc.F, tm.lsft & kc.G, tm.lsft & kc.H, tm.lsft & kc.J, tm.lsft & kc.K, tm.lsft & kc.L, tm.lsft & kc.P,
                      tm.lsft & kc.C, tm.lsft & kc.V, tm.lsft & kc.B,                                 tm.lsft & kc.N, tm.lsft & kc.M, kc.SCLN,
    ],
    [
                ks.AT,    ks.LCBR, ks.RCBR, kc.EQUAL, tm.lsft & kc.EQUAL, kc.N7, kc.N8, kc.N9,
      kc.COMMA, ks.DQUO,  ks.LPRN, ks.RPRN, ks.DLR,   kc.MINUS,           kc.N4, kc.N5, kc.N6, kc.N0,
                ks.CIRC,  kc.LBRC, kc.RBRC,                               kc.N1, kc.N2, kc.N3,
    ],
    [
                ks.EXLM,  tm.ralt & kc.LBRC, tm.ralt & kc.RBRC, ks.QUES, kc.HOME, kc.PGDN, kc.PGUP, kc.END,
       kc.SCLN, kc.QUOT,  ks.LABK, ks.RABK, ks.AMPR, kc.LEFT, kc.DOWN, kc.UP, kc.RIGHT, none,
                ks.TILD,  kc.GRV, macro.make [ macro.tap (tm.ralt & kc.QUOT), macro.tap (tm.ralt & kc.QUOT) ], none, none, none,
    ],
    [
                ks.HASH, tm.ralt & kc.N5, none, none, none, none, none, none,
          none, ks.ASTR, kc.BSLS, kc.SLSH, ks.UNDS, none, none, none, none, tm.ralt & kc.QUOT,
          ks.PERC, ks.PIPE, tm.ralt & kc.QUOT, none, none, none
    ],
  ] |> std.array.map (fun c => c @ thumbs @ (combos |> std.array.map std.array.first)),
}
