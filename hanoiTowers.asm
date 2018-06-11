# hanoiTowers.asm
# Author: Carlos Soto Pérez
# Author: Salvador Cortez Gonz�lez
.text    
#------------------------------[Main function]-----------------------------------
#
# Initialize stack pointers to indicate where the stacks are located, define the
# number of plates and the index for every stack
main:	
	addi 	$at, $zero , 0x1001 	
	sll     $at, $at, 16
	ori 	$t0, $at , 0x0000 		# Stack A base
	
	addi 	$at, $zero , 0x1001 	
	sll     $at, $at, 16
	ori 	$t1, $at , 0x0080       # Stack B base
	
	addi 	$at, $zero , 0x1001 	
	sll     $at, $at, 16
	ori 	$t2, $at , 0x0100       # Stack C base

	# Store the int **
	addi 	$at, $zero , 0x1001 	
	sll     $at, $at, 16
	ori		$t3, $at, 0x0180
	add		$a0, $zero, $t3			# $a0 = $zero + $t3
									# the reference in a arg source
	sw		$t0, 0($t3)				# Store the stack A reference
	
	addi	$t3, $t3, 4				# $t3 = $t3 + 4
	add		$a1, $zero, $t3			# $a1 = $zero + $t3
									# the reference in a arg aux
	sw		$t1, 0($t3)				# Store the stack B reference
	
	addi	$t3, $t3, 4				# $t3 = $t3 + 4
	add		$a2, $zero, $t3			# $a2 = $zero + $t3
									# the reference in a arg ttarget
	sw		$t2, 0($t3)				# Store the stack C reference

	addi	$a3, $zero, 3			# $a3 = $zero + 3
									# Number of d
	

# ----------------------------[Filling clycle]------------------------------------
#
# Fill stackA with the N plates and its values
# param s3: for's counter = k
	lw		$t0, 0($a0)			# Load A stack reference 
	add		$t1, $zero, $a3		# $t1 = $zero + $a3
								# $t0 is a counter	
	
for: 
	beq		$t1, $zero, endfor			# if $t1 == $t0 then endfor
	sw 		$t1, 0($t0)             # Loading data from memory (vector1)
	addi	$t0, $t0, 4				# $t0 = $t0 + 4
	addi    $t1, $t1, -1            # k++
	j 		for
endfor:               
    sw		$t0, 0($a0)				# Store the new reference
	
	jal	hanoi
	jal end

#------------------------------[Hanoi Functio]--------------------------------------
#
# Determine the correct move to organize the towers following the given rules
# param a0: source pointer
# param a1: aux pointer
# param a2: target pointer
# param a3: number of plates = N

hanoi: 
	bne		$a3, $zero, loop	# if $a3 != $zero then loop
	jr      $ra

loop: 
        addi    $sp, $sp, -20           # Decreasing stack pointer
        sw		$ra, 0($sp)             # Storing return address
        sw		$a0, 4($sp)             # Storing stackA pointer 
        sw		$a1, 8($sp)             # Storing stackB pointer
        sw      $a2, 12($sp)            # Storing stackC pointer
        sw      $a3, 16($sp)            # Storing N
        addi 	$a3, $a3, -1
        
		jal     hanoi
        
        jal		stackPop                # Taking one plate
        add     $t2, $zero, $a1         # Backing aux value
		add		$a1, $zero, $v0			# $a1 = $zero + $v0
										# Load from source
        jal		stackPush               # Placing one plate
        add     $a1, $zero, $t2         # Restoring aux value
                                           
        add		$t3, $zero, $a1         # Backing aux
        add		$t4, $zero, $a2         # Backing target
        add		$a2, $zero, $a0         # Now a2 --> source
        add		$a1, $zero, $t4         # Now a1 --> target
        add		$a0, $zero, $t3         # Now a0 --> aux
        addi 	$a3, $a3, -1            # Decrement N
        jal     hanoi
        
        lw		$ra, 0($sp)         	# Loading return address
        lw		$a0, 4($sp)             # Loading stackA pointer
        lw		$a1, 8($sp)         	# Loading stackB pointer
        lw      $a2, 12($sp)        	# Loading stackC pointer
        lw      $a3, 16($sp)        	# Loading N
        addi    $sp, $sp, 20        	# Increasing stack pointer
        jr      $ra
        

# ------ [ stackPop ] ----------------------
# 
# Retrive and remove a element from a stack
# param     $a0:    Stack ref
# return    $v0:    Element retrived  
stackPop:
	lw		$t0, 0($a0)		# Load the stack's reference
	addi	$t0, $t0, -4	# $t0 = $t0 + -4
	lw		$v0, 0($t0)		# Load the stack value
	sw      $t0, 0($a0)     # Store the new stack reference
	sw		$zero, 0($t0)	# Clear stack
	jr		$ra				# jump to $ra 
    

# ------ [ stackPush ] ----------------------
# 
# Adds a element to the stack
# param     $a2:    Stack ref
# param     $a1:    Data to push
stackPush:
	lw	 	$t0, 0($a2)		# Load the stack's reference
	sw	 	$a1, 0($t0)		# Store at stack's reference
	addi	$t0, $t0, 4		# $t0 = $t0 + 4
	sw		$t0, 0($a2)		# Store the stack's reference
	jr	 	$ra		        # jump to $ra  
	

end:
