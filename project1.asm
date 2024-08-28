#
#	Author: Pranav Joseph
#	Date: 08/25/2024
#	Location: UTD
#

.include "SysCalls.asm"
.data 
	name:	     		.space 128
	sport:			.word 
	nameMsg:     		.asciiz "Enter your name: "
	intMsg:	     		.asciiz "Enter one integer from 1-50: "
	sportMsg:    		.asciiz "Enter your favorite sport: "
	askSport:		.asciiz "Enter your favorite sport: "
	greetings:   		.asciiz "Greetings: "
	intsEntered: 		.asciiz "I see that you entered the integers "
	sportDisplay:		.asciiz "Based on your input the score for the "
	game: 			.asciiz "game will be "
	to:			.asciiz " to "
	
.text
	li $v0, SysPrintString 	# service call: print string (SysCalls.asm)
	la $a0, nameMsg        	# load address of string to $a0 
	syscall		       	# run system call
	
	li $v0, SysReadString  	# service call: read name from keyboard to $v0
	la $a0, name	       	# load address of name to $a0
	li $a1, 128	       	# set maximum amount of characters
	syscall		      	# run system call 
		
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
		
	li $v0, SysPrintString 	# service call: print string
	la $a0, askSport	# load address of string to $a0
	syscall			# run system call
	
	li $v0, SysReadString  	# service call: read name from keyboard to $v0
	la $a0, sport	       	# load address of name to $a0
	lw $t8, 0($a0)	       	# set maximum amount of characters
	syscall
	
	li $v0, SysPrintString 	# service call: print string
	la $a0, greetings	# load address of string to $a0
	syscall			# run system call 
	
	li $v0, SysPrintString	# service call: print string
	la $a0, name		# load address of string to $a0
	syscall			# run system call 
	
	li $v0, SysPrintString	# service call: print string
	la $a0, intsEntered	# load address of string to $a0
	syscall			# run system call 
	
	li $v0, SysPrintInt  	# service call: print integer (SysCalls.asm)
	move $a0, $s0		# $a0 = $s0
	syscall			# run system call
	
	li $v0, SysPrintChar	# service call: print char
	la $a0, ' '		# load address of character to $a0
	syscall			# run system call
	
	li $v0, SysPrintInt  	# service call: print integer (SysCalls.asm)
	move $a0, $s1		# $a0 = $s0
	syscall			# run system call
	
	li $v0, SysPrintChar	# service call: print char
	la $a0, '\n'		# load address of character to $a0
	syscall			# run system call
	
	li $v0, SysPrintString 	# service call: print string (SysCalls.asm)
	la $a0, sportDisplay    # load address of string to $a0 
	syscall		       	# run system call
	
	li $v0, SysPrintString 	# service call: print string (SysCalls.asm)
	la $a0, sport        	# load address of string to $a0 
	syscall		       	# run system call
	
	li $v0, SysPrintString 	# service call: print string (SysCalls.asm)
	la $a0, game        	# load address of string to $a0 
	syscall		       	# run system call
	
	add $t0, $s0, $s0     	# a+a into $t0
	add $t1, $t0, $s0	# 2a+a into $t1
	add $t2, $s1, $s1	# b+b into $t2
	sub $t3, $t1, $t2       #3a-2b
	add $s2, $t3, 32	#3a-2b+32
	
	li $v0, SysPrintInt  	# service call: print integer (SysCalls.asm)
	move $a0, $s2		# $a0 = $s0
	syscall			# run system call
	
	sub $t0, $t2, $s0	# 2b-a
	sub $s3, $t0, 12	# 2b-a-12
	
	li $v0, SysPrintString 	# service call: print string (SysCalls.asm)
	la $a0, to        	# load address of string to $a0 
	syscall		       	# run system call
	
	
	li $v0, SysPrintInt  	# service call: print integer (SysCalls.asm)
	move $a0, $s3		# $a0 = $s0
	syscall			# run system call
	
	li $v0, SysExit		#exit
	syscall
