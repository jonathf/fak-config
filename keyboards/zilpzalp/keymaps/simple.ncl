let { tap, hold, td, combo, .. } = import "fak/keycode.ncl" in

let kc = tap.reg.kc in
let md = hold.reg.mod in
let _ = tap.none & hold.none in
let trans = tap.trans & hold.trans in
let MO = hold.reg.layer in
let me = tap.custom.media in

{
  virtual_keys = [
    combo.make 50 [0, 1],
  ],
  layers = [
    [
    # physical
            kc.W, kc.E, kc.R, kc.T, kc.Y, kc.U, kc.I, kc.O,
      kc.A, kc.S, kc.D, kc.F, kc.G, kc.H, kc.J, kc.K, kc.L, kc.P,
            kc.C, kc.V, kc.B,             kc.N, kc.M, kc.DOT,
                tap.none, tap.none, tap.none, tap.none,

    # combo
    tap.none,
    ]
  ]
}
