	addi $1,$0,1
init:	add $7,$0,$0
loop:	sw $7, 0($0)
	lw $8,1($0)
	lw $9,2($0)
	beq $8,$1,addone
	beq $9,$1,init
	j loop
addone:	lw $10,0($0)
	add $7,$7,$10
	sw $7,0($0)
wait:	lw $8,1($0)
	beq $8,$1,wait
	j loop