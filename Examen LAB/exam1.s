	.data

files:		.word 1,2,3,4
columnes:	.word 1,3,1,4
M:		.word 0,0,0,0,0, 0,1,0,0,0 0,0,0,2,0 0,4,0,0,0 0,0,0,0,15
suma:		.word 1

	.text
	.globl main
	
main:
	li $t0, 0		# t0 = K (word)
	li $t1, 16		# t1 = cte 16 (4 word)
	# $t2 = fil
	# $t3 = col
	li $t4, 4
	li $t5, 20
	li $t6, 0
	
	la $s0, files
	la $s1, M
	la $s2, suma
	
for:	bge $t0, $t1, fifor
	addu $t2, $s0, $t0	# fil = @fil + k*4
	
	lw $t3, 16($t2)		# t3 = col[k] = fil[k] + 16
	lw $t2, 0($t2)		# t2 = fil[k]
	
	multu $t2,$t5
	mflo $t2		# t2 = fil[k] * 20
	multu $t3,$t4
	mflo $t3		# t3 = col[k] * 4
	
	addu $t3, $s1, $t3	# t3 = @M + col[k]*4
	addu $t3, $t3, $t2 	# t3 = @M + col[k]*4 + fil[k]*20
	
	lw $t7, 0($t3)
	addu $t6, $t6, $t7

	addiu $t0, $t0, 4	# ++k (+word)
	b for
fifor:	
	lw $t2, 0($s2)
	addu $t6, $t6, $t2
	sw $t6, 0($s2)
	
	jr $ra