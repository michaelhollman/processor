	addi $3,$0,1
init:	add $7,$0,$0
loop:	sw $7, 0($0)
	lw $0,1($0)
	lw $5,2($0)
	beq $5,$1,addone
	beq $6,$1,init
	j loop
addone:	lw $3,0($0)
	add $7,$7,$4
	sw $7,0($0)
wait:	lw $5,1($0)
	beq $5,$1,wait
	j loop