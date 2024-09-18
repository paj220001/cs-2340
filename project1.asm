#
#	Author: Pranav Joseph
#	Date: 09/17/2024
#	Location: UTD
#

.include "SysCalls.asm"
.data 
	intMsg:	     		.asciiz "Enter one integer from 1-50: "

	
.text
	li $v0, SysPrintString 	# service call: print string 
	la $a0, intMsg	       	# load address of string to $a0
	syscall		       	# run system call 
	
	li $v0, SysReadInt	# service call: read integer from keyboard to $v0
	syscall			# run system call
	move $s0, $v0		# $s0 = $v0
	
	li $v0, SysPrintString	# service call: print string 
	la $a0, intMsg		# load address of string to $a0
	syscall			# run system call
	
	li $v0, SysReadInt	# service call: read integer from keyboard to $v0
	syscall			# run system call
	move $s1, $v0		# $s0 = $v0
		
	li $v0, SysAlloc        # service call: read integer from keyboard to $v0
	li $v0, SysExit		#exit
	syscall
