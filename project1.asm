#
#	Author: Pranav Joseph
#	Date: 08/25/2024
#	Location: UTD
#

.include "SysCalls.asm"
.data 
	name:	  .space 128
	nameMsg:  .asciiz "Enter your name: "
	intMsg:	  .asciiz "Enter one integer from 1-50: "
	sportMsg: .asciiz "Enter your favorite sport: "
	
.text
	li $v0, SysPrintString # service call: print string (SysCalls.asm)
	la $a0, nameMsg        # load address of string to $a0 
	syscall		       # run system call
	
	li $v0, SysReadString  # service call: read integer from keyboard to $v0
	la $a0, name
	li $a1, 128
	syscall
