# Problema 3 : Mem.Cache
#		Mapeo Directo
#		16 bloques
#		4 palabras por bloque
#		escritura inmediata con migración
	.data
A:	.space	128
B:	.space	128
C:	.space	128

	.text
	.globl main
main :
	# i -> s0
	# j -> s1
	xor $s0, $s0, $s0
forI:
	li $t0, 8
	bge $s0, $t0, finForI
	
	xor $s1, $s1, $s1
forJ:
	li $t0, 4
	bge $s1, $t0, finForJ
	
	sll $t1, $s0, 2
	addu $t1, $t1, $s1
	sll $t1, $t1, 2
	
	la $t2, A
	addu $t2, $t2, $t1
	la $t3, B
	addu $t3, $t3, $t1
	la $t4, C
	addu $t4, $t4, $t1
	
	lw $t2, 0($t2)
	lw $t3, 0($t3)
	addu $t2, $t2, $t3
	lw $t3, 0($t4)
	addu $t2, $t2, $t3
	
	sw $t2, 0($t4)
	
	addiu $s1, $s1, 1
	b forJ
finForJ:

	addiu $s0, $s0, 1
	b forI
finForI:
	jr $ra