	.data
signe:		.word 0
exponent:	.word 0
mantissa:	.word 0
cfixa:		.word 0x87D18A00
cflotant:	.float 0.0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t0, cfixa
	lw	$a0, 0($t0)
	la	$a1, signe
	la	$a2, exponent
	la	$a3, mantissa
	jal	descompon

	la	$a0, signe
	lw	$a0,0($a0)
	la	$a1, exponent
	lw	$a1,0($a1)
	la	$a2, mantissa
	lw	$a2,0($a2)
	jal	compon

	la	$t0, cflotant
	swc1	$f0, 0($t0)

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra


descompon:

pos:	lw $t0, 0($a0)
	bltz $t0, neg
	move $t0, $zero
	b store
neg:	li $t0, 1
store:	sw $t0, 0($a1)	
	
	sll $a0, $a0, 1
	
if:	bne $a0, $zero, else

then:	move $t7, $zero
	b fi
	
else:	li $t7, 18

while:	blt $a0, $zero fibucle
	sll $a0, $a0, 1
	addiu $t7, $t7, -1
	b while
	
fibucle:sll $a0, $a0, 3
	li $t1, 0x7FFFFF
	and $a0, $a0, $t1
	
	addiu $t7, $t7, 127
	
fi:	sw $t7, 0($a2)
	sw $a0, 0($a3)
	
	jr $ra
	
	
	
	
	
	
compon:

