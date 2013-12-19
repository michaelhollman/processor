noop

load1: lw $1,0($0) ; Load dipswitch to R1
lw $3,1($0) ; Load button press to R3 (1 if pressed)
beq $3,$0,load1 ; If button==1 continue; button==0 loop to load1

load2: lw $2,0($0) ; Load dipswitch to R2
lw $3,1($0) ; Load button press to R3 (1 if pressed)
beq $3,$0,load2 ; If button==1 continue; button==0 loop to load2

