	.data
w:        .asciiz "8754830094826456674949263746929"
resultat: .byte 0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, w
	li	$a1, 31
	jal	moda
	la	$s0, resultat
	sb	$v0, 0($s0)
	move	$a0, $v0
	li	$v0, 11
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr 	$ra

nofares:
	li	$t0, 0x12345678
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra


moda:
	addiu $sp, $sp, -4
        sw $ra, 0($sp)		#ra -> stack
        
        addiu $sp, $sp, -24     # registres segurs
        sw $s0, 0($sp)
        sw $s1, 4($sp)
       	sw $s2, 8($sp)
        sw $s3, 12($sp)
        sw $s4, 16($sp)
        sw $s5, 20($sp)
	
	addiu $sp, $sp, -40	#histo
	
	li $t0, 0               # k = 0
        li $t1, 10		# 10 para hacer comparacion
	
for1:	bge $t0, $t1, fi_for1
	sll $t2, $t0, 2
	add $t2, $t2, $sp
	sw $zero, 0($t2)
	addiu $t0, $t0, 1
	b for1
	
fi_for1:
	li $s0, 0		# k = 0
	li $s1, '0'		# max = '0'
	move $s2, $a1		# num
	move $s3, $sp		# @histo
	move $s4, $a0		# @vec
	li $s5, '0'

for2:	bge $s0, $s2, fi_for2

	# pasar parametros update		
	move $a0, $s3		# @histo
	
	addu $t0, $s0, $s4	# @vec + k
	lb $a1, 0($t0)		# @vec[k]
	sub $a1, $a1, $s5	# @vec[k] - '0'
	
	sub $a2, $s1, $s5	# max - '0'
	
	jal update		# llamar a funcion update
	add $s1, $v0, $s5	# max = resultado de update + '0'
	addiu $s0, $s0, 1	# ++k 
	b for2
	
fi_for2:move $v0, $s1		#return max
	
	addiu $sp, $sp, 40	#borrar histo
	
	lw $s0, 0($sp)
        lw $s1, 4($sp)
       	lw $s2, 8($sp)
        lw $s3, 12($sp)
        lw $s4, 16($sp)
        lw $s5, 20($sp)
	addiu $sp, $sp, 24	# recuperar registros seguros modificados
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4	# recuperar direccion de retorno
        
	jr $ra			# salto a direccion de retorno
	
	
	
	
update:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)		#guarda direccion de retorno (linea 85)
	
	addiu $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	
	move $s0, $a0		# histo
	move $s1, $a1		# i
	move $s2, $a2		# imax
	
	jal nofares
	
	sll $t0, $s1, 2		#
	add $t0, $t0, $s0	# i*4 + @h
	lw $t1, 0($t0)
	addiu $t1, $t1, 1	# ++h[i]
	sw $t1, 0($t0)		# h[i]
	
	sll $t2, $s2, 2		#
	add $t2, $t2, $s0 	# imax * 4 + @h
	lw $t2, 0($t2)		# h[imax]
	
if:	ble $t1, $t2, else
then:	move $v0, $s1
	b fi
else:	move $v0, $s2

fi:	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addiu $sp, $sp, 12

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
