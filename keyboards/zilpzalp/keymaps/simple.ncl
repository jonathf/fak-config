let {
  tap, hold, td, combo, macro, ..
} = import "fak/keycode.ncl" in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let none = tap.none & hold.none in

let taps = fun c => macro.make (c |> std.array.map (fun tap => macro.tap tap)) in
let exit = fun c => taps [tap.layer.TO 0, c] in
let behavior = hold.reg.behavior {
  timeout_ms = 200,
  quick_tap_ms = 100,
  #key_interrupts = [
  #  { decision = 'hold, trigger_on = 'release },
  #],
} in

let c = {
  A = md.ralt & kc.A & behavior,
  B = hold.reg.layer 7 & kc.B & behavior,
  C = md.lalt & kc.C & behavior,
  DOT = md.lalt & kc.DOT & behavior,
  E = hold.reg.layer 4 & kc.E & behavior,
  G = md.lgui & kc.G & behavior,
  H = md.lgui & kc.H & behavior,
  M = md.lctl & kc.M & behavior,
  N = hold.reg.layer 7 & kc.N & behavior,
  O = hold.reg.layer 6 & kc.O & behavior,
  P = md.ralt & kc.P & behavior,
  R = hold.reg.layer 5 & kc.R & behavior,
  V = md.lctl & kc.V & behavior,
  W = hold.reg.layer 3 & kc.W & behavior,
} in

let alpha_combos = [
  [kc.Q,    0,  1],
  [kc.X,    1,  2],
  [kc.Z,   18, 19],
  [tm.ralt & kc.W, 19, 20],
  [tm.ralt & kc.Z, 21, 22],
  [tm.ralt & kc.L, 22, 23],
] in
let cmd_combos = [
  [kc.INS,  5,  6],
  [kc.DEL,  6,  7],
  [kc.ESC,  9, 10],
  [kc.TAB, 10, 11],
  [kc.ENT, 14, 15],
  [kc.BSPC,15, 16],
] in
let combos = (alpha_combos @ cmd_combos) |> std.array.map std.array.first in
let sft_combos = (
  alpha_combos |> std.array.map std.array.first |> std.array.map (fun c => tm.lsft & c)
) @ (
  cmd_combos |> std.array.map std.array.first |> std.array.map (fun c => exit (tm.lsft & c))
) in

let thumbs = [
  tap.layer.TO 7 & hold.reg.layer 0 & md.lgui & md.lctl & md.lalt & hold.reg.behavior {},
  kc.SPC & hold.reg.layer 1 & hold.reg.behavior {},
  tap.sticky.layer 2 & hold.reg.layer 2 & hold.reg.behavior {},
  tap.sticky.layer 3 & hold.reg.layer 3 & hold.reg.behavior {},
] in

let sft_thumbs = [
  exit (hold.reg.layer 0 & md.lgui & md.lctl & md.lalt & hold.reg.behavior {}),
  tap.sticky.layer 8 & hold.reg.layer 8 & hold.reg.behavior {},
  tap.sticky.layer 9 & hold.reg.layer 9 & hold.reg.behavior {},
  tap.sticky.layer 10 & hold.reg.layer 10 & hold.reg.behavior {},
] in

{
  virtual_keys = (alpha_combos @ cmd_combos) |> std.array.map (fun c =>
    combo.make 30 (std.array.split_at 1 c).right),
  layers = [
    # layer 0
    [
            c.W,  c.E,  kc.R, kc.T, kc.Y, kc.U, kc.I, c.O,
       c.A, kc.S, kc.D, kc.F, c.G,  c.H,  kc.J, kc.K, kc.L, kc.P,
            c.C,  c.V,  c.B,              c.N,  c.M,  c.DOT,
    ] @ thumbs @ combos,
    # layer 1
    [
                ks.HASH, tm.ralt & kc.N5, none, none, none, none, none, none,
          none, ks.ASTR, kc.BSLS, kc.SLSH, ks.UNDS, none, none, none, none, tm.ralt & kc.SCLN,
          ks.PERC, ks.PIPE, tm.ralt & kc.QUOT, none, none, none
    ] @ thumbs @ combos,
    # layer 2
    [
                ks.AT,    ks.LCBR, ks.RCBR, kc.EQUAL, tm.lsft & kc.EQUAL, kc.N7, kc.N8, kc.N9,
      kc.COMMA, ks.DQUO,  ks.LPRN, ks.RPRN, ks.DLR,   kc.MINUS,           kc.N4, kc.N5, kc.N6, kc.N0,
                ks.CIRC,  kc.LBRC, kc.RBRC,                               kc.N1, kc.N2, kc.N3,
    ] @ thumbs @ combos,
    # layer 3
    [
                ks.EXLM,  tm.ralt & kc.LBRC, tm.ralt & kc.RBRC, ks.QUES, kc.HOME, kc.PGDN, kc.PGUP, kc.END,
       kc.SCLN, kc.QUOT,  ks.LABK, ks.RABK, ks.AMPR, kc.LEFT, kc.DOWN, kc.UP, kc.RIGHT, none,
                ks.TILD,  kc.GRV, taps [ tm.ralt & kc.QUOT, tm.ralt & kc.QUOT ], none, none, none,
    ] @ thumbs @ combos,
    # layer 4
    [
              none, none, kc.PSCR, none, none, kc.F7, kc.F8, kc.F9,
        none, none, none,    none, none, none, kc.F4, kc.F5, kc.F6, kc.F10,
              none, none,    none,             kc.F1, kc.F2, kc.F3,
    ] @ thumbs @ combos,
    # layer 5
    [
              none, none, none, none, none, kc.F17, kc.F18, kc.F19,
        none, none, none, none, none, none, kc.F14, kc.F15, kc.F16, kc.F20,
              none, none, none,             kc.F11, kc.F12, kc.F13,
    ] @ thumbs @ combos,
    # layer 6
    [
              none, none, none, none, none, none, none, none,
        none, kc.KB_MUTE, kc.KB_VOLUME_DOWN, kc.KB_VOLUME_UP, tm.lsft & kc.KB_VOLUME_UP,
                      none, none, none, none, none,
              none, none, none,             none, none, none,
    ] @ thumbs @ combos,
    # layer 7
    [
            tm.lsft & kc.W, tm.lsft & kc.E, tm.lsft & kc.R, tm.lsft & kc.T, tm.lsft & kc.Y, tm.lsft & kc.U, tm.lsft & kc.I, tm.lsft & kc.O,
      tm.lsft & kc.A, tm.lsft & kc.S, tm.lsft & kc.D, tm.lsft & kc.F, tm.lsft & kc.G, tm.lsft & kc.H, tm.lsft & kc.J, tm.lsft & kc.K, tm.lsft & kc.L, tm.lsft & kc.P,
                      tm.lsft & kc.C, tm.lsft & kc.V, tm.lsft & kc.B,                                 tm.lsft & kc.N, tm.lsft & kc.M, ks.COLN,
    ] @ sft_thumbs @ sft_combos,
    # layer 8
    [
                exit ks.HASH, exit (tm.ralt & kc.N5), tap.layer.TO 0, tap.layer.TO 0, tap.layer.TO 0, tap.layer.TO 0, tap.layer.TO 0, tap.layer.TO 0,
          tap.layer.TO 0, exit ks.ASTR, exit kc.BSLS, exit kc.SLSH, ks.UNDS, tap.layer.TO 0, tap.layer.TO 0, tap.layer.TO 0, tap.layer.TO 0, exit (tm.ralt & kc.SCLN),
          exit ks.PERC, exit ks.PIPE, exit (tm.ralt & kc.QUOT), tap.layer.TO 0, tap.layer.TO 0, tap.layer.TO 0
    ] @ sft_thumbs @ sft_combos,
    # layer 9
    [
                     exit ks.AT,    exit ks.LCBR, exit ks.RCBR, exit kc.EQUAL, exit (tm.lsft & kc.EQUAL), kc.N7, kc.N8, kc.N9,
      exit kc.COMMA, exit ks.DQUO,  exit ks.LPRN, exit ks.RPRN, exit ks.DLR,   kc.MINUS,                  kc.N4, kc.N5, kc.N6, kc.N0,
                     exit ks.CIRC,  exit kc.LBRC, exit kc.RBRC,                                           kc.N1, kc.N2, kc.N3,
    ] @ sft_thumbs @ sft_combos,
    # layer 10
    [
                  exit ks.EXLM, exit (tm.ralt & kc.LBRC), exit (tm.ralt & kc.RBRC), exit ks.QUES, exit kc.HOME, exit kc.PGDN, exit kc.PGUP, exit kc.END,
    exit kc.SCLN, exit kc.QUOT, exit ks.LABK, exit ks.RABK, exit ks.AMPR, exit kc.LEFT, exit kc.DOWN, exit kc.UP, exit kc.RIGHT, tap.layer.TO 0,
                  exit ks.TILD, exit kc.GRV, taps [ tap.layer.TO 0, tm.ralt & kc.QUOT, tm.ralt & kc.QUOT ], tap.layer.TO 0, tap.layer.TO 0, tap.layer.TO 0,
    ] @ sft_thumbs @ sft_combos,
  ],
}
