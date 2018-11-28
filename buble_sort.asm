.data
	array:		.space	400 #toi da 400 phan tu
														
.text	
																	
main:
	li $v0, 5
	syscall
	move $s0, $v0 						#s0 -> n
	li $t0,1
	slt $t0,$s0,$t0
	bne $t0,$zero,Exit #neu < 1 thi thoat
	#nhap mang
	la $s1,array #dia chi nen
	move $a1,$s1
	move $a0,$s0
	jal NhapMang
	move $a0,$s0
	move $a1,$s1
	jal buble_sort
	j Exit

buble_sort:
#a0 -> n
#a1 -> base address
#t0 -> i
#t1 -> j
addi $sp,$sp,-12
sw $s0,0($sp)
sw $s1,4($sp)
sw $ra,8($sp)
#s0 -> n
#s1 -> base add
move $s0,$a0
move $s1,$a1
#i -> t0
move $t0,$a0
addi $t0,$t0,-1
Start_For1:
	beq $t0,0,End_For1
	li $t1,0
	Start_For2:
		beq $t1,$t0,End_For2
		#lw array[j] -> t6 base add
		sll $t6,$t1,2
		add $t6,$t6,$s1
		lw $t2,0($t6)
		#lw array[j+1] -> t3
		addi $t5,$t6,4
		lw $t3,0($t5)
		# if a[j]<a[j+1]
		slt $t4,$t2,$t3
		bne $t4,1,Skip
			move $a0,$t5
			move $a1,$t6
			jal swap
		Skip:
		#j++
		addi $t1,$t1,1
		j Start_For2
	End_For2:
	#i++
	addi $t0,$t0,-1
	j Start_For1
End_For1:
lw $s0,0($sp)
lw $s1,4($sp)
lw $ra,8($sp)
addi $sp,$sp,12
jr $ra

swap:
addi $sp,$sp,-8
sw $s0,0($sp)
sw $s1,4($sp)
lw $s0,0($a0)
lw $s1,0($a1)
#swap
sw $s0,0($a1)
sw $s1,0($a0)
#tra lai gia tri
lw $s0,0($sp)
lw $s1,4($sp)
addi $sp,$sp,8
jr $ra	
	
NhapMang:
addi $a0,$a0,-1 #a0 = n-1
WhileStart:
	beq $a0,-1,WhileEnd #neu a0 == -1 thi ket thuc
	move $t0,$a1 #load dia chi nen
	sll $t1,$a0,2 #t1 = a0 * 4
	add $t1,$t1,$t0 #t1 la array[a0]
	
	li $v0, 5
	syscall
	move $t2, $v0 						#t2 -> array[a0]
	sw $t2,0($t1)
	
	addi $a0,$a0,-1 #giam a0 xuong
	j WhileStart
WhileEnd:
jr $ra
	
Exit:
							
