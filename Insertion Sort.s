##
## 	Program Name:	Insertion Sort
##
##
## Algorithm:
## http://en.wikipedia.org/wiki/Insertion_sort
##
## C++ source:
## https://www.geeksforgeeks.org/insertion-sort/
##
##
## $t0: pointer to the array (this pointer will be controlled by int i)
## $t1: length of the array
## $t2: temp value holder
## $t3: pointer to the array (this pointer will be controlled by int j)
## $t4: key
## $t5: i counter
## $t6: j counter
## $t7: temp value holder
##
## 
## Assumption: No user input. Question does not say that we need to prompt the user for the array values.
##

#################################################
#                                               #
#               text segment                    #
#                                               #
#################################################

        .text
        .globl __start
__start:           	   	# execution starts here

	la $t0,array		# $t0 will point to the array (this will be used for i)
	lw $t1,count		# n
	
	la $a0,unsortedArray		# syscall to print out
	li $v0,4		# a new line
	syscall 
	
	la $a0,openBrack		# syscall to print out
	li $v0,4		# a new line
	syscall 
	
unsortArrayLoop:
	beq $t2, $t1, doneShowing
	
	lw $a0, ($t0)
	li $v0, 1      
    syscall
	
	la $a0,space		# syscall to print out
	li $v0,4		# a new line
	syscall 
	
	addi $t2, $t2, 1
	addi $t0, $t0, 4
	
	j unsortArrayLoop
	
doneShowing:
	la $a0,closeBrack		# syscall to print out
	li $v0,4		# a new line
	syscall 
	
	la $a0,endl		# syscal to print out
	li $v0,4		# a new line
	syscall 
	
	
	sub $t3,$t3,$t2		#reset $t2
	la $t0,array
	addi $t0, $t0, 4	# move element to arr[1]
	la $t3,array		# $t3 will point to the array (this will be used for j)
	addi $t3, $t3, 4	# move element to arr[1]
	lw $t1,count		# n
	addi $t5, $t5, 1	# i counter
	
	jal insertionSort
	
	doneFor:
	addi $t0,$t0,-4			# reset pointer to point at the last element
	sub $t1, $t1, $t1		# set $t1 to zero
	lw $t2, count
	
	la $a0,sortedArray		# syscall to print out
	li $v0,4				# a new line
	syscall 
	
	la $a0,openBrack		# syscall to print out
	li $v0,4				# a new line
	syscall 
	
	
arrayLoop:
	beq $t1, $t2, done
	
	lw $a0, ($t0)
	li $v0, 1      
    syscall
	
	la $a0,space		# syscall to print out
	li $v0,4			# a new line
	syscall 
	
	addi $t1, $t1, 1
	addi $t0, $t0, -4
	
	j arrayLoop
       
done:

	la $a0,closeBrack		# syscall to print out
	li $v0,4		# a new line
	syscall 
	
	la $a0,endl		# syscal to print out
	li $v0,4		# a new line
	syscall 

	li $v0,10		# Exit
	syscall			# Bye!
	
	
	

#################################################
#                                               #
#           Insertion Sort Procedure            #
#                                               #
#################################################
	

insertionSort:

forLoop:
	lw $t4,($t0)		# key = arr[i]
	
	move $s0, $t4		
	abs $s0, $s0		# set up abs value
	
	sub $t3,$t0,4		# j = i-1 (setup for the array)
	addi $t6, $t5, -1	# j counter
	
whileLoop:
	lw $t7,($t3)
	
	move $s1, $t7
	abs $s1, $s1		# set up abs value
	
	ble $s0,$s1,doneWhile		# end loop if key <= arr[j]
	blt $t6,0,doneWhile 		# end loop if j < 0

	lw $t2,($t3)		# $t2 is a temp value holder
	sw $t2,4($t3)		# arr[j+1] = arr[j];
	sub $t3,$t3,4		# j = j + 1
	addi $t6, $t6, -1	# j counter
	j whileLoop
	
doneWhile:
	sw $t4,4($t3)		# arr[j+1] = key
	addi $t5, $t5, 1	# i counter
	addi $t0, $t0, 4	# move element to next i
	blt $t5,$t1,forLoop	# if length is not reached, keep looping
	jr $ra
	
	
##**********************************************************************
		

#################################################
#                                               #
#               data segment                    #
#                                               #
#################################################

        .data
	array:	.word 3,-4,2,-6,12,-7,18,-26,2,-14,19,-7,-8,-12,13
	count:	.word 15
	
	unsortedArray:	.asciiz "Unsorted Array: "
	sortedArray:	.asciiz "\nSorted Array: "
	endl:	.asciiz "\n"	
	space:	.asciiz " "
	openBrack: .asciiz "{ "
	closeBrack: .asciiz "}"

##
## 	end of file min-max.s