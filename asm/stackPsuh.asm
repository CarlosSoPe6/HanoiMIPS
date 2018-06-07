# ------ [ stackPush ] ----------------------
# 
# Adds a element to the stack
# param $a0:    Stack head
# param $a1:    Stack pointer
# param $a2:    Data to push
stackPush:
    lw		$t0, 0($a1)		    # Load $t0 = $a1
    sll     $t1, $t0, 2         # $t1 = $a1 << 2
    add		$t1, $a0, $t1		# $t1 = $a0 + $t1
    sw		$a2, 0($t1)		    # Store *$t1 = $a2
    addi	$a1, $a1, 1			# $a1 = $a1 + 1
    sw		$t0, 0($a1)		    # Store *$a1 = $t0
    jr $ra