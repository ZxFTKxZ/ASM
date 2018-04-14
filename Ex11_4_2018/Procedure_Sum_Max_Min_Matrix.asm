.data
	darray: .double 0
	space: .asciiz " "
	newline: .asciiz "\n"
	promptin: .asciiz "Please set the value of each element in array:\n"
	promptsum: .asciiz "\nSum of all element is: "
	promptmin: .asciiz "\nMin element of array is: "
	promptmax: .asciiz "\nMax element of array is: "
	.eqv NUMOFE 12
	.eqv ROWSIZE 4
	.eqv COLSIZE 3
	.eqv DDATASIZE 8
.text

main:

	la $a2, darray
	li $t2, 0
	li $t0, NUMOFE
	
	li $v0, 4
	la $a0, promptin
	syscall
	
	# Init a double array with user data
loop_init:
	li $v0, 7
	syscall
	s.d $f0, ($a2)
	addi $a2, $a2, 8
	addi $t2, $t2, 1
	beq $t2, $t0, endloop_init
	j loop_init
endloop_init:
	# 2D array with Row-major
	# addr = baseAddr + (rowIndex * colSize + colIndex) * dataSize
	# Print double array loop
	la $a2, darray	# load address of darray
	li $t0, NUMOFE	# $t0 = number of elements
	li $t1, 0	# i = 0 rowindex
	li $t2, 0	# j = 0	colindex
loopj:
	mul $t3, $t1, COLSIZE
	add $t3, $t3, $t2
	mul $t3, $t3, DDATASIZE
	add $a1, $a2, $t3
	
	li $v0, 3
	l.d $f12, ($a1)
	syscall
	
	addi $t2, $t2, 1
	beq $t2, COLSIZE, loopi
	li $v0, 4
	la $a0, space
	syscall
	j loopj
loopi:
	li $t2, 0
	add $t1, $t1, 1
	li $v0, 4
	la $a0, newline
	syscall
	beq $t1, ROWSIZE, endloopi
	j loopj
endloopi:

	la $a2, darray		# $a2 = array_double
	li $t0, NUMOFE		# $t0 = number of elements
	
	jal sumprocedure	# Call sum procedure the sum will be return at $f0
	
	# Print sum of all element of array
	li $v0, 3
	mov.d $f12, $f0
	syscall
	
	jal mmprocedure		# Call min max procedure the max will be return at $f0, min will be return at $f2
	j end			# jump to end

sumprocedure:
	li $t0, NUMOFE
	addi $sp, $sp, -12	# Allocate the memory of procedure
	sw $ra, 4($sp)		# save the return address at 4($sp) to restore in the future
	sw $a2, 0($sp)		# save the array address at 0($sp) to restore in the future
	li $t2, 0		# i = 0
	sub.d $f0, $f0, $f0	# sum = 0
	
loop_sum:
	
	l.d $f4, ($a2)		# load double which is store in $a2, $a1 to $f4
	add.d $f0, $f0, $f4	# sum = sum + $f4
	addi $a2, $a2, 8	# move to next element of array_double
	addi $t2, $t2, 1	# i++
	beq $t2, $t0, endloop_sum	# if (i == numofe) then break loop_sum
	j loop_sum		# jump to loop_sum
endloop_sum:
	lw $a2, 0($sp)		# store the value of array_double address from 0($sp)
	lw $ra, 4($sp)		# store the value of return address from 4($sp)
	addi $sp, $sp, 8	# Destroy the memory which was allocated in the beginning of procedure
	jr $ra			# jump to return address
	
mmprocedure:
	addi $sp, $sp, -8	# Allocate the memory of procedure
	sw $ra, 4($sp)		# save the return address at 4($sp) to restore in the future
	sw $a2, 0($sp)		# save the array address at 0($sp) to restore in the future
	li $t0, NUMOFE		# $t0 = number of elements
	li $t2, 0		# i = 0
	l.d $f0, ($a2)		# min = array[0]
	l.d $f2, ($a2)		# max = array[0]
loop_mm:
	l.d $f4, ($a2)		# load double which is store in $a2, $a1 to $f4
	c.lt.d  $f0, $f4	# if ($f0 < $f4) then set Condition Flag 0 true 
	bc1t end_if_min		# branch if the Condition Flag 0 is true
	mov.d  $f0, $f4
	
end_if_min:
	c.lt.d 1, $f4, $f2	# if ($f4 < $f2) then set Condition Flag 1 true
	bc1t 1, end_if_max	# branch if the Condition Flag 1 is true
	mov.d $f2, $f4		# $f2 = $f4
end_if_max:
	addi $a2, $a2, 8	# move to next element of array_double
	addi $t2, $t2, 1	# i++
	beq $t2, $t0, endloop_mm	# if (i == numofe) then break loop_sum
	j loop_mm		# jump to loop_mm
	
endloop_mm:
	lw $a2, 0($sp)		# store the value of array_double address from 0($sp)
	lw $ra, 4($sp)		# store the value of return address from 4($sp)
	addi $sp, $sp, 8	# Destroy the memory which was allocated in the beginning of procedure
	jr $ra			# jump to return address
end:
	# Print min and max of array
	li $v0, 4
	la $a0, promptmin
	syscall
	li $v0, 3
	mov.d $f12, $f0
	syscall
	li $v0, 4
	la $a0, promptmax
	syscall
	li $v0, 3
	mov.d $f12, $f2
	syscall
