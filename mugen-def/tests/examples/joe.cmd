;-| Super Motions |--------------------------------------------------------

[Command]
name = "power_b"
command = ~F, B, DB, D, DF, b
time = 30

[Command]
name = "power_c"
command = ~F, B, DB, D, DF, c
time = 30

[Command]
name = "power_bc"
command = ~F, B, DB, D, DF, b+c
time = 30

;-| Special Motions |------------------------------------------------------

[Command]
name = "qcf_a"
command = ~D, DF, F, a
time = 15

[Command]
name = "qcf_c"
command = ~D, DF, F, c
time = 15

[Command]
name = "qcb_b"
command = ~D, DB, B, b
time = 15

[Command]
name = "hcb_a"
command = ~F, DF, D, DB, B, a
time = 30

[Command]
name = "hcb_c"
command = ~F, DF, D, DB, B, c
time = 30

[Command]
name = "dp_b"
command = ~F, D, DF, b
time = 15

[Command]
name = "dp_c"
command = ~F, D, DF, c
time = 15

[Command]
name = "rapid_a"
command = a, a, a
time = 20

[Command]
name = "slash_b"
command = ~DB, F, b
time = 15

[Command]
name = "slash_c"
command = ~DB, F, c
time = 15

[Command]
name = "fake_a"
command = B, a+b
time = 3

[Command]
name = "fake_b"
command = D, a+b
time = 3

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
name = "brake"
command = x+a
time = 1

[Command]
name = "top"
command = y+b
time = 1

[Command]
name = "abc"
command = a+b+c
time = 1

;-| Dir + Button |---------------------------------------------------------

[Command]
name = "df_c"
command = DF, c

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
name = "hold_c"
command = /c
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
name = "hold_z"
command = /z
time = 1

[Command]
name = "s"
command = s
time = 1

;-| Hold Dir |--------------------------------------------------------------

[Command]
name = "holdfwd_x"
command = /$F, x
time = 1

[Command]
name = "holdfwd_y"
command = /$F, y
time = 1

[Command]
name = "holdfwd"
command = /$F
time = 1

[Command]
name = "back"
command = B
time = 1

[Command]
name = "upback"
command = UB
time = 1

[Command]
name = "downback"
command = DB
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

[State -1]
type = ChangeState
value = 2000
triggerall = command = "power_bc" && power >= 1000
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = ChangeState
value = 2100
triggerall = command = "power_b" && power >= 2000
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = ChangeState
value = 2200
triggerall = command = "power_c" && Power >= 2000
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = ChangeState
value = 1000
triggerall = command = "hcb_a" && NumProjID(1011) = 0
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = ChangeState
value = 1100
triggerall = command = "hcb_c" && NumProjID(1011) = 0
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = ChangeState
value = 1200
triggerall = command = "qcb_b" 
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = ChangeState
value = 1300
triggerall = command = "dp_b"
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = ChangeState
value = 1400
triggerall = command = "dp_c"
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = VarSet
v = 3
value = 1
trigger1 = command = "qcb_b"
trigger1 = stateno = 1410 || (stateno = 1420 && MoveHit = 1)
ignorehitpause = 1

[State -1]
type = ChangeState
value = 1500
triggerall = command = "rapid_a"
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = VarAdd
v = 3
value = 1
triggerall = command = "a"
trigger1 = stateno >= 1500 && stateno <= 1525

[State -1]
type = ChangeState
value = 1550
trigger1 = command = "qcf_a" && stateno >= 1500 && stateno <= 1530

[State -1]
type = ChangeState
value = 1575
trigger1 = command = "qcf_c" && stateno >= 1500 && stateno <= 1530

[State -1]
type = ChangeState
value = 1600
triggerall = command = "slash_b"
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

[State -1]
type = ChangeState
value = 1700
triggerall = command = "slash_c"
trigger1 = statetype != A && ctrl
trigger2 = stateno = 200 && AnimElem = 2, >= 1 && MoveContact
trigger3 = stateno = 205 && AnimElem = 2, >= 1 && MoveContact
trigger4 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger5 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger6 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger7 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger8 = stateno = 265 && AnimElem = 4, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger9 = stateno = 271 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger10 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger11 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0 && MoveContact
trigger12 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger13 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0 && MoveContact
trigger14 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0 && MoveContact
trigger15 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger16 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact
trigger17 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && MoveContact

; Taunt
[State -1]
type = ChangeState
value = 195
trigger1 = command = "c"
trigger1 = Vel X = 0 && p2dist x > 160
trigger1 = statetype = S && ctrl && stateno != 195

; Extra taunt
[State -1]
type = ChangeState
value = 280
triggerall = command = "holddown" && command = "c"
triggerall = p2statetype = L && p2stateno != 5120
trigger1 = (statetype = S && ctrl) || stateno = 10

[State -1]
type = ChangeState
value = 1800
trigger1 = command = "fake_a" && statetype != A && ctrl

[State -1]
type = ChangeState
value = 1850
triggerall = command = "fake_b"
trigger1 = (statetype != A && ctrl) || stateno = 10

[State -1]
type = ChangeState
value = 850
trigger1 = command = "df_c"
trigger1 = p2bodydist x <= 5 && p2statetype != A && p2movetype != H && p2stateno != 5120
trigger1 = (statetype = S && ctrl) || stateno = 10

[State -1]
type = ChangeState
value = 800
trigger1 = command = "holdfwd" && command = "c"
trigger1 = statetype = S && ctrl
trigger1 = p2bodydist x <= 5 && p2statetype != A && p2movetype != H && p2stateno != 5120

; Standing back + Light attack
[State -1]
type = ChangeState
value = 215
trigger1 = command = "holdback" && command = "a"
trigger1 = statetype = S && ctrl

; Standing Light attack
[State -1]
type = ChangeState
value = 200
triggerall = command = "a" && p2bodydist x > 14
trigger1 = statetype = S && ctrl && stateno != 195
trigger2 = stateno = 101 || stateno = 102

; Standing close Light attack
[State -1]
type = ChangeState
value = 205
triggerall = command = "a"
trigger1 = statetype = S && ctrl && stateno != 195
trigger2 = stateno = 101 || stateno = 102

; Standing back + Medium attack
[State -1]
type = ChangeState
value = 245
trigger1 = command = "b" && command = "holdback"
trigger1 = statetype = S && ctrl

; Standing Medium attack
[State -1]
type = ChangeState
value = 230
triggerall = command = "b" && p2bodydist x > 28
trigger1 = statetype = S && ctrl && stateno != 195
trigger2 = stateno = 101 || stateno = 102

; Standing close Medium attack
[State -1]
type = ChangeState
value = 235
triggerall = command = "b"
trigger1 = statetype = S && ctrl && stateno != 195
trigger2 = stateno = 101 || stateno = 102

; Standing combo Medium attack
[State -1]
type = ChangeState
value = 240
triggerall = command = "b"
trigger1 = stateno = 200 && AnimElem = 2, >= 1 && command != "holddown"
trigger2 = stateno = 205 && AnimElem = 2, >= 1 && command != "holddown"
trigger3 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0
trigger4 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0
trigger5 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && command != "holddown"
trigger6 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && command != "holddown"

; Running Hard attack
[State -1]
type = ChangeState
value = 262
trigger1 = command = "c" && p2bodydist x > 15
trigger1 = stateno = 101 || stateno = 102

; Standing Hard attack
[State -1]
type = ChangeState
value = 260
triggerall = command = "c"
trigger1 = statetype = S && ctrl && stateno != 195
trigger1 = p2bodydist x > 24

; Standing close Hard attack
[State -1]
type = ChangeState
value = 265
triggerall = command = "c"
trigger1 = statetype = S && ctrl && stateno != 195
trigger2 = stateno = 101 || stateno = 102

; Standing combo Hard attack A
[State -1]
type = ChangeState
value = 270
trigger1 = command = "c" && command != "holddown"
trigger1 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0

; Standing combo Hard attack B
[State -1]
type = ChangeState
value = 271
triggerall = command = "c"
trigger1 = stateno = 200 && AnimElem = 2, >= 1
trigger2 = stateno = 205 && AnimElem = 2, >= 1

; Standing combo Hard attack C
[State -1]
type = ChangeState
value = 272
triggerall = command = "c"
trigger1 = stateno = 230 && AnimElem = 4, >= 1 && AnimElem = 6, < 0
trigger2 = stateno = 235 && AnimElem = 3, >= 1 && AnimElem = 5, < 0

; Standing combo Hard attack D
[State -1]
type = ChangeState
value = 273
trigger1 = command = "c"
trigger1 = stateno = 272 && AnimElem = 4, >= 1 && AnimElem = 7, < 0

; Standing combo Hard finisher
[State -1]
type = ChangeState
value = 274
trigger1 = command = "qcf_c"
trigger1 = stateno = 273 && AnimElem = 5, >= 1 && AnimElem = 8, < 0

; Back + Light attack follow-up
[State -1]
type = ChangeState
value = 275
trigger1 = command = "c"
trigger1 = stateno = 215 && AnimElem = 4, >= 1 && AnimElem = 7, < 0

[State -1]
type = ChangeState
value = 276
trigger1 = command = "c"
trigger1 = stateno = 275 && AnimElem = 3, >= 1 && AnimElem = 6, < 0

[State -1]
type = ChangeState
value = 277
trigger1 = command = "c"
trigger1 = stateno = 276 && AnimElem = 4, >= 1 && AnimElem = 7, < 0

[State -1]
type = ChangeState
value = 278
trigger1 = command = "c" && command = "holdfwd"
trigger1 = stateno = 277 && AnimElem = 3, >= 1 && AnimElem = 6, < 0

; Crouching forward + Light attack
[State -1]
type = ChangeState
value = 415
trigger1 = command = "a" && command = "holdfwd" && command = "holddown"
trigger1 = statetype = C && ctrl

; Crouching Light attack
[State -1]
type = ChangeState
value = 400
trigger1 = command = "a"
trigger1 = statetype = C && ctrl

; Crouching forward + Medium attack
[State -1]
type = ChangeState
value = 445
trigger1 = command = "b" && command = "holdfwd" && command = "holddown"
trigger1 = statetype = C && ctrl

; Crouching Medium attack
[State -1]
type = ChangeState
value = 430
trigger1 = command = "b"
trigger1 = statetype = C && ctrl

; Crouching combo Medium attack
[State -1]
type = ChangeState
value = 440
triggerall = command = "b"
trigger1 = stateno = 200 && AnimElem = 2, >= 1
trigger2 = stateno = 205 && AnimElem = 2, >= 1
trigger3 = stateno = 400 && AnimElem = 3, >= 1 && AnimElem = 5, < 0
trigger4 = stateno = 430 && AnimElem = 3, >= 1 && AnimElem = 5, < 0

; Crouching combo Hard attack
[State -1]
type = ChangeState
value = 470
triggerall = command = "c" && command = "holddown" && command = "holdfwd"
trigger1 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0
trigger2 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0

; Crouching Hard attack
[State -1]
type = ChangeState
value = 460
triggerall = command = "c"
trigger1 = statetype = C && ctrl
trigger2 = stateno = 240 && AnimElem = 4, >= 1 && AnimElem = 6, < 0
trigger3 = stateno = 440 && AnimElem = 3, >= 1 && AnimElem = 5, < 0 && command = "holddown"

; Neutral jumping Light attack
[State -1]
type = ChangeState
value = 600
trigger1 = command = "a"
trigger1 = statetype = A && ctrl
trigger1 = Vel X = 0 && stateno != 48

; Diagonal jumping Light attack
[State -1]
type = ChangeState
value = 615
trigger1 = command = "a"
trigger1 = statetype = A && ctrl
trigger1 = stateno != 48

; Jumping Medium attack
[State -1]
type = ChangeState
value = 630
trigger1 = command = "b"
trigger1 = statetype = A && ctrl
trigger1 = stateno != 48

; Neutral jumping Hard attack
[State -1]
type = ChangeState
value = 660
trigger1 = command = "c"
trigger1 = statetype = A && ctrl
trigger1 = Vel X = 0 && stateno != 48

; Diagonal jumping Hard attack
[State -1]
type = ChangeState
value = 675
trigger1 = command = "c"
trigger1 = statetype = A && ctrl
trigger1 = stateno != 48

; Neutral (short) jumping Light attack
[State -1]
type = ChangeState
value = 605
trigger1 = command = "a"
trigger1 = statetype = A && ctrl
trigger1 = Vel X = 0

; Diagonal (short) jumping Light attack
[State -1]
type = ChangeState
value = 620
trigger1 = command = "a"
trigger1 = statetype = A && ctrl

; Jumping (short) Medium attack
[State -1]
type = ChangeState
value = 635
trigger1 = command = "b"
trigger1 = statetype = A && ctrl

; Neutral (short) jumping Hard attack
[State -1]
type = ChangeState
value = 665
trigger1 = command = "c"
trigger1 = statetype = A && ctrl
trigger1 = Vel X = 0

; Diagonal (short) jumping Hard attack
[State -1]
type = ChangeState
value = 680
trigger1 = command = "c"
trigger1 = statetype = A && ctrl

; Arial turning
[State -1]
type = ChangeState
value = 7
trigger1 = command = "y"
trigger1 = statetype = A && ctrl
trigger1 = stateno != 48

; Crawl forward
[State -1]
type = ChangeState
value = 22
trigger1 = stateno = 11
trigger1 = command = "holddown" && command = "holdfwd"

; Run Forward
[State -1]
type = ChangeState
value = 100
trigger1 = command = "FF" && command != "holddown"
trigger1 = statetype = S && ctrl
trigger1 = stateno != 100

; Run Backwards
[State -1]
type = ChangeState
value = 105
trigger1 = command = "BB" && command != "holddown"
trigger1 = statetype = S && ctrl
