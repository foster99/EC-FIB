.data
vec1: 	.word	1,2,3,4,5,6,7,8,9,0
vec2:	.word	-1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7

	.text
	.globl main

main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $a0, 10
	la $a1, vec1
	jal subr
	
	li $a0, 13
	la $a1, vec2
	jal subr 
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra	

func:
	move $v0, $a0
	jr $ra
	
subr:
	addiu $sp, $sp, 20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	
	srl $s0, $a0, 1
	
	move $s1, $a1
	
	addiu $t0, $a0, -1
	sll $t0, $t0, 2
	addu $s2, $t0, $a1
	
	move $s3, $zero
for:
	bge $s3, $s0, fifor
	lw $a0, 0($s1)
	jal func
	sw $v0, 0($s2)
	addiu $s1, $s1, 4
	addiu $s2, $s2, -4
	addiu $s3, $s3, 1
	b for
fifor:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	addiu $sp, $sp, -20
	
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	