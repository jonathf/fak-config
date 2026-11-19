#    0  1  2  3   4  5  6  7
# 8  9 10 11 12  13 14 15 16 17
#   18 19 20        21 22 23

let { tap, hold, .. } = import "fak/keycode.ncl" in
let util = import "fak/util_functions.ncl" in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let me = tap.custom.media in
let XXXX = tap.none & hold.none in
let trans = tap.trans & hold.trans in

  # FUN = [
  #           XXXX,    XXXX,    XXXX,    XXXX,        kc.F12,  kc.F7,   kc.F8,   kc.F9,
  #           XXXX,    XXXX,    XXXX,    XXXX,        kc.F11,  kc.F4,   kc.F5,   kc.F6,
  #  XXXX,    XXXX,    XXXX,    XXXX,                          kc.F1,   kc.F2,   kc.F3,   kc.F10,
  #                             XXXX,    XXXX,        XXXX,    XXXX,
  # ],

let both_side_combos = [
  # Caps word combo here once supported
  [kc.ralt, 17, 24],
  [kc.lalt, 18, 23],
  [kc.lctl, 19, 22],
  [kc.lsft, 20, 21],
  [kc.lgui, 11, 12],
] in
{
  qwerty = {
    base_layout = "WERTYUIOASDFGHJKLPCVBNM.",
    combos = [
      [kc.Q,    0,  1],
      [kc.X,    1,  2],
      [kc.INS,  5,  6],
      [kc.DEL,  6,  7],
      [kc.ESC,  9, 10],
      [kc.TAB, 10, 11],
      [kc.ENT, 14, 15],
      [kc.BSPC,15, 16],
      [kc.Z,   18, 19],
      [kc.W & tm.ralt, 19, 20],
      [kc.Z & tm.ralt, 21, 22],
      [kc.L & tm.ralt, 22, 23]
    ] @ both_side_combos,
    layers = {
      SYM = [
                kc.GRV,  ks.DQUO, kc.DOT,  kc.LBRC,     kc.RBRC, kc.BSLS, ks.PIPE, kc.SLSH,
                ks.AT,   ks.HASH, ks.DLR,  ks.LPRN,     ks.RPRN, ks.AMPR, ks.ASTR, ks.PERC,
      ks.EXLM, ks.TILD, kc.QUOT, ks.UNDS,                       kc.MINS, ks.PLUS, kc.EQL,  kc.TAB,
                                  ks.LCBR, ks.RCBR,     XXXX,    XXXX,
      ],
      NUM  = [
               kc.AT,   kc.LCBR, kc.RCBR, kc.EQUAL,    ks.PLUS, kc.N7,   kc.N8,   kc.N9,
               kc.DQUO, kc.LPRN, kc.RPRN, kc.DLR,      kc.MINS, kc.N4,   kc.N5,   kc.N6,
      kc.COMM, tm.CARE, kc.LBCR, kc.RBCR,                       kc.N1,   kc.N2,   kc.N3,   kc.N0,
                                  XXXX,    XXXX,        XXXX,    XXXX,
      ],
      # NUM  = [
      #          kc.HASH, tm.ralt & kc.N7, tm.ralt & kc.N0, tm.lsft & kc.N0, ks.MINS, kc.N7,   kc.N8,   kc.N9,
      #          md.lalt, md.lgui, md.lsft, XXXX,        kc.MINS, kc.N4,   kc.N5,   kc.N6,
      # md.lctl, XXXX,    XXXX,    XXXX,                          kc.N1,   kc.N2,   kc.N3,   kc.N0,
      #                             XXXX,    XXXX,        XXXX,    XXXX,
      # ],
      NAV  = [
                XXXX,    XXXX,    XXXX,    me.VOLD,     me.VOLU, kc.BSPC, kc.DEL,  kc.INS,
                md.lalt, md.lgui, md.lsft, me.MUTE,     kc.LEFT, kc.DOWN, kc.UP,   kc.RGHT,
      md.lctl, XXXX,    XXXX,    XXXX,                          kc.HOME, XXXX,    kc.END,  kc.TAB,
                                  XXXX,    XXXX,        XXXX,    XXXX,
      ],
    }
}
