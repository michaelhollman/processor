; Constantly displays status of buttons
loop: lw $1,1($0)
sw $1,1($0)
lw $1,2($0)
sw $1,2($0)
j loop