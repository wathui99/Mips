	.data
zero: .asciiz    "khong "
one: .asciiz    "mot "
two: .asciiz    "hai "
three: .asciiz    "ba "
four: .asciiz    "bon "
five: .asciiz    "nam "
six: .asciiz    "sau "
seven: .asciiz    "bay "
eight: .asciiz    "tam "
nine: .asciiz    "chin " 
Invalid_notice: .asciiz "Invalid number"    
	.text
main:
	li $v0, 5
	syscall
	move $s0, $v0 #so nhap vao $s0
	slt $t0, $s0, $zero
	beq $t0, 1, Invalid
	li $s1, 1     #bien count la $s1
	addiu $sp, $sp, -4 #khai bao 1 word
	li $t0,10
	div $s0,$t0
	mfhi $t0
	sw $t0, 0($sp) #luu vao sp
	move $s2, $s0 #s2 la bien tam dung de chia
	WhileBegin:
		div $s2, $s2, 10
		
		beq $s2, $zero, WhileBreak
		
		addiu $s1,$s1,1
		addiu $sp, $sp, -4 #khai bao 1 word
		li $t0,10
		div $s2,$t0
		mfhi $t0
		sw $t0, 0($sp) #luu vao sp
		j WhileBegin
	
	WhileBreak:
	
	ForBegin:
		beq $s1,0,ForEnd
		lw $a0,0($sp)
		jal printNum
		addi $sp,$sp,4
		addi $s1,$s1,-1
		j ForBegin
	ForEnd:
	j Exit
	
	Invalid:
	la $a0,Invalid_notice
  	addi $v0,$v0,4
  	syscall
  	j Exit
	
printNum:
	bne $a0, 0, if1
		la $a0,zero
    		addi $v0, $0, 4
    		syscall
    		j return
	if1:
	bne $a0, 1, if2
		la $a0,one
    		addi $v0, $0, 4
    		syscall
    		j return
	if2:
	bne $a0, 2, if3
		la $a0,two
    		addi $v0, $0, 4
    		syscall
    		j return
	if3:
	bne $a0, 3, if4
		la $a0,three
    		addi $v0, $0, 4
    		syscall
    		j return
	if4:
	bne $a0, 4, if5
		la $a0,four
    		addi $v0, $0, 4
    		syscall
    		j return
	if5:
	bne $a0, 5, if6
		la $a0,five
    		addi $v0, $0, 4
    		syscall
    		j return
	if6:
	bne $a0, 6, if7
		la $a0,six
    		addi $v0, $0, 4
    		syscall
    		j return
	if7:
	bne $a0, 7, if8
		la $a0,seven
    		addi $v0, $0, 4
    		syscall
    		j return
    	if8:
	bne $a0, 8, if9
		la $a0,eight
    		addi $v0, $0, 4
    		syscall
    		j return
    	if9:
	bne $a0, 9, return
		la $a0,nine
    		addi $v0, $0, 4
    		syscall
    	return:
    	jr $ra

Exit:
