# MIPS program that calculate the operation 5x + 3y + z, with x, y, z is integer.
# by Hoang The Hop


.data
	promptx: .asciiz "\nEnter the value of x: \n"
	prompty: .asciiz "\nEnter the value of y: \n"
	promptz: .asciiz "\nEnter the value of z: \n"
	promptr: .asciiz "\nResult of 5x + 3y + z is: "
.text
	#Prompt the user to enter x
	li $v0, 4
	la $a0, promptx
	syscall
	
	#Get the value of x
	li $v0, 5
	syscall
	
	#Store the value of x
	move $t0,$v0
	
	#Calculate 5x and store in $s0
	addi $t1, $zero, 5
	mult $t0, $t1
	mflo $s0
	
	#Display the value 5x
	#li $v0, 1
	#add $a0, $zero, $s0
	#syscall
	
	#Prompt the user to enter y
	li $v0, 4
	la $a0, prompty
	syscall
	
	#Get the value of y
	li $v0, 5
	syscall
	
	#Store the value of y
	move $t0,$v0
	
	#Calculate 3y and store in $s1
	addi $t1, $zero, 3
	mult $t0, $t1
	mflo $s1
	
	#Calculate 5x + 3y and store in $s0
	add $s0, $s0, $s1
	
	#Print the value of 5x + 3y
	#li $v0, 1
	#move $a0, $s0
	#syscall
	
	#Prompt the user to enter z
	li $v0, 4
	la $a0, promptz
	syscall
	
	#Get the value of z
	li $v0, 5
	syscall
	
	#Store the value of z
	move $t0, $v0
	
	#Calculate the value of 5x + 3y + z
	add $s0, $s0, $t0
	
	#Display the value of result
	li $v0, 4
	la $a0, promptr
	syscall
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	#addi $t0, $zero, 5
	#addi $t1, $zero, 9
	
	#mult $t0, $t1
	
	#mflo $s0
	
	#li $v0, 1
	#add $a0, $zero, $s0