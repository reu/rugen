;-| Super Motions |--------------------------------------------------------

[Command]
name = "qcb2p"
command = ~D, DB, B, D, DB, B, x
time = 40

[Command]
name = "qcb2p"
command = ~D, DB, B, D, DB, B, y
time = 40

[Command]
name = "qcf2p"
command = ~D, DF, F, D, DF, F, x
time = 40

[Command]
name = "qcf2p"
command = ~D, DF, F, D, DF, F, y
time = 40

[Command]
name = "qcf2x"
command = ~D, DF, F, D, DF, F, x
time = 40

[Command]
name = "qcf2y"
command = ~D, DF, F, D, DF, F, y
time = 40

[Command]
name = "qcbhcfx"
command = ~D, DB, B, DB, D, DF, F, x
time = 50

[Command]
name = "qcbhcfy"
command = ~D, DB, B, DB, D, DF, F, y
time = 50

[Command]
name = "qcb2k"
command = ~D, DB, B, D, DB, B, a
time = 40

[Command]
name = "qcb2k"
command = ~D, DB, B, D, DB, B, b
time = 40

[Command]
name = "qcb2a"
command = ~D, DB, B, D, DB, B, a
time = 40

[Command]
name = "qcb2b"
command = ~D, DB, B, D, DB, B, b
time = 40

;-| Special Motions |------------------------------------------------------

[Command]
name = "qcf_x"
command = ~D, DF, F, x
time = 15

[Command]
name = "qcf_y"
command = ~D, DF, F, y
time = 15

[Command]
name = "qcf_a"
command = ~D, DF, F, a
time = 15

[Command]
name = "qcf_b"
command = ~D, DF, F, b
time = 15

[Command]
name = "dp_a"
command = ~F, D, DF, a
time = 20

[Command]
name = "dp_b"
command = ~F, D, DF, b
time = 20

[Command]
name = "qcb_x"
command = ~D, DB, B, x
time = 15

[Command]
name = "qcb_y"
command = ~D, DB, B, y
time = 15

[Command]
name = "dp_x"
command = ~F, D, DF, x
time = 20

[Command]
name = "dp_y"
command = ~F, D, DF, y
time = 20

[Command]
name = "hcb_x"
command = ~F, DF, D, DB, B, x
time = 30

[Command]
name = "hcb_y"
command = ~F, DF, D, DB, B, y
time = 30

[Command]
name = "hcb_a"
command = ~F, DF, D, DB, B, a
time = 30

[Command]
name = "hcb_b"
command = ~F, DF, D, DB, B, b
time = 30

[Command]
name = "hcf_a"
command = ~B, DB, D, DF, F, a
time = 30

[Command]
name = "hcf_b"
command = ~B, DB, D, DF, F, b
time = 30

[Command]
name = "longjump"
command = ~D, $U
time = 5

;-| Double Tap |-----------------------------------------------------------

[Command]
name = "FF"
command = F, F
time = 10

[Command]
name = "BB"
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------

[Command]
name = "recovery"
command = x+y
time = 1

[Command]
name = "dodge"
command = x+a
time = 1

[Command]
name = "knockdown"
command = y+b
time = 1

[Command]
name = "abc"
command = a+b+c
time = 1

;-| Dir + Button |---------------------------------------------------------

[Command]
name = "fwd_x"
command = /F,x

[Command]
name = "fwd_a"
command = /F,a
time = 1

[Command]
name = "df_y"
command = /DF, y
time = 1

[Command]
name = "df_a"
command = /DF, a
time = 1

;-| Single Button |---------------------------------------------------------

[Command]
name = "a"
command = a
time = 1

[Command]
name = "hold_a"
command = /a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "hold_b"
command = /b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "hold_x"
command = /x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "hold_y"
command = /y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "s"
command = s
time = 1

;-| Hold Dir |--------------------------------------------------------------

[Command]
name = "holdfwd"
command = /$F
time = 1

[Command]
name = "holdback"
command = /$B
time = 1

[Command]
name = "holdup"
command = /$U
time = 1

[Command]
name = "holddown"
command = /$D
time = 1

;-|Commands|------------------------------------------------------------------------------

[Statedef -1]

; --------[Orochi]--------

; SDM Daichi o harau gouka
[State -1]
type = ChangeState
value = 8050
triggerall = Var(4) && ((command = "qcf2p" && power >= 1000 && life <= 150) || (command = "qcf2y" && power >= 2000))
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; DM Daichi o harau gouka
[State -1]
type = ChangeState
value = 8000
triggerall = Var(4) && command = "qcf2p" && (life <= 150 || power >= 1000)
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; SDM Ankoku orochi nagi (hold x)
[State -1]
type = ChangeState
value = 8150
triggerall = Var(4) && command = "qcbhcfx" && power >= 1000 && life <= 150
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; SDM Ankoku orochi nagi (hold y)
[State -1]
type = ChangeState
value = 8155
triggerall = Var(4) && command = "qcbhcfy" && ((power >= 1000 && life <= 150) || power >= 2000)
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; DM Ankoku orochi nagi (hold x)
[State -1]
type = ChangeState
value = 8100
triggerall = Var(4) && command = "qcbhcfx" && (life <= 150 || power >= 1000)
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; DM Ankoku orochi nagi (hold y)
[State -1]
type = ChangeState
value = 8105
triggerall = Var(4) && command = "qcbhcfy" && (life <= 150 || power >= 1000)
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; Light Tsuki o tsumu honoo
[State -1]
type = ChangeState
value = 7200
triggerall = Var(4) && command = "dp_x"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; Hard Tsuki o tsumu honoo
[State -1]
type = ChangeState
value = 7250
triggerall = Var(4) && command = "dp_y"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; Light Taiyou o iru honoo
[State -1]
type = ChangeState
value = 7000
triggerall = Var(4) && command = "qcf_x"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; Hard Taiyou o iru honoo
[State -1]
type = ChangeState
value = 7010
triggerall = Var(4) && command = "qcf_y"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; Light Kagami o hofuru honoo
[State -1]
type = ChangeState
value = 7100
triggerall = Var(4) && command = "qcb_x"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; Hard Kagami o hofuru honoo
[State -1]
type = ChangeState
value = 7150
triggerall = Var(4) && command = "qcb_y"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450
trigger11 = AnimElem = 42, >= 0 && AnimElem = 44, < 0 && stateno = 7300 && MoveHit
trigger12 = AnimElem = 36, >= 0 && AnimElem = 37, <= 2 && stateno = 7350 && MoveHit

; Light Shishi o kamu honoo
[State -1]
type = ChangeState
value = 7300
triggerall = Var(4) && command = "hcf_a" && P2bodydist X <= 30 && P2statetype != A
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Hard Shishi o kamu honoo
[State -1]
type = ChangeState
value = 7350
triggerall = Var(4) && command = "hcf_b" && P2bodydist X <= 30 && P2statetype != A
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; --------[Regular]--------

; Orochi no chikara o mezameru
[State -1]
type = ChangeState
value = 2000
trigger1 = command = "qcb2p" && power >= 2000 && Var(4) = 0 && statetype != A && ctrl

; SDM Twister drive
[State -1]
type = ChangeState
value = 2150
triggerall = Var(4) = 0 && ((command = "qcb2k" && power >= 1000 && life <= 150) || (command = "qcb2b" && power >= 2000))
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; DM Twister drive
[State -1]
type = ChangeState
value = 2100
triggerall = Var(4) = 0 && command = "qcb2k" && (life <= 150 || power >= 1000)
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; SDM Chain slide touch
[State -1]
type = ChangeState
value = 2250
triggerall = Var(4) = 0 && ((command = "qcf2p" && power >= 1000 && life <= 150) || (command = "qcf2y" && power >= 2000))
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; DM Chain slide touch
[State -1]
type = ChangeState
value = 2200
triggerall = Var(4) = 0 && command = "qcf2p" && (life <= 150 || power >= 1000)
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Light Hunting air
[State -1]
type = ChangeState
value = 1100
triggerall = Var(4) = 0 && command = "dp_a"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Hard Hunting air
[State -1]
type = ChangeState
value = 1150
triggerall = Var(4) = 0 && command = "dp_b"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Light scramble dash
[State -1]
type = ChangeState
value = 1000
triggerall = Var(4) = 0 && command = "qcf_a"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Hard scramble dash
[State -1]
type = ChangeState
value = 1050
triggerall = Var(4) = 0 && command = "qcf_b"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Light Glider stampt
[State -1]
type = ChangeState
value = 1200
triggerall = Var(4) = 0 && command = "qcf_a"
trigger1 = statetype = A && ctrl
trigger2 = stateno = 1630 || stateno = 1680

; Hard Glider stamp
[State -1]
type = ChangeState
value = 1250
triggerall = Var(4) = 0 && command = "qcf_b"
trigger1 = statetype = A && ctrl
trigger2 = stateno = 1630 || stateno = 1680

; Light Direction change
[State -1]
type = ChangeState
value = 1500
triggerall = Var(4) = 0 && command = "dp_x"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Hard Direction change
[State -1]
type = ChangeState
value = 1550
triggerall = Var(4) = 0 && command = "dp_y"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Light Slide touch
[State -1]
type = ChangeState
value = 1300
triggerall = Var(4) = 0 && command = "qcf_x"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Hard Slide touch
[State -1]
type = ChangeState
value = 1350
triggerall = Var(4) = 0 && command = "qcf_y"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Light Shooting dancer thrust
[State -1]
type = ChangeState
value = 1400
triggerall = Var(4) = 0 && command = "hcb_x"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Hard Shooting dancer thrust
[State -1]
type = ChangeState
value = 1450
triggerall = Var(4) = 0 && command = "hcb_y"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Light Shooting dancer step
[State -1]
type = ChangeState
value = 1600
triggerall = Var(4) = 0 && command = "hcb_a"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Hard Shooting dancer step
[State -1]
type = ChangeState
value = 1650
triggerall = Var(4) = 0 && command = "hcb_b"
trigger1 = statetype != A && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 6, >= 0 && AnimElem = 8, < 0 && stateno = 210 && MoveContact
trigger4 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger5 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger6 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger7 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger8 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger9 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger10 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; ---------[Both]---------

; Standing knockdown attack
[State -1]
type = ChangeState
value = 280
triggerall = command = "knockdown" ^^ command = "c"
trigger1 = statetype = S && ctrl
trigger2 = (stateno = 150 || stateno = 152) && power >= 500

; Slide forward
[State -1]
type = ChangeState
value = 750
triggerall = command = "dodge" ^^ command = "z"
trigger1 = command = "holdfwd" && statetype = S && ctrl
trigger2 = (stateno = 150 || stateno = 152) && command != "holdback" && power >= 500

; Slide backwards
[State -1]
type = ChangeState
value = 775
triggerall = command = "dodge" ^^ command = "z"
trigger1 = command = "holdback" && statetype = S && ctrl
trigger2 = (stateno = 150 || stateno = 152) && power >= 500

; Dodge
[State -1]
type = ChangeState
value = 725
trigger1 = command = "dodge" ^^ command = "z"
trigger1 = statetype = S && ctrl

; Spinning array
[State -1]
type = ChangeState
value = 210
triggerall = command = "fwd_x"
trigger1 = statetype = S && command != "holddown" && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger4 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger5 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger6 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger7 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger8 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger9 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Standing light punch
[State -1]
type = ChangeState
value = 200
triggerall = command = "x" && command != "holddown"
trigger1 = statetype = S && ctrl
trigger2 = stateno = 200 && AnimElem = 6, >= 0
trigger3 = stateno = 420 && AnimElem = 4, >= 1 && AnimElem = 5, < 1

; Reverse anchor kick
[State -1]
type = ChangeState
value = 230
triggerall = command = "fwd_a"
trigger1 = statetype = S && command != "holddown" && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger4 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger5 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger6 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger7 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger8 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger9 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Close standing light kick
[State -1]
type = ChangeState
value = 225
triggerall = command = "a" && command != "holddown" && P2bodydist X <= 42
trigger1 = statetype = S && ctrl
trigger2 = stateno = 200 && AnimElem = 6, >= 0
trigger3 = stateno = 420 && AnimElem = 4, >= 1 && AnimElem = 5, < 1

; Standing light kick
[State -1]
type = ChangeState
value = 220
triggerall = command = "a" && command != "holddown"
trigger1 = statetype = S && ctrl
trigger2 = stateno = 200 && AnimElem = 6, >= 0
trigger3 = stateno = 420 && AnimElem = 4, >= 1 && AnimElem = 5, < 1

; Step turn
[State -1]
type = ChangeState
value = 800
trigger1 = command = "holdfwd" && command = "y" && statetype = S && stateno != 100 && P2bodydist X <= 10 && P2movetype != H && ctrl

; Close standing hard punch
[State -1]
type = ChangeState
value = 245
trigger1 = command = "y" && statetype = S && P2bodydist X <= 36 && ctrl

; Standing hard punch
[State -1]
type = ChangeState
value = 240
trigger1 = command = "y" && statetype = S && command != "holddown" && ctrl

; Aerial drop
[State -1]
type = ChangeState
value = 850
trigger1 = command = "holdfwd" && command = "b" && statetype = S && stateno != 100 && P2bodydist X <= 10 && P2movetype != H && ctrl

; Close standing hard kick
[State -1]
type = ChangeState
value = 265
trigger1 = command = "b" && statetype = S && P2bodydist X <= 37 && ctrl

; Standing hard kick
[State -1]
type = ChangeState
value = 260
trigger1 = command = "b" && statetype = S && command != "holddown" && ctrl

; Crouching light punch
[State -1]
type = ChangeState
value = 400
triggerall = command = "x"
trigger1 = statetype = C && ctrl
trigger2 = stateno = 200 && AnimElem = 6, >= 0
trigger3 = stateno = 420 && AnimElem = 4, >= 1 && AnimElem = 5, < 1

; Carry off kick
[State -1]
type = ChangeState
value = 425
triggerall = command = "df_a"
trigger1 = statetype = C && ctrl
trigger2 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 200
trigger3 = AnimElem = 4, >= 0 && AnimElem = 7, < 0 && stateno = 225
trigger4 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 240
trigger5 = AnimElem = 5, >= 0 && AnimElem = 8, < 0 && stateno = 245
trigger6 = AnimElem = 5, >= 0 && AnimElem = 10, < 0 && stateno = 265
trigger7 = AnimElem = 4, >= 0 && AnimElem = 6, < 0 && stateno = 400
trigger8 = AnimElem = 4, >= 0 && AnimElem = 5, < 0 && stateno = 440
trigger9 = AnimElem = 5, >= 0 && AnimElem = 7, < 0 && stateno = 450

; Crouching light kick
[State -1]
type = ChangeState
value = 420
triggerall = command = "a"
trigger1 = statetype = C && ctrl
trigger2 = stateno = 200 && AnimElem = 6, >= 0
trigger3 = stateno = 420 && AnimElem = 4, >= 1 && AnimElem = 5, < 1

; Crouching forward hard punch
[State -1]
type = ChangeState
value = 450
trigger1 = command = "df_y" && statetype = C && ctrl

; Crouching hard punch
[State -1]
type = ChangeState
value = 440
trigger1 = command = "y" && statetype = C && ctrl

; Crouching hard kick
[State -1]
type = ChangeState
value = 460
trigger1 = command = "b" && statetype = C && ctrl

; Jumping knockdown attack
[State -1]
type = ChangeState
value = 680
trigger1 = statetype = A && ctrl
trigger1 = command = "knockdown" || command = "c"

; Jumping light punch
[State -1]
type = ChangeState
value = 600
trigger1 = stateno != 950
trigger1 = command = "x" && statetype = A && Vel X = 0 && ctrl

; Diagonal jumping light punch
[State -1]
type = ChangeState
value = 610
trigger1 = command = "x" && statetype = A && ctrl

; Jumping light kick
[State -1]
type = ChangeState
value = 620
trigger1 = stateno != 950
trigger1 = command = "a" && statetype = A && Vel X = 0 && ctrl

; Diagonal jumping light kick
[State -1]
type = ChangeState
value = 630
trigger1 = command = "a" && statetype = A && ctrl

; Jumping hard punch
[State -1]
type = ChangeState
value = 640
trigger1 = stateno != 950
trigger1 = command = "y" && statetype = A && Vel X = 0 && ctrl

; Diagonal jumping hard punch
[State -1]
type = ChangeState
value = 650
trigger1 = command = "y" && statetype = A && ctrl

; Jumping hard kick
[State -1]
type = ChangeState
value = 660
trigger1 = stateno != 950
trigger1 = command = "b" && statetype = A && Vel X = 0 && ctrl

; Diagonal jumping hard kick
[State -1]
type = ChangeState
value = 670
trigger1 = command = "b" && statetype = A && ctrl

; Power charge
[State -1]
type = ChangeState
value = 700
trigger1 = command = "hold_x" && command = "hold_a" && command = "hold_y"
trigger1 = power < 3000 && statetype = S && ctrl

; Taunt
[State -1]
type = ChangeState
value = IfElse((Var(4) = 0),195,6195)
trigger1 = command = "s" && statetype = S && ctrl
trigger1 = stateno != 195 && stateno != 196 && stateno != 6195 && stateno != 6196

; Run Forward
[State -1]
type = ChangeState
value = 100
trigger1 = command = "FF" && command != "holddown"
trigger1 = statetype = S && ctrl

; Run Backwards
[State -1]
type = ChangeState
value = 105
trigger1 = command = "BB" && command != "holddown"
trigger1 = statetype = S && ctrl