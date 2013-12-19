load1: lw $1,0($0) ; Load A to R1 from dipswitch
sw $1,0($0) ; Output A to display
lw $3,1($0) ; Load button 1 press to R3 (1 if pressed)
beq $3,$0,load1 ; If button==1 continue; button==0 loop to load1

load2: lw $2,0($0) ; Load B to R2 from dipswitch
sw $2,0($0) ; Output B to display
lw $3,2($0) ; Load button 2 press to R3 (1 if pressed)
beq $3,$0,load2 ; If button==1 continue; button==0 loop to load2

addiu $3,$0,0 ; Set the initial value of the product to 0
addiu $4,$0,0 ; Store count = 0 to R4 
addiu $5,$0,1 ; Store 00000001 (mask) to R5

loop: and $6,$2,$5 ; Get rightmost digit of B and store to R6
beq $6,$0,shiftInc ; If digit is 0, skip this iteration

sll $6,$1,$4 ; Shift A left by count
add $3,$3,$6 ; Add the shifted value to the product
sw $7,2($0) ; Overflow digit

shiftInc: addiu $6,$0,1 ; Store the value 1 in R6 (used for shifting)
srl $2,$2,$6 ; Shift B right by 1
addiu $4,$4,1 ; Increment count by 1

subiu $6,$4,8 ; Subtract 8 from count and store to R6
bne $6,$0,loop ; Loop while count != 8

sw $3,0($0) ; Output the product to the display

end: j end ; Loop forever at the end