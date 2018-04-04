#void bubbleSort(int arr[], int n)
#{
#   int i, j;
#   for (i = 0; i < n-1; i++)       
#       // Last i elements are already in place   
#       for (j = 0; j < n-i-1; j++) 
#           if (arr[j] > arr[j+1])
#              {
#		int temp = arr[j];
#		arr[j] = arr[j+1];
#		arr[j+1] = temp;
#		}
#}
.data
	arr: .word 3, 0, 1, 2, 6, -2, 4, 7, 3, 7
	arr_length: .word 10

.text

	# Operation which can perform on an array
	#li $t2, 2		# put the index into $t2
	#add $t2, $t2, $t2	# double the index
	#add $t2, $t2, $t2	# double the index again
	#add $t1, $t2, $t3	# combine the two components of the address
	#lw $t4, 0($t1)		# get the value from the array cell
	#sw $t4, ($t1)		# store the value into the array cell
	
	# Print the value of arr[6]
	#li $v0, 1
	#add $a0, $zero, $t4
	#syscall
	
	# Print the array
	#li $t0, 10		# t0 is a constant 10
	#li $t1, 0		# t1 is our counter (i)
	#lw $t2, arr		# load the first array value into t2
	
	
	
max:
	li $a1, 10
	la $a0, arr
	lw $t0, 0($a0) # load the first array value into t0
	li $t1, 1 # initialize the counter to one
loop:
	beq $t1, $a1, exit # exit if we reach the end of the array
	addi $a0, $a0, 4 # increment the pointer by one word
	addi $t1, $t1, 1 # increment the loop counter
	lw $t2, 0($a0) # store the next array value into t2
	ble $t2, $t0, end_if
	move $t0, $t2 # found a new maximum, store it in t0
end_if:
	j loop # repeat the loop
exit:	
	add $v0, $zero, 1
	add $a0, $zero, $t0
	syscall
	
