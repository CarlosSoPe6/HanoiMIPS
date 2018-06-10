# ------ [ stackPop ] ----------------------
# 
# Retrive and remove a element from a stack
# param     $a0:    Stack ref
# return    $v0:    Element retrived  
stackPop:
    lw		    $t0, 0($s0)		# Load the stack's reference
    addi	    $t0, $t0, 4		# $t0 = $t0 + 4
    lw		    $v0, 0($v0)		# Load the stack value
    sw          $t0, 0($s0)     # Store the new stack reference
    lw		    $t0, 0($zero)	# Clear stack
    jr		    $ra				# jump to $ra 
    