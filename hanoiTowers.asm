
.data

	lui	$at, 0x1001
	ori 	$a0, $at , 0x0000 	# Pointer to stack A
	lui 	$at, 0x1001
	ori 	$a1, $at , 0x0050       # Pointer to stack B
	lui 	$at, 0x1001
	ori 	$a2, $at , 0x00A0       # Pointer to stack c
          
.text      
		
main:	

        addi 	$a3, $zero, 6;	       # N= Number of plates
	add 	$s0, $zero, $a3 ;      # Stack A index
	addi 	$s1, $zero, 0;	       # Stack B index
	addi 	$s2, $zero, 0;	       # Stack C index
	addi	$s3, $zero, $zero      # k (for counter)
	
for: 
	slti 	$t0, $s3, $a3	       # for(k=0; k < N; k++)
        addi    $s3, $s3, 1            # k++
        beq     $t3, $zero, endfor     # if t0==1 --> endfor
        j 	for
endfor:               

	jal	hanoi

hanoi:  
        beq     $a3, $zero, exit       # The call ends when N=0
        j       $ra

stackPop:

stackPush:

exit:
