	# Sessio 3

	.data 
# Declara aqui les variables mat1, mat4 i col
mat1: 	.space 120
mat4: 	.word 2, 3, 1, 2, 4, 3
col:	.word 2

	.text 
	.globl main
main:
	#modifico $s0, $s1 y $ra
	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	la $s0, mat4
	la $s1, mat1
	
	move $a0, $s0
	#addiu $a1, $a0, 8
	lw $a1, 8($a0)
	la $t0, col
	lw $a2, 0($t0)
	
	jal subr
	sw $v0, 108($s1)
	
	move $a0, $s0
	li $a1, 1
	li $a2, 1
	
	jal subr
	sw $v0, 0($s1)
	
	#recupero datos de stack
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addiu $sp, $sp, 12
	
	jr $ra

subr:
	
	li $t0, 3
	mult $a1, $t0
	mflo $t0		# = i * NC
	addu $t0, $t0, $a2	# = i * NC + j
	sll $t0, $t0, 2		# = 'anterior' * 4
	addu $t0, $t0, $a0	# = @x[i][j]
	
	lw $t0, 0($t0)
	
	la $t1, mat1
	li $t2, 6
	mult $a2, $t2
	mflo $t2		# = i * NC
	addiu $t2, $t2, 5	# = i * NC + j
	sll $t2, $t2, 2		# = 'anterior' * 4
	addu $t2, $t2, $t1	# = @x[i][j]
	
	sw $t0, 0($t2)
	
	move $v0, $a1
	
	jr $ra
	
	
	
	
	
	
	
	