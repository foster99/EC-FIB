	.data
result: .word 0
num:	.byte '7'

	.text
	.globl main
main:
	la $t0, num
	lw $t0, 0($t0)	# $t0 = num
	
	li $t1, 'a'
	li $t2, 'z'
	li $t3, 'A'
	li $t4, 'Z'
	li $t5, '0'
	li $t6, '9'
	
primer_if:	

and1.1:	blt $t0, $t1, and2.1
and1.2:	ble $t0, $t2, then1
and2.1:	blt $t0, $t3, else1
and2.2:	bgt $t0, $t4, else1
	
then1:	b fi
	
else1:
	blt $t0, $t5, else2
	bgt $t0, $t6, else2

then2:	sub $t0, $t0, $t5
	b fi
	
else2:	li $t0, -1

fi:	la $t7, result
	sw $t0, 0($t7)
	jr $ra


