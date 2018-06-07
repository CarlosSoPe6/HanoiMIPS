# ------ [ stackPop ] ----------------------
# 
# Retrive and remove a element from a stack
# param $a0:    Stack head
# param $a1:    Stack pointer
# return $v0:   Element retrived  
stackPop:
    addi        $t0, $t1, 0			# $t0 = $t1 + 0
    

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