# hanoiTowers.asm
# Author: Carlos Soto PÃ©rez
# Author: Salvador Cortez González
.text    
#------------------------------[Main function]-----------------------------------
#
# Initialize stack pointers to indicate where the stacks are located, define the
# number of plates and the index for every stack

	ori 	$a0, $at , 0x1001 	
	sll     $a0, $a0, 16
	addi 	$a0, $a0 , 0x0000 	# Pointer to stack A
	ori 	$a1, $at , 0x1001 	
	sll     $a1, $a1, 16
	addi 	$a1, $a1 , 0x0050       # Pointer to stack B
	ori 	$a2, $at , 0x1001 	
	sll     $a2, $a1, 16
	addi 	$a2, $a2 , 0x00A0       # Pointer to stack c  
		
main:	

        addi 	$a3, $zero, 6		# N= Number of plates
	add 	$s0, $zero, $a3         # Stack A index
	addi 	$s1, $zero, 0	        # Stack B index
	addi 	$s2, $zero, 0	        # Stack C index
	addi	$s3, $zero, -1          # k (for counter)

# ----------------------------[Filling clycle]------------------------------------
#
# Fill stackA with the N plates and his values
# param s3: for's counter = k
		
for: 
	sub 	$t0, $s3, $a3	        # for(k=0; k < N; k++)
	srl     $t0, $t0, 31
        addi    $s3, $s3, 1             # k++
        beq     $t0, $zero, endfor      # if t0==1 --> endfor
        sub     $t2, $a3, $s3  
        sll	$t1, $s3, 2    	        # Shift left i
	add 	$t1, $t1, $a0           # Adding an offset to the base address
	sw 	$t2, 0($t1)             # Loading data from memory (vector1)
        j 	for
endfor:               
       
	jal	hanoi

#------------------------------[Hanoi Functio]--------------------------------------
#
# Determine the correct move to organize the towers following the given rules
# param a0: pointer to stackA
# param a1: pointer to stackB
# param a2: pointer to stackC
# param a3: number of plates = N

hanoi: 
        add 	$s0, $zero, $a3
        slti 	$t0, $a3, 1 		# Execute until N=0
	beq 	$t0, $zero, loop 	# Branch to loop
	jr      $ra

loop: 
        addi    $sp, $sp, -20           # Decreasing stack pointer
        sw	$ra, 0($sp)             # Storing return address
        sw	$a0, 4($sp)             # Storing stackA pointer 
        sw	$a1, 8($sp)             # Storing stackB pointer
        sw      $a2, 12($sp)            # Storing stackC pointer
        sw      $a3, 16($sp)            # Storing N
        subi    $a3, $a3, 1             # Decrement N
        jal     hanoi
        
        jal	stackPop                # Taking one plate
	add	$a1, $zero, $v0		# $a1 = $zero + $v0
					# Load from source
        jal	stackPush               # Placing one plate
        
        subi    $a3, $a3, 1             # Decrement N
        jal     hanoi
        
        lw	$ra, 0($sp)         	# Loading return address
        lw	$a0, 4($sp)             # Loading stackA pointer
        lw	$a1, 8($sp)         	# Loading stackB pointer
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
    	lw	$t0, 0($s0)		# Load the stack's reference
    	addi	$t0, $t0, 4		# $t0 = $t0 + 4
    	lw	$v0, 0($v0)		# Load the stack value
    	sw      $t0, 0($s0)     	# Store the new stack reference
	lw	$t0, 0($zero)		# Clear stack
    	jr	$ra			# jump to $ra 
    

# ------ [ stackPush ] ----------------------
# 
# Adds a element to the stack
# param     $a0:    Stack ref
# param     $a1:    Data to push
stackPush:
    	lw	 $t0, 0($s0)		# Load the stack's reference
   	sw	 $a1, 0($t0)		# Store at stack's reference
    	addi	 $t0, $t0, -4		# $t0 = $t0 + -4
    	jr	 $ra		        # jump to $ra  
       

exit:
