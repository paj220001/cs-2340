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
	
	Exit:
		li $v0, SysExit
		Syscall
	
