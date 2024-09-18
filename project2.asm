#
#	Author: Pranav Joseph
#	Date: 09/17/2024
#	Location: UTD
#

.include "SysCalls.asm"
.data 
	intMsgx:	     		.asciiz "Enter one integer from 2-50: "
	intMsgy:	     		.asciiz "Enter one integer from 0-50: "
	beforeMsg:	     		.asciiz "Before: "
	afterMsg:	     		.asciiz "After Sort: "
	afterRe:	     		.asciiz "After Rearrange: "

	
.text
	li $v0, SysPrintString 	# service call: print string 
	la $a0, intMsgx	       	# load address of string to $a0
	syscall		       	# run system call 
	
	li $v0, SysReadInt	# service call: read integer from keyboard to $v0
	syscall			# run system call
	move $s0, $v0		# $s0 = $v0
	
	li $v0, SysPrintString	# service call: print string 
	la $a0, intMsgy		# load address of string to $a0
	syscall			# run system call
	
	li $v0, SysReadInt	# service call: read integer from keyboard to $v0
	syscall			# run system call
	move $s1, $v0		# $s0 = $v0
		
	li $v0, SysAlloc        # service call: load Sysalloc to $v0
	move $a0, $s0		# load the x value into $a0
	syscall			# run system call
	move $s3, $v0		# move array into $s3
	
	li $t0, 0    	# set $t0 to the 0 value
	getNumbers:
		beq $t0, $s0, Exit1    # If index equals size, exit the loop
		
		li $v0, SysRandIntRange
		move $a1, $s1
		syscall 
		
		sll $t3, $t0, 2
		add $t4, $s3, $t3
		sw $a0, 0($t4)
		
    		
    		addi $t0, $t0, 1
    		bne $t0, $s0, getNumbers
    		
    	Exit1: 
 
 	li $t0, 0    	# set $t0 to the 0 value
	printNumbers: 
		beq $t0, $s0, Exit2    # If index equals size, exit the loop
		
		li $v0, SysPrintInt  	# service call: print integer (SysCalls.asm)
		sll $t3, $t0, 2
		add $t4, $s3, $t3
		lw $a0, 0($t4)		# $a0 = $s0
		syscall			# run system call
	
		li $v0, SysPrintChar
		li $a0, ' '
		syscall
		addi $t0, $t0, 1
		bne $t0, $s0, printNumbers
	
	Exit2:
	
	
   	 # Initialization
    	li $t0, 0          # i = 0 (Outer loop index)
    	li $t1, 5          # array length (n)
    	li $t2, 4          # size of an integer (in bytes)
    
	outer_loop:
    		li $t3, 0          # j = 0 (Inner loop index)
    
	inner_loop:
    		# Calculate addresses of array[j] and array[j+1]
    		sll $t4, $t3, 2    # $t4 = j * 4 (offset for array[j])
    		add $t5, $s3, $t4  # $t5 = base_address + j * 4 (address of array[j])
    		lw $a0, 0($t5)     # $a0 = array[j]
    
    		addi $t4, $t4, 4   # $t4 = (j + 1) * 4 (offset for array[j + 1])
    		add $t6, $s3, $t4  # $t6 = base_address + (j + 1) * 4 (address of array[j + 1])
    		lw $a1, 0($t6)     # $a1 = array[j + 1]
    
    		# Compare array[j] and array[j + 1]
   		slt $t7, $a1, $a0  # $t7 = ($a1 < $a0) ? 1 : 0
    		beq $t7, 1, swap   # If $t7 == 1, branch to 'swap'
    
    		j no_swap          # Otherwise, jump to 'no_swap'

	swap:
    		# Swap array[j] and array[j + 1]
    		sw $a1, 0($t5)     # Store $a1 (array[j + 1]) into array[j]
    		sw $a0, 0($t6)     # Store $a0 (array[j]) into array[j + 1]
    
	no_swap:
    		addi $t3, $t3, 1   # j = j + 1
    		blt $t3, $t1, inner_loop  # If j < n - i - 1, continue inner loop
    
    		addi $t0, $t0, 1   # i = i + 1
    		bne $t0, $t1, outer_loop  # If i < n - 1, continue outer loop
	
		j printSortedNumbers
		
	li $t0, 0 
	printSortedNumbers: 
		beq $t0, $s0, Exit2    # If index equals size, exit the loop
		
		li $v0, SysPrintInt  	# service call: print integer (SysCalls.asm)
		sll $t3, $t0, 2
		add $t4, $s3, $t3
		lw $a0, 0($t4)		# $a0 = $s0
		syscall			# run system call
	
		li $v0, SysPrintChar
		li $a0, ' '
		syscall
		addi $t0, $t0, 1
		bne $t0, $s0, printSortedNumbers	
	
			
			

