.data
	prompt1: .asciiz	"Enter your multiplicand: "
	prompt2: .asciiz	"Enter your multiplier: "
	prompt3: .asciiz	"The value of high register: "
	prompt4: .asciiz	"\nThe value of low register: "
.text
	#Prompt the user to enter multiplicand
	li $v0, 4
	la $a0, prompt1
	syscall
	
	#Get the user multiplicand
	li $v0, 5
	syscall
	addu $a1, $zero, $v0
	
	#Prompt the user to enter multiplier
	li $v0, 4
	la $a0, prompt2
	syscall
	
	#Get the user multiplier
	li $v0, 5
	syscall
	addu $a2, $zero, $v0
	
	#Multiplicant
	mulo $a1,$a2
	
	#Prompt the high register value
	li $v0, 4
	la $a0, prompt3
	syscall
	mfhi $a1
	li $v0, 1
	add $a0,$zero, $a1
	syscall
	
	#Prompt the low register value
	li $v0, 4
	la $a0, prompt4
	syscall
	mflo $a2
	li $v0, 1
	add $a0, $zero, $a2
	syscall
	

