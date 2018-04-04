# Calculate (4x + 5)/y
.data
	prompt1: .asciiz "Input x: "
	prompt2: .asciiz "\nInput y: "
	prompt3: .asciiz "Result of (4x + 5)/y is "
	prompt4: .asciiz " with the remainder is "
.text

main:
	# Input x
	li $v0, 4
	la $a0, prompt1
	syscall
	li $v0, 5
	syscall
	add $t0, $zero, $v0
	# Input y
	li $v0, 4
	la $a0, prompt2
	syscall
	li $v0, 5
	syscall
	add $t1, $zero, $v0

	# Calculate 4x
	sll $t0, $t0, 2
	
	# Calculate 4x + 5
	addi $t0, $t0, 5
	
	# Calculate (4x + 5)/y
	div $t0, $t1
	mflo $t3
	mfhi $t4
	# Display the result
	li $v0, 4
	la $a0, prompt3
	syscall
	li $v0, 1
	add $a0, $zero, $t3
	syscall
	li $v0, 4
	la $a0, prompt4
	syscall
	li $v0, 1
	add $a0, $zero, $t4
	syscall
