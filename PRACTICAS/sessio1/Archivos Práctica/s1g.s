# PRACTICA 1 #######################

	.data

fib:	.space 40

	.text
	.globl main
main:
	addiu $s0, $s0, 2
	la $t0, fib
	li $t1, 1
	sw $zero, 0($t0)
	sw $t1, 4($t0)
	
while:
	slti $t0, $s0, 10
	beq $t0, $zero, fi
	
	la $t0, fib
	sll $t3, $s0, 2
	addu $t0, $t0, $t3
	lw $t1, -4($t0)
	lw $t2, -8($t0)
	addu $t1, $t1, $t2
	sw $t1, 0($t0)
	
	addiu $s0, $s0, 1
	b while
	
fi:
	jr $ra		# main retorna al codi de startup
