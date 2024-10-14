#
#	Author: Pranav Joseph
#	Date: 10/7/2024
#	Location: UTD
#

.include "SysCalls.asm"
.data 
	intMsgX:	     		.space 100
	beforeMsg:	     		.space 100
	afterMsg:	     		.space 100
	from:				.space 100
	to:	     			.space 100 
	iterative: 			.space 100
	recursive: 			.space 100
	fileName:			.asciiz "input.txt"
	x: 				.word 32
	y:				.word 32
	
.text 
	li $v0, SysOpenFile
	la $a0, fileName
	li $a1, 0
	syscall
	move $s0, $v0
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, intMsgX
	la $a2, 52
	syscall
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, x
	la $a2, 1
	syscall
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, beforeMsg
	la $a2, 33
	syscall
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, afterMsg
	la $a2, 26
	syscall
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, x
	la $a2, 1
	syscall
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, from
	la $a2, 21
	syscall
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, to
	la $a2, 4
	syscall
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, iterative
	la $a2, 12
	syscall
	
	li $v0, SysReadFile
	move $a0, $s0
	la $a1, recursive
	la $a2, 12
	syscall
	
	li $v0, SysPrintString 
	la $a0, intMsgX
	syscall
	
	li $v0, SysReadInt
	syscall
	sw $v0, x
	
	lw $t1, x
	beq $t1, $zero, Exit
		
	li $v0, SysPrintString 
	la $a0, beforeMsg
	syscall
	
	li $v0, SysPrintInt
	lw $a0, x
	syscall
	
	li $v0, SysPrintString 
	la $a0, afterMsg
	syscall
	
	li $v0, SysReadInt
	syscall
	sw $v0, y
	
	lw $t1, y
	beq $t1, $zero, Exit
	
	li $v0, SysPrintString 
	la $a0, from
	syscall
	
	li $v0, SysPrintInt
	lw $a0, x
	syscall
	
	li $v0, SysPrintString 
	la $a0, to
	syscall
	
	li $v0, SysPrintInt
	lw $a0, y
	syscall
	
	li $v0, SysPrintString 
	la $a0, iterative
	syscall
	
	la $s0, 0
	lw $t1, x
	lw $t2, y
	addi $t2, $t2, 1
	itr_sumsq:
		mul $t3 , $t1 , $t1
		
		add $s0, $s0, $t3
		
		li $v0, SysPrintInt
		move $a0, $s0
		syscall
		
		li $v0, SysPrintChar
		li $a0, ' '
		syscall
		
		addi $t1, $t1, 1
		bne $t1, $t2, itr_sumsq
		
	itr_exit: 
	
	li $v0, 11         # Print character syscall
    	li $a0, '\n'        # Load space character
    	syscall
	
	li $v0, SysPrintString 
	la $a0, recursive
	syscall
	
	la $s0, 0           # Initialize sum to 0 (s0 will hold the sum)
    	lw $t1, x           # Load the value of x into $t1
    	lw $t2, y           # Load the value of y into $t2
    	addi $t2, $t2, 1    
	
	jal rec_sumsq
	
	
	Exit:
		li $v0, SysExit
		Syscall
	
	rec_sumsq:
    		# Base case: if t1 (current number) >= t2 (limit), return
    		bge $t1, $t2, rec_exit

    		# Calculate square of the current number
    		mul $t3, $t1, $t1

    		# Add the square to the sum in $s0
    		add $s0, $s0, $t3

    		# Print the current sum
    		li $v0, 1          # Print integer syscall
    		move $a0, $s0      # Move sum to $a0
    		syscall

    		# Print space character
    		li $v0, 11         # Print character syscall
    		li $a0, ' '        # Load space character
    		syscall

    		# Increment the current number (t1)
    		addi $t1, $t1, 1

    		# Recursive call
    		jal rec_sumsq

	rec_exit:
   		jr $ra              # Return to caller
