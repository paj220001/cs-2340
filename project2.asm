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
	
	li $t0, 2
	blt $s0, $t0, error
	
	li $t0, 50
	bgt, $s0, $t0, error
	
	li $v0, SysPrintString	# service call: print string 
	la $a0, intMsgy		# load address of string to $a0
	syscall			# run system call
	
	li $v0, SysReadInt	# service call: read integer from keyboard to $v0
	syscall			# run system call
	move $s1, $v0		# $s0 = $v0
	
	li $t0, 2
	blt $s0, $t0, error
	
	li $t0, 50
	bgt, $s0, $t0, error
	
		
	li $v0, SysAlloc        # service call: load Sysalloc to $v0
	move $a0, $s0		# load the x value into $a0
	syscall			# run system call
	move $s3, $v0		# move array into $s3
	
	li $t0, 0    	# set $t0 to the 0 value
	getNumbers:
		beq $t0, $s0, Exit1    # If index equals size, exit the loop
		
		li $v0, SysRandIntRange	#service call: load SysRandIntRange to $v0
		move $a1, $s1		#store the contents of s1 into a1
		syscall 		# run sytem call 
		
		sll $t3, $t0, 2		#shift left to get the array address for the element 
		add $t4, $s3, $t3	#base address plus address of array 
		sw $a0, 0($t4)		#store the value into the array
		
    		
    		addi $t0, $t0, 1	#increment t0 by 1
    		bne $t0, $s0, getNumbers# if t0 does not equal the amount of vaules in the array, get another number 
    		
    	Exit1:
    	
 	li $v0, SysPrintString	# service call: print string 
	la $a0, beforeMsg	# load address of string to $a0
	syscall			# run system call
	
	
 	li $t0, 0    	# set $t0 to the 0 value
	printNumbers: 
		beq $t0, $s0, Exit2    # If index equals size, exit the loop
		
		li $v0, SysPrintInt  	# service call: print integer (SysCalls.asm)
		sll $t3, $t0, 2		#shift left to get the array address for the element 
		add $t4, $s3, $t3	#base address plus address of array
		lw $a0, 0($t4)		# store the element of the array into a0
		syscall			# run system call
	
		li $v0, SysPrintChar	#service call: print character
		li $a0, ' '		#store the character into a0
		syscall			# run system call 
		addi $t0, $t0, 1	#increment t0 by 1
		bne $t0, $s0, printNumbers #if t0 does not equal the number of elements in the array then continue
	
	Exit2: #exit function
	
	
   	 # Initialization
    	li $t0, 0          	# i = 0 (Outer loop index)
    	move $t1, $s0      	# array length (n)
	subi $t2, $s0, 1	#t2 = s0-1	
    
	outer_loop:
    		li $t3, 0          # j = 0 (Inner loop index)
    
	inner_loop:
    		# Calculate addresses of array[j] and array[j+1]
    		sll $t4, $t3, 2    # shift left to get the array address for the element 
    		add $t5, $s3, $t4  # base_address + address of array
    		lw $a0, 0($t5)     # $a0 = array[j]
    
    		addi $t4, $t4, 4   # shift left again to get address of array i + 1
    		add $t6, $s3, $t4  # base address + address of array i + 1
    		lw $a1, 0($t6)     # $a1 = array[j + 1]
    
    		# Compare array[j] and array[j + 1]
   		slt $t7, $a1, $a0  # return 1 if a1 is < a0
    		beq $t7, 1, swap   # If $t7 == 1, branch to 'swap'
    
    		j no_swap          # Otherwise, jump to 'no_swap'

	swap:
    		# Swap array[j] and array[j + 1]
    		sw $a1, 0($t5)     # Store $a1 (array[j + 1]) into array[j]
    		sw $a0, 0($t6)     # Store $a0 (array[j]) into array[j + 1]
    
	no_swap:
    		addi $t3, $t3, 1   	# j = j + 1
    		blt $t3, $t2, inner_loop# If j < n - i - 1, continue inner loop
    
    		addi $t0, $t0, 1   	# i = i + 1
    		beq $t0, $t1, exit4  	# If i < n - 1, continue outer loop
    		j outer_loop 		# return to outer loop 	
	exit4: # exit 
	
	li $v0, SysPrintChar	# service call: print char
	li $a0, '\n'		# store char into a0 
	syscall			# run system call 
	
	li $v0, SysPrintString	# service call: print string 
	la $a0, afterMsg	# load address of string to $a0
	syscall			# run system call
		
	li $t0, 0 		#set counter o 0
	printSortedNumbers: 
		beq $t0, $s0, Exit2    # If index equals size, exit the loop
		
		li $v0, SysPrintInt  	# service call: print integer 
		sll $t3, $t0, 2		# get the address of array
		add $t4, $s3, $t3	# base adress + address of array
		lw $a0, 0($t4)		# $a0 = array[i]
		syscall			# run system call
	
		li $v0, SysPrintChar	# sercice call : print char 
		li $a0, ' '		# store character into a0	
		syscall			# run system call 
		
		addi $t0, $t0, 1	#increment t0 by 1
		bne $t0, $s0, printSortedNumbers	#if t0 is not equal to s0 continue
	
	li $t0, 0    	# set $t0 to the 0 value
	subi $t9, $s0, 1	# t9 = s0 - 1
	rearrange:
		beq $t0, $t9, exit5	#if t0 = t9 exit
		addi $t1, $t0, 1	# t1 = t0 + 1
		div $t1, $t1, 2		# t1 = t1 / 2
		mfhi $t2		# t2 = remainder 
		 
		# Calculate addresses of array[j] and array[j+1]
    		sll $t4, $t0, 2    # shift left to get the array address for the element
    		add $t5, $s3, $t4  # $t5 = base_address + address of array
    		lw $a0, 0($t5)     # $a0 = array
    
    		addi $t4, $t4, 4   # shift left to get the array address for the element i + 1
    		add $t6, $s3, $t4  # $t6 = base_address + (address of arrayj + 1
    		lw $a1, 0($t6)     # $a1 = array[j + 1]
    		beq $a1, $a0, increase # if a1 = a0 no swap increase count
    		bne $t2, 0, else 	# if element is odd
    		
    		# Compare array[j] and array[j + 1]
   		slt $t7, $a1, $a0  # if a1 < a0 store 1 into array
    		beq $t7, 1, swap1  # If $t7 == 1, branch to 'swap'
    		addi  $t0, $t0, 1 # increment t0 by 1 
    		bne $t0, $t9, rearrange	#if t0 is not the same as t9 do it again	
    		j exit5 	# else exit 
    		
    		
	swap1:
		# Swap array[j] and array[j + 1]
    		sw $a1, 0($t5)     # Store $a1 (array[j + 1]) into array[j]
    		sw $a0, 0($t6)     # Store $a0 (array[j]) into array[j + 1]
    		addi  $t0, $t0, 1 # increment t0 by 1
    		j rearrange 
    		
    		
    		
	else: 
		sgt $t7, $a1, $a0  	# $t7 = ($a1 < $a0) ? 1 : 0
		beq $t7, 1, swap1   	# If $t7 == 1, branch to 'swap'
		j rearrange 		# jump to rearrange
    		
    	increase: 
    		addi  $t0, $t0, 1	# icrement t0
    		j rearrange		# jump back to rearrange 
    		
	exit5:	#exit
	
	
	li $v0, SysPrintChar	# service call: print char
	li $a0, '\n'		# store the character into a0
	syscall			# run system call
	
	li $v0, SysPrintString	# service call: print string 
	la $a0, afterRe		# load address of string to $a0
	syscall			# run system call
		
	li $t0, 0		# set counter to 0
	printLast:
		beq $t0, $s0, Exit6    # If index equals size, exit the loop
		
		li $v0, SysPrintInt  	# service call: print integer 
		sll $t3, $t0, 2		# shift left to get the array address for the element
		add $t4, $s3, $t3	# t4 = base array + address of array i
		lw $a0, 0($t4)		# $a0 = array[i]
		syscall			# run system call
	
		li $v0, SysPrintChar	# service call print character
		li $a0, ' '		# store character into a0
		syscall			# run system call
		
		addi $t0, $t0, 1	#increment t0 by 1	
		bne $t0, $s0, printLast	#if t0 does not equal 1 continue
		
	Exit6:	
		li $v0, SysExit		# service call: exit
		syscall			# run system call 
		
	error:
		li $v0, SysExit
		syscall
