	.data

	.text
	.globl main
main:
	li $s1, 23 # Y
	li $s0, 8  # X

	
	li $t0, 1
	sllv $t1, $t0, $s0	# 1<<X
	sub $t1, $t1, $t0	# anterior - 1
	xor $s1, $s1, $t1
	
	jr $ra
