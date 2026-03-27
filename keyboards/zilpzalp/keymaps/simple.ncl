let {
  tap, hold, td, combo, macro, ..
} = import "fak/keycode.ncl" in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let none = tap.none & hold.none in

let taps = fun c => macro.make (c |> std.array.map (fun tap => macro.tap tap)) in
let behavior = hold.reg.behavior {
  timeout_ms = 200,
  quick_tap_ms = 100,
  #key_interrupts = [
  #  { decision = 'hold, trigger_on = 'release },
  #],
} in

let c = {
  A = md.ralt & kc.A & behavior,
  B = hold.reg.layer 1 & kc.B & behavior,
  C = md.lalt & kc.C & behavior,
  DOT = md.lalt & kc.DOT & behavior,
  E = hold.reg.layer 5 & kc.E & behavior,
  G = md.lgui & kc.G & behavior,
  H = md.lgui & kc.H & behavior,
  M = md.lctl & kc.M & behavior,
  N = hold.reg.layer 1 & kc.N & behavior,
  O = hold.reg.layer 6 & kc.O & behavior,
  P = md.ralt & kc.P & behavior,
  V = md.lctl & kc.V & behavior,
  W = hold.reg.layer 4 & kc.W & behavior,
} in

let rawcombos = [
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
let combos = rawcombos |> std.array.map std.array.first in
let sft_combos = combos |> std.array.map (fun c => (tm.lsft & c)) in

let thumbs = [
  tap.layer.TG 1 & hold.reg.layer 0 & md.lgui & md.lctl & md.lalt & hold.reg.behavior {},
  kc.SPC & hold.reg.layer 4 & hold.reg.behavior {},
  tap.sticky.layer 2 & hold.reg.layer 2 & hold.reg.behavior {},
  tap.sticky.layer 3 & hold.reg.layer 3 & hold.reg.behavior {},
] in

let sft_thumbs = [
  tap.layer.TO 0,
  tap.tlex,
  tap.sticky.layer 7 & hold.reg.layer 7 & hold.reg.behavior {},
  tap.sticky.layer 8 & hold.reg.layer 8 & hold.reg.behavior {},
] in

{
  virtual_keys = rawcombos |> std.array.map (fun c =>
    combo.make 30 (std.array.split_at 1 c).right),
  layers = [
    [
            c.W,  c.E,  kc.R, kc.T, kc.Y, kc.U, kc.I, c.O,
       c.A, kc.S, kc.D, kc.F, c.G,  c.H,  kc.J, kc.K, kc.L, kc.P,
            c.C,  c.V,  c.B,              c.N,  c.M,  c.DOT,
    ] @ thumbs @ combos,
    [
            tm.lsft & kc.W, tm.lsft & kc.E, tm.lsft & kc.R, tm.lsft & kc.T, tm.lsft & kc.Y, tm.lsft & kc.U, tm.lsft & kc.I, tm.lsft & kc.O,
      tm.lsft & kc.A, tm.lsft & kc.S, tm.lsft & kc.D, tm.lsft & kc.F, tm.lsft & kc.G, tm.lsft & kc.H, tm.lsft & kc.J, tm.lsft & kc.K, tm.lsft & kc.L, tm.lsft & kc.P,
                      tm.lsft & kc.C, tm.lsft & kc.V, tm.lsft & kc.B,                                 tm.lsft & kc.N, tm.lsft & kc.M, ks.COLN,
    ] @ sft_thumbs @ sft_combos,
    [
                ks.AT,    ks.LCBR, ks.RCBR, kc.EQUAL, tm.lsft & kc.EQUAL, kc.N7, kc.N8, kc.N9,
      kc.COMMA, ks.DQUO,  ks.LPRN, ks.RPRN, ks.DLR,   kc.MINUS,           kc.N4, kc.N5, kc.N6, kc.N0,
                ks.CIRC,  kc.LBRC, kc.RBRC,                               kc.N1, kc.N2, kc.N3,
    ] @ thumbs @ combos,
    [
                ks.EXLM,  tm.ralt & kc.LBRC, tm.ralt & kc.RBRC, ks.QUES, kc.HOME, kc.PGDN, kc.PGUP, kc.END,
       kc.SCLN, kc.QUOT,  ks.LABK, ks.RABK, ks.AMPR, kc.LEFT, kc.DOWN, kc.UP, kc.RIGHT, none,
                ks.TILD,  kc.GRV, taps [ tm.ralt & kc.QUOT, tm.ralt & kc.QUOT ], none, none, none,
    ] @ thumbs @ combos,
    [
                ks.HASH, tm.ralt & kc.N5, none, none, none, none, none, none,
          none, ks.ASTR, kc.BSLS, kc.SLSH, ks.UNDS, none, none, none, none, tm.ralt & kc.SCLN,
          ks.PERC, ks.PIPE, tm.ralt & kc.QUOT, none, none, none
    ] @ thumbs @ combos,
    [
              none, kc.PSCR, none, none, none, kc.F7, kc.F8, kc.F9,
        none, none, none,    none, none, none, kc.F4, kc.F5, kc.F6, kc.F10,
              none, none,    none,             kc.F1, kc.F2, kc.F3,
    ] @ thumbs @ combos,
    [
              none, none, none, none, none, kc.F17, kc.F18, kc.F19,
        none, none, none, none, none, none, kc.F14, kc.F15, kc.F16, kc.F20,
              none, none, none,             kc.F11, kc.F12, kc.F13,
    ] @ thumbs @ combos,
    [
              none, none, none, none, none, none, none, none,
        none, kc.KB_MUTE, kc.KB_VOLUME_DOWN, kc.KB_VOLUME_UP, tm.lsft & kc.KB_VOLUME_UP,
                      none, none, none, none, none,
              none, none, none,             none, none, none,
    ] @ thumbs @ combos,
    [
                taps [tap.layer.TO 0, ks.AT], tap.tlex, tap.tlex, tap.tlex, tap.tlex, kc.N7, kc.N8, kc.N9,
      tap.tlex, tap.tlex, tap.tlex, tap.tlex, tap.tlex, kc.MINUS, kc.N4, kc.N5, kc.N6, kc.N0,
                tap.tlex, tap.tlex, tap.tlex,                     kc.N1, kc.N2, kc.N3,
    ] @ sft_thumbs @ sft_combos,
    [
                tap.tlex, tap.tlex, tap.tlex, tap.tlex, tap.tlex, tap.tlex, tap.tlex, tap.tlex,
      tap.tlex, tap.tlex, tap.tlex, tap.tlex, ks.UNDS,  tap.tlex, tap.tlex, tap.tlex, tap.tlex, tap.tlex,
                tap.tlex, tap.tlex, tap.tlex,                     tap.tlex, tap.tlex, tap.tlex,
    ] @ sft_thumbs @ sft_combos,
  ],
}
