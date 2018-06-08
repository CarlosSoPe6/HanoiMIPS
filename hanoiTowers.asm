	
          
.text    
	lui	$at, 0x1001
	ori 	$a0, $at , 0x0000 	# Pointer to stack A
	lui 	$at, 0x1001
	ori 	$a1, $at , 0x0050       # Pointer to stack B
	lui 	$at, 0x1001
	ori 	$a2, $at , 0x00A0       # Pointer to stack c  
		
main:	

        addi 	$a3, $zero, 6	       # N= Number of plates
	add 	$s0, $zero, $a3       # Stack A index
	addi 	$s1, $zero, 0	       # Stack B index
	addi 	$s2, $zero, 0	       # Stack C index
	addi	$s3, $zero, -1      # k (for counter)
	
for: 
	slt 	$t0, $s3, $a3	       # for(k=0; k < N; k++)
        addi    $s3, $s3, 1            # k++
        beq     $t0, $zero, endfor     # if t0==1 --> endfor
        sub     $t2, $a3, $s3  
        sll	$t1, $s3, 2    	       # Shift left i
	add 	$t1, $t1, $a0          # Adding an offset to the base address
	sw 	$t2, 0($t1)            # Loading data from memory (vector1)
        j 	for
endfor:               

	jal	hanoi

hanoi:  
        beq     $a3, $zero, exit       # The call ends when N=0
        jr       $ra

stackPop:

stackPush:

exit:
