let { tap, hold, td, combo, .. } = import "fak/keycode.ncl" in

let kc = tap.reg.kc in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let _ = tap.none & hold.none in
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

{
  virtual_keys = combos |> std.array.map (fun c =>
    combo.make 50 (std.array.split_at 1 c).right),
  layers = [
    [
            kc.W, kc.E, kc.R, kc.T, kc.Y, kc.U, kc.I, kc.O,
      kc.A, kc.S, kc.D, kc.F, kc.G, kc.H, kc.J, kc.K, kc.L, kc.P,
            kc.C, kc.V, kc.B,             kc.N, kc.M, kc.DOT,
                tap.none, tap.none, tap.none, tap.none,
    ] @ (combos |> std.array.map std.array.first)
  ]
}
