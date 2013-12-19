; Takes a number.  When you click button 1, it turns on the decimal point, and displays the number you input + 1

load1: lw $1,0($0) ; Load A to R1 from dipswitch
sw $1,0($0) ; Output A to display
lw $2,1($0) ; Load button press to R2 (1 if pressed)
beq $2,$0,load1 ; If button==1 continue; button==0 loop to load1

addiu $2,$0,1 ; Set the value of R2 to 1
add $1,$1,$2 ; Add 1 to A
sw $7,2($0) ; Overflow digit
sw $1,0($0) ; Output A to display

end: j end ; inf loopy endy