;-| Super Motions |--------------------------------------------------------

[Command]
name = "qcf2_x"
command = ~D, DF, F, D, DF, F, x
time = 40

[Command]
name = "qcf2_y"
command = ~D, DF, F, D, DF, F, y
time = 40

[Command]
name = "qcf2_a"
command = ~D, DF, F, D, DF, F, a
time = 40

[Command]
name = "qcf2_b"
command = ~D, DF, F, D, DF, F, b
time = 40

[Command]
name = "rave"
command = ~F, DF, D, DB, B, F, x
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
name = "qcb_x"
command = ~D, DB, B, x
time = 15

[Command]
name = "qcb_y"
command = ~D, DB, B, y
time = 15

[Command]
name = "qcb_a"
command = ~D, DB, B, a
time = 15

[Command]
name = "qcb_b"
command = ~D, DB, B, b
time = 15

[Command]
name = "charge_x"
command = ~45$D, U, x
time = 10

[Command]
name = "charge_y"
command = ~45$D, U, y
time = 10

[Command]
name = "360"
command = ~U, B, D, F, y
time = 40

[Command]
name = "360"
command = ~B, D, F, U, y
time = 40

[Command]
name = "360"
command = ~D, F, U, B, y
time = 40

[Command]
name = "360"
command = ~F, U, B, D, y
time = 40

[Command]
name = "360"
command = ~U, F, D, B, y
time = 40

[Command]
name = "360"
command = ~F, D, B, U, y
time = 40

[Command]
name = "360"
command = ~D, B, U, F, y
time = 40

[Command]
name = "360"
command = ~B, U, F, D, y
time = 40

[Command]
name = "360"
command = ~U, UB, B, DB, D, DF, F, y
time = 40

[Command]
name = "360"
command = ~B, DB, D, DF, F, UF, U, y
time = 40

[Command]
name = "360"
command = ~D, DF, F, UF, U, UB, B, y
time = 40

[Command]
name = "360"
command = ~F, UF, U, UB, B, DB, D, y
time = 40

[Command]
name = "360"
command = ~U, UF, F, DF, D, DB, B, y
time = 40

[Command]
name = "360"
command = ~F, DF, D, DB, B, UB, U, y
time = 40

[Command]
name = "360"
command = ~D, DB, B, UB, U, UF, F, y
time = 40

[Command]
name = "360"
command = ~B, UB, U, UF, F, DF, D, y
time = 40

[Command]
name = "360"
command = ~U, UB, B, DB, D, DF, y
time = 40

[Command]
name = "360"
command = ~B, DB, D, DF, F, UF, y
time = 40

[Command]
name = "360"
command = ~D, DF, F, UF, U, UB, y
time = 40

[Command]
name = "360"
command = ~F, UF, U, UB, B, DB, y
time = 40

[Command]
name = "360"
command = ~U, UF, F, DF, D, DB, y
time = 40

[Command]
name = "360"
command = ~F, DF, D, DB, B, UB, y
time = 40

[Command]
name = "360"
command = ~D, DB, B, UB, U, UF, y
time = 40

[Command]
name = "360"
command = ~B, UB, U, UF, F, DF, y
time = 40

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
name = "fwd_x"
command = /F,x

[Command]
name = "fwd_y"
command = /F,y

[Command]
name = "fwd_a"
command = /F,a
time = 1

[Command]
name = "fwd_b"
command = /F, b
time = 1

[Command]
name = "df_y"
command = /DF, y
time = 1

[Command]
name = "df_a"
command = /DF, a
time = 1

[Command]
name = "fake_a"
command = F, a+y
time = 5

[Command]
name = "fake_b"
command = D, a+y
time = 5

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

; Deadly rave neo
[State -1]
type = ChangeState
value = 2200
triggerall = command = "rave"
triggerall = power >= 2000
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Deadly rave neo (press X)
[State -1]
type = VarSet
v = 5
value = 1
triggerall = command = "x"
trigger1 = stateno = 2205
trigger1 = MoveHit = 1
trigger2 = stateno = 2210

; Deadly rave neo (press A)
[State -1]
type = VarSet
v = 5
value = 1
triggerall = command = "a"
trigger1 = stateno = 2220
trigger2 = stateno = 2230

; Deadly rave neo (press Y)
[State -1]
type = VarSet
v = 5
value = 1
triggerall = command = "y"
trigger1 = stateno = 2240
trigger2 = stateno = 2250

; Deadly rave neo (press B)
[State -1]
type = VarSet
v = 5
value = 1
triggerall = command = "b"
trigger1 = stateno = 2260
trigger2 = stateno = 2270

; Deadly rave neo (QCB Y)
[State -1]
type = VarSet
v = 5
value = 1
trigger1 = command = "qcb_y"
trigger1 = stateno = 2280

; S. Raging storm
[State -1]
type = ChangeState
value = 2000
triggerall = command = "qcf2_x"
triggerall = power >= 1000
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; P. Raging storm
[State -1]
type = ChangeState
value = 2050
triggerall = command = "qcf2_y"
triggerall = power >= 2000
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; S. Shine knuckle
[State -1]
type = ChangeState
value = 2100
triggerall = command = "qcf2_a"
triggerall = power >= 1000
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; P. Shine knuckle
[State -1]
type = ChangeState
value = 2150
triggerall = command = "qcf2_b"
triggerall = power >= 2000
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4= stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6= MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Shinkuu nage
[State -1]
type = ChangeState
value = 1500
triggerall = command = "360"
triggerall = P2bodydist X < 10
triggerall = P2statetype != A
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 40
trigger3 = stateno = 52
trigger4 = stateno = 1380
trigger5 = stateno = 850
trigger5 = Time < 9
trigger5 = NumExplod(160) = 1
trigger6 = stateno = 851
trigger6 = Time < 9
trigger6 = NumExplod(160) = 1

; Reppuken
[State -1]
type = ChangeState
value = 1000
triggerall = command = "qcf_x"
triggerall = NumProjID(1000) = 0
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8= MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Double Reppuken
[State -1]
type = ChangeState
value = 1050
triggerall = command = "qcf_y"
triggerall = NumProjID(1000) = 0
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Light Rising tackle
[State -1]
type = ChangeState
value = 1100
triggerall = command = "charge_x"
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 40
trigger3 = stateno = 200
trigger3 = MoveContact = 1
trigger4 = stateno = 205
trigger4 = MoveContact = 1
trigger5 = stateno = 225
trigger5 = MoveContact = 1
trigger6 = stateno = 245
trigger6 = MoveContact = 1
trigger7 = stateno = 265
trigger7 = MoveContact = 1
trigger8 = stateno = 400
trigger8 = MoveContact = 1
trigger9 = stateno = 420
trigger9 = MoveContact = 1
trigger10 = stateno = 440
trigger10 = MoveContact = 1
trigger11 = stateno = 910
trigger11 = MoveContact = 1
trigger12 = stateno = 150 || stateno = 152
trigger12 = Var(8)

; Hard Rising tackle
[State -1]
type = ChangeState
value = 1150
triggerall = command = "charge_y"
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 40
trigger3 = stateno = 200
trigger3 = MoveContact = 1
trigger4 = stateno = 205
trigger4 = MoveContact = 1
trigger5 = stateno = 225
trigger5 = MoveContact = 1
trigger6 = stateno = 245
trigger6 = MoveContact = 1
trigger7 = stateno = 265
trigger7 = MoveContact = 1
trigger8 = stateno = 400
trigger8 = MoveContact = 1
trigger9 = stateno = 420
trigger9 = MoveContact = 1
trigger10 = stateno = 440
trigger10 = MoveContact = 1
trigger11 = stateno = 910
trigger11 = MoveContact = 1
trigger12 = stateno = 150 || stateno = 152
trigger12 = Var(8)

; Light Hard edge
[State -1]
type = ChangeState
value = 1200
triggerall = command = "qcb_x"
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Hard Hard edge
[State -1]
type = ChangeState
value = 1250
triggerall = command = "qcb_y"
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Rage run - type "dunk"
[State -1]
type = ChangeState
value = 1300
triggerall = command = "qcb_a"
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Rage run - type "shift"
[State -1]
type = ChangeState
value = 1350
triggerall = command = "qcb_b"
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Crack counter jou-dan
[State -1]
type = ChangeState
value = 1400
triggerall = command = "qcf_a"
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Crack counter ge-dan
[State -1]
type = ChangeState
value = 1450
triggerall = command = "qcf_b"
trigger1 = statetype != A
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1
trigger11 = stateno = 150 || stateno = 152
trigger11 = Var(8)

; Standing dodge attack
[State -1]
type = ChangeState
value = 900
triggerall = statetype = S
triggerall = ctrl = 1
trigger1 = command = "brake"
trigger2 = command = "c"

; Crouching dodge attack
[State -1]
type = ChangeState
value = 910
triggerall = statetype = C
triggerall = ctrl = 1
trigger1 = command = "brake"
trigger2 = command = "c"

; TOP attack
[State -1]
type = ChangeState
value = 950
triggerall = statetype != A
triggerall = ctrl = 1
triggerall = Var(3) = [1,3]
trigger1 = command = "top"
trigger2 = command = "z"

; Fake Shine knuckle
[State -1]
type = ChangeState
value = 980
triggerall = command = "fake_a"
trigger1 = statetype = S
trigger1 = ctrl = 1
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1

; Fake Reppuken
[State -1]
type = ChangeState
value = 990
triggerall = command = "fake_b"
trigger1 = statetype = S
trigger1 = ctrl = 1
trigger2 = stateno = 10
trigger2 = stateno = 200
trigger2 = MoveContact = 1
trigger3 = stateno = 205
trigger3 = MoveContact = 1
trigger4 = stateno = 225
trigger4 = MoveContact = 1
trigger5 = stateno = 245
trigger5 = MoveContact = 1
trigger6 = stateno = 265
trigger6 = MoveContact = 1
trigger7 = stateno = 400
trigger7 = MoveContact = 1
trigger8 = stateno = 420
trigger8 = MoveContact = 1
trigger9 = stateno = 440
trigger9 = MoveContact = 1
trigger10 = stateno = 910
trigger10 = MoveContact = 1

; Throw
[State -1]
type = ChangeState
value = 800
trigger1 = command = "fwd_y"
trigger1 = statetype = S
trigger1 = stateno != 100
trigger1 = p2bodydist x <= 10
trigger1 = p2movetype != H
trigger1 = p2statetype != A
trigger1 = ctrl = 1

; Standing close light punch
[State -1]
type = ChangeState
value = 205
triggerall = command = "x"
triggerall = p2bodydist x < 15
trigger1 = statetype = S
trigger1 = ctrl = 1

; Standing light punch
[State -1]
type = ChangeState
value = 200
triggerall = command = "x"
trigger1 = statetype = S
trigger1 = ctrl = 1

; Standing close light kick
[State -1]
type = ChangeState
value = 225
triggerall = command = "a"
triggerall = p2bodydist x < 15
trigger1 = statetype = S
trigger1 = ctrl = 1

; Standing light kick
[State -1]
type = ChangeState
value = 220
triggerall = command = "a"
trigger1 = statetype = S
trigger1 = ctrl = 1

; Standing close hard punch
[State -1]
type = ChangeState
value = 245
triggerall = command = "y"
triggerall = p2bodydist x < 15
trigger1 = statetype = S
trigger1 = ctrl = 1

; Standing hard punch
[State -1]
type = ChangeState
value = 240
triggerall = command = "y"
trigger1 = statetype = S
trigger1 = ctrl = 1

; Standing close hard kick follow-up
[State -1]
type = ChangeState
value = 270
trigger1 = command = "b"
trigger1 = command = "holdfwd"
trigger1 = stateno = 265
trigger1 = MoveContact = 1

; Standing close hard kick
[State -1]
type = ChangeState
value = 265
triggerall = command = "b"
triggerall = p2bodydist x < 15
trigger1 = statetype = S
trigger1 = ctrl = 1

; Standing hard kick
[State -1]
type = ChangeState
value = 260
triggerall = command = "b"
trigger1 = statetype = S
trigger1 = ctrl = 1

; Crouching light punch
[State -1]
type = ChangeState
value = 400
triggerall = command = "x"
trigger1 = statetype = C
trigger1 = ctrl = 1

; Crouching light kick
[State -1]
type = ChangeState
value = 420
triggerall = command = "a"
trigger1 = statetype = C
trigger1 = ctrl = 1

; Crouching hard punch
[State -1]
type = ChangeState
value = 440
triggerall = command = "y"
trigger1 = statetype = C
trigger1 = ctrl = 1

; Crouching hard kick
[State -1]
type = ChangeState
value = 460
triggerall = command = "b"
trigger1 = statetype = C
trigger1 = ctrl = 1

; Jumping light punch
[State -1]
type = ChangeState
value = 600
triggerall = command = "x"
trigger1 = statetype = A
trigger1 = ctrl = 1

; Jumping light kick
[State -1]
type = ChangeState
value = 620
triggerall = command = "a"
trigger1 = statetype = A
trigger1 = ctrl = 1
trigger2 = stateno = 640
trigger2 = MoveContact = 1

; Jumping hard punch
[State -1]
type = ChangeState
value = 640
triggerall = command = "y"
trigger1 = statetype = A
trigger1 = ctrl = 1

; Jumping hard kick
[State -1]
type = ChangeState
value = 660
triggerall = command = "b"
trigger1 = statetype = A
trigger1 = ctrl = 1

; Post-taunt A
[State -1]
type = ChangeState
value = 196
trigger1 = command = "holdfwd"
trigger1 = command = "s"
trigger1 = Win = 1
trigger1 = P2life = 0
trigger1 = statetype = S
trigger1 = ctrl = 1

; Post-taunt B
[State -1]
type = ChangeState
value = 197
trigger1 = command = "holdback"
trigger1 = command = "s"
trigger1 = Win = 1
trigger1 = P2life = 0
trigger1 = statetype = S
trigger1 = ctrl = 1

; Taunt
[State -1]
type = ChangeState
value = 195
trigger1 = command = "s"
trigger1 = statetype = S
trigger1 = stateno != 195
trigger1 = ctrl = 1

[State -1]
type = VarSet
v = 5
value = 1
triggerall = command = "x"
triggerall = Pos Y < 8
trigger1 = stateno = 5050
trigger2 = stateno = 5071

[State -1]
type = VarSet
v = 5
value = 2
triggerall = command = "a"
triggerall = Pos Y < 8
trigger1 = stateno = 5050
trigger2 = stateno = 5071

[State -1]
type = VarSet
v = 5
value = 3
triggerall = command = "y"
triggerall = Pos Y < 8
trigger1 = stateno = 5050
trigger2 = stateno = 5071

[State -1]
type = VarSet
v = 5
value = 4
triggerall = command = "b"
triggerall = Pos Y < 8
trigger1 = stateno = 5050
trigger2 = stateno = 5071

; Run Forward
[State -1]
type = ChangeState
value = 100
trigger1 = command = "FF"
trigger1 = statetype = S
trigger1 = command != "holddown"
trigger1 = ctrl = 1

; Run Backwards
[State -1]
type = ChangeState
value = 105
trigger1 = command = "BB"
trigger1 = statetype = S
trigger1 = command != "holddown"
trigger1 = ctrl = 1