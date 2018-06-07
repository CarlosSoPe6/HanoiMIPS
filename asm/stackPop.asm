# ------ [ stackPop ] ----------------------
# 
# Retrive and remove a element from a stack
# param $a0:    Stack head
# param $a1:    Stack pointer
# return $v0:   Element retrived  
stackPop:
    lw		$t0, 0($a1)		        # Load $t0 = *$a1 
    bne		$t0, $zero, sptrZero	# if $t0 != $zero then sptrZero
    addi	$t0, $t0, -1			# $t0 = $t0 + -1
    sw		$t0, 0($a1)		        # Store *$a1 = $t0
    sptrZero:
    sll     $t0, $t0, 2             # $t1 = $a1 << 2
    add		$t0, $a0, $t0		    # $t0 = $a0 + $t0
    lw		$v0, 0($t1)		        # Load $v0 = *$t0
    jr $ra

# Comment std
_division:
    slt     $t0, $a1, $a0
    addi    $v0, $zero, 0
    addi    $t1, $zero, 1
    beq		$t0, $t1, loop	    # if $t0 == $t1 then loop
    jr      $ra 

loop:
    sub		$a0, $a0, $a1		# $a0 = $a0 - $a1
    addi	$sp, $sp, -4		# $sp = $sp - 4
    sw      $ra, 0($sp)         # Storing n
    jal     _division
    addi    $v0, $v0, 1         # $v0 = $v0 + 1
    lw      $ra, 0($sp)         # Loading values from stak
    addi	$sp, $sp, 4		    # $sp = $sp + 4
    jr      $ra