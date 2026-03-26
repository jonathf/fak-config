let {
  tap, hold, td, combo, ..
} = import "fak/keycode.ncl" in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let trans = tap.trans & hold.trans in
let MO = hold.reg.layer in
let me = tap.custom.media in

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
  tap.custom.fak.CWTG,
  kc.SPC & hold.reg.layer 0 & md.lgui & md.lctl & md.lalt & hold.reg.behavior {},
  tap.sticky.layer 2 & hold.reg.layer 2 & hold.reg.behavior {},
  tap.sticky.layer 2 & hold.reg.layer 2 & hold.reg.behavior {},
] in

{
  virtual_keys = combos |> std.array.map (fun c =>
    combo.make 50 (std.array.split_at 1 c).right),
  layers = [
    [
            kc.W, kc.E, kc.R, kc.T, kc.Y, kc.U, kc.I, kc.O,
      kc.A, kc.S, kc.D, kc.F, kc.G, kc.H, kc.J, kc.K, kc.L, kc.P,
            kc.C, kc.V, kc.B,             kc.N, kc.M, kc.DOT,
    ],
    [
                      tm.lsft & kc.W, tm.lsft & kc.E, tm.lsft & kc.R, tm.lsft & kc.T, tm.lsft & kc.Y, tm.lsft & kc.U, tm.lsft & kc.I, tm.lsft & kc.O,
      tm.lsft & kc.A, tm.lsft & kc.S, tm.lsft & kc.D, tm.lsft & kc.F, tm.lsft & kc.G, tm.lsft & kc.H, tm.lsft & kc.J, tm.lsft & kc.K, tm.lsft & kc.L, tm.lsft & kc.P,
                      tm.lsft & kc.C, tm.lsft & kc.V, tm.lsft & kc.B,                                 tm.lsft & kc.N, tm.lsft & kc.M, kc.SCLN,
    ],
    [
                ks.AT,    ks.LCBR, ks.RCBR, kc.EQUAL, tm.lsft & kc.EQUAL, kc.N7, kc.N8, kc.N9,
      kc.COMMA, ks.DQUO,  ks.LPRN, ks.RPRN, ks.DLR,   kc.MINUS, kc.N4, kc.N5, kc.N6, kc.N0,
                ks.CIRC,  kc.LBRC, kc.RBRC,                     kc.N1, kc.N2, kc.N3,
    ],
  ] |> std.array.map (fun c => c @ thumbs @ (combos |> std.array.map std.array.first)),
}
