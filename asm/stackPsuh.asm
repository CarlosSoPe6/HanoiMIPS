# ------ [ stackPush ] ----------------------
# 
# Adds a element to the stack
# param     $a0:    Stack ref
# param     $a1:    Data to push
stackPush:
    lw		    $t0, 0($s0)		# Load the stack's reference
    sw		    $a1, 0($t0)		# Store at stack's reference
    addi	    $t0, $t0, -4	# $t0 = $t0 + -4
    sw          $t0, 0($s0)     # Store the new stack reference
    jr		    $ra				# jump to $ra  
       