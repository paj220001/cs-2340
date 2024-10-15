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
	li $v0, SysOpenFile	#system call open file 
	la $a0, fileName	#store the file name into a0
	li $a1, 0		#read only file 
	syscall			#runs system call
	move $s0, $v0		#move v0 into s0
	
	li $v0, SysReadFile	#system call read file 
	move $a0, $s0		#move s0 into a0
	la $a1, intMsgX		#load address of intMsgx into a1
	la $a2, 52		#read 52 bytes 
	syscall			#run system call 
	
	li $v0, SysReadFile	#system call read file 	
	move $a0, $s0		#move s0 into a0
	la $a1, x		#load address of x into a1
	la $a2, 1		#read 1 byte
	syscall			#run system call 
	
	li $v0, SysReadFile	#system all read file 
	move $a0, $s0		#move s0 into a0
	la $a1, beforeMsg	#load address of beforeMsg into a1
	la $a2, 33		#read 32 bytes
	syscall			#run system call
	
	li $v0, SysReadFile	#system call read file 
	move $a0, $s0		#move s0 into a0
	la $a1, afterMsg	#load address of afterMsg into a1
	la $a2, 26		#read 26 bytes 
	syscall			#run system call 
	
	li $v0, SysReadFile	#system call read file 
	move $a0, $s0		#store s0 into a0
	la $a1, x		#load address of x into a1
	la $a2, 1		#read 1 byte
	syscall			#run system call 
	
	li $v0, SysReadFile	#system call read file
	move $a0, $s0		#move s0 into a0
	la $a1, from		#load address of from into a1
	la $a2, 21		#read 21 bytes
	syscall			#run system call
	
	li $v0, SysReadFile	#system call read file 
	move $a0, $s0		#move s0 into a0
	la $a1, to		#load address of to into a1
	la $a2, 4		#read 4 bytes 
	syscall			#run system call
	
	li $v0, SysReadFile	#system call read file 
	move $a0, $s0		#move s0 into a0
	la $a1, iterative	#store address of iterative into a1
	la $a2, 12		#read 12 bytes 
	syscall			#run system call 
	
	li $v0, SysReadFile	#system call read file
	move $a0, $s0		#move s0 into a0
	la $a1, recursive	#store address of recursive into a1
	la $a2, 12		#read 12 bytes
	syscall			#run system call 
	
	li $v0, SysPrintString 	#system call print string
	la $a0, intMsgX		#store address of intMsgx into a0
	syscall			#run system call 
	
	li $v0, SysReadInt	#system call read integer
	syscall			#run system call
	sw $v0, x		#store integer into x
	
	lw $t0, x		#store x into t1
	beq $t0, $zero, Exit	#if x = 0 exit the program
		
	li $v0, SysPrintString 	#system call print string 
	la $a0, beforeMsg	#store address of beforeMsg
	syscall			#run system call 
	
	li $v0, SysPrintInt	#system call print int 
	lw $a0, x		#store x into a0
	syscall			#run system call
	
	li $v0, SysPrintString 	#system call print string
	la $a0, afterMsg	#store address of afterMsg into a0
	syscall			#run system call 
	
	li $v0, SysReadInt	#system call print int
	syscall			#run system call
	sw $v0, y		#store int into y
	
	lw $t1, y		#store value of y into t1
	sub $t2, $t0, 1      	# t2 = x - 1
    	slt $t3, $t1, $t2    	# t3 = (y < x - 1) ? 1 : 0
    	bne $t3, $zero, Exit 	# if (y < x - 1) jump to exit
	beq $t1, $zero, Exit 	# if y = 0 jump to exit
	
	li $v0, SysPrintString 	#system call print string 
	la $a0, from		#store the address of from into a0
	syscall			#run system call 
	
	li $v0, SysPrintInt	#system call print int 
	lw $a0, x		#load x into a0
	syscall			#run system call
	
	li $v0, SysPrintString 	#system call print string 
	la $a0, to		#load address of to into a0
	syscall			#run system call
	
	li $v0, SysPrintInt	#system call print integer
	lw $a0, y		#load value of y into a0
	syscall			#system call print int 
	
	li $v0, SysPrintString 	#system call print string 
	la $a0, iterative	#store address of iterative into a0
	syscall			#run system call
	
	la $s0, 0		#load 0 into s0
	lw $t1, x		#load x value into t1
	lw $t2, y		#load y value into t2
	addi $t2, $t2, 1	# t2 = t2 + 1
	itr_sumsq:
		mul $t3 , $t1 , $t1	#t3 = t1 * t1
		
		add $s0, $s0, $t3	#s0 = s0 + t3
		
		li $v0, SysPrintInt	#system call print int 
		move $a0, $s0		#move a0 into s0
		syscall			#run system call
		
		li $v0, SysPrintChar	#system call print int
		li $a0, ' '		#load space into a0
		syscall			#run system call
		
		addi $t1, $t1, 1	#t1 = t1 + 1
		bne $t1, $t2, itr_sumsq	#if t1 != t2 then go again 
		
	itr_exit: 
	
	li $v0, 11         	# Print character syscall
    	li $a0, '\n'        	# Load space character
    	syscall			#fun system call 
	
	li $v0, SysPrintString 	#system call print string
	la $a0, recursive	#store address of reursive into a0
	syscall			#run system call 
	
	la $s0, 0           	# Initialize sum to 0 (s0 will hold the sum)
    	lw $t1, x           	# Load the value of x into $t1
    	lw $t2, y           	# Load the value of y into $t2
    	addi $t2, $t2, 1    	#t2 = t2 + 1
	
	jal rec_sumsq		#jump to function 
	
	
	Exit:
		li $v0, SysExit	#system call exit
		Syscall		#run system call 
	
	rec_sumsq:
    		bge $t1, $t2, rec_exit	#if t1 (current number) >= t2 (limit), return

    		mul $t3, $t1, $t1	# t3 = t1 * t1

    		add $s0, $s0, $t3	# s0 = s0 + t3

    		
    		li $v0, SysPrintInt     # Print integer syscall
    		move $a0, $s0      	# Move sum to $a0
    		syscall			#run system call

    		
    		li $v0, SysPrintChar	#system call print char
    		li $a0, ' '        	# Load space character
    		syscall			#run system call

    		addi $t1, $t1, 1	#t1 = t1 + 1

    		jal rec_sumsq		#jump into function again

	rec_exit:
   		jr $ra              # Return to caller
