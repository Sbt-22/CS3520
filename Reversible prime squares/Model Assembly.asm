#=============Reversible prime squares================
# Author: Seabata Moshate					
# Student Number: 202000742									
# G-mail: sbtmoshate2296@gmail.com

.data
	newline: .asciiz "\n"
.text


main:
	addi	$s1,$0,0	
	addi	$s2,$0,0	
	addi	$s3,$0,0	
	addi	$s4,$0,0	
	addi	$s5,$0,0		
	addi	$t1,$0,10	
	addi	$t3,$zero,1

for_main:
	move	$a1,$s1
	bgez	$a1,if_1
	j	endmain
if_1:
	jal	Reverse
	move	$s3,$v1
	move	$v1,$zero
	move	$a1,$s1
	jal	isPrimesq
	move	$t2,$v0
	move	$v0,$zero
	beq	$t2,$t3,if_2
	j	loop_end
if_2:
	move	$a1,$s3
	jal	isPrimesq
	move	$t2,$v0
	move	$v0,$zero
	beq	$t2,$t3,if_3
	j	loop_end
if_3:
	move	$a1,$s1
	jal	Square_root
	move	$s4,$v1
	move	$v1,$zero
	move	$a1,$s3
	jal	Square_root
	move	$s5,$v1
	move	$v1,$zero
	move	$a1,$s4
	jal	isPrime
	move	$t2,$v0
	move	$v0,$zero
	beq	$t2,$t3,if_4
	j	loop_end
if_4:
	move	$a1,$s5	
	jal	isPrime
	move	$t2,$v0
	move	$v0,$zero
	beq	$t2,$t3,if_5	
	j	loop_end
if_5:
	bne	$s1,$s3,doThis
	j	loop_end
doThis:
	li	$v0,1
	add	$a0,$zero,$s1
	syscall
	addi	$s2,$s2,1
	li	$v0,4
	la	$a0,newline
	syscall
	beq	$s2,$t1,endmain
	j	loop_end	
loop_end:
	addi	$s1,$s1,1
	move	$v1,$zero
	move	$v0,$zero
	move	$a1,$zero
	move	$t2,$zero
	move	$s3,$zero	
	move	$v0,$zero
	j	for_main

endmain:
		
	li	$v0, 10
	syscall
#Reverse function
Reverse:
	addi	$sp,$sp,-20
	sw	$t1,0($sp)
	sw	$t2,4($sp)
	sw	$t3,8($sp)
	sw	$t4,16($sp)
#set everything to zero
	move	$t1,$0
	move	$t2,$0
	move	$t3,$0
	move	$t4,$0
	move	$t5,$0
	addi	$t3,$0,10
firstLoop:
	beqz	$a1,end
	div	$a1,$t3
	mfhi	$t2
	mul	$t4,$t1,$t3
	add	$t1,$t4,$t2	
	div	$a1,$t3
	mflo	$a1
	j	firstLoop

end:
	add	$v1,$0,$t1
	lw	$t1,0($sp)
	lw	$t2,4($sp)	
	lw	$t3,8($sp)
	lw	$t4,16($sp)		
	addi	$sp,$sp,20
	jr	$ra
#Isprime fn
isPrime:
	addi	$sp,$sp,-24
	sw	$t1,0($sp)
	sw	$t2,4($sp)	#isTrue
	sw	$t3,8($sp)
	sw	$t4,16($sp)
	sw	$t5,20($sp)

	move	$t1,$0
	move	$t2,$0
	move	$t3,$0
	move	$t4,$0
	move	$t5,$0
	addi	$t1,$0,1
	addi	$t2,$0,1
	addi	$t3,$0,2	#i = 2	

	beqz	$a1,return0
	beq	$a1,$t1,return0
	div	$a1,$t3
	mflo	$t4
	j	for	

for:
	ble	$t3,$t4,Loop2
	j	end2
Loop2:	
	div	$a1,$t3
	mfhi	$t5
	j	if_p
if_p:
	beqz	$t5,return0
	j	loop_p
loop_p:
	addi	$t3,$t3,1
	move	$t5,$zero	
	j	for

return0:
	move	$t2,$0
	j	end2
end2:
	move	$v0,$t2
	#load into stack
	lw	$t1,0($sp)
	lw	$t2,4($sp)	#isTrue
	lw	$t3,8($sp)
	lw	$t4,16($sp)
	lw	$t5,20($sp)
	addi	$sp,$sp,24
	jr	$ra

not_palindrome:
	addi	$sp,$sp,-24
	#sw	$a1,12($sp)
	sw	$t1,0($sp)
	sw	$t2,4($sp)	#isTrue
	sw	$t3,8($sp)
	sw	$t4,16($sp)
	sw	$t5,20($sp)
	#reset the above registers to 0
	move	$t1,$0
	move	$t2,$0
	move	$t3,$0
	move	$t4,$0
	move	$t5,$0

	addi	$t2,$t0,1
	jal	Reverse

	addi	$sp,$sp,-24
	#sw	$a1,12($sp)
	sw	$t1,0($sp)
	sw	$t2,4($sp)	#isTrue
	sw	$t3,8($sp)
	sw	$t4,16($sp)
	sw	$t5,20($sp)

	move	$t1,$0
	move	$t2,$0
	move	$t3,$0
	move	$t4,$0
	move	$t5,$0
	addi	$t2,$t0,1

	beq	$v1,$a1,return0_1
	j	end3
return0_1:
	move	$t2,$0
	j	end3
end3:
	move	$v0,$t2
	#lw	$a1,12($sp)
	lw	$t1,0($sp)
	lw	$t2,4($sp)	
	lw	$t3,8($sp)
	lw	$t4,16($sp)
	#lw	$t5,20($sp)
	addi	$sp,$sp,24
	jr	$ra	
	
isPrimesq:
	addi	$sp,$sp,-24
	#store on the stack
	sw	$t1,0($sp)	#i
	sw	$t2,4($sp)	
	sw	$t3,8($sp)
	sw	$t4,16($sp)
	sw	$t5,20($sp)
	sw	$t6,28($sp)
	#store zeroes in the registers
	move	$t1,$0
	move	$t2,$0
	move	$t3,$0
	move	$t4,$0
	move	$t5,$0
	move	$t6,$0

	#i = 1
	addi	$t1,$0,1
For1:
	mul	$t2,$t1,$t1
	ble	$t2,$a1,Loop3
	j	return_false
Loop3:
	div	$a1,$t1
	mfhi	$t4
	mflo	$t5

	beqz	$t4,if1
	j	loopend	
if1:
	beq	$t5,$t1,return_true
	j	loopend
return_true:
	addi	$t6,$0,1
	j	end4
loopend:
	addi	$t1,$t1,1
	j	For1
return_false:
	addi	$t6,$0,0
	j	end4
end4:
	add	$v0,$0,$t6

	#store on the stack
	lw	$t1,0($sp)
	lw	$t2,4($sp)	
	lw	$t3,8($sp)
	lw	$t4,16($sp)
	lw	$t5,20($sp)
	lw	$t6,28($sp)
	addi	$sp,$sp,24
	jr	$ra	

Square_root:
	addi	$sp,$sp,-24
	sw	$a1,12($sp)	#value
	sw	$t1,0($sp)	#squre root
	sw	$t2,4($sp)	#counter	
	sw	$t3,8($sp)	
	sw	$t4,16($sp)
	sw	$t5,20($sp)

	#store zero in those regs
	move	$t1,$0
	move	$t2,$0
	move	$t3,$0
	move	$t4,$0
	move	$t5,$0

	move	$v0,$zero
	addi	$t1,$0,1
	addi	$t2,$0,1
	beqz	$a1,return_value
	beq	$a1,$t1,return_value
while2:
	ble	$t1,$a1,Loop4
	j	output

Loop4:
	addi	$t2,$t2,1
	mult	$t2,$t2
	mflo	$t1
	j	while2
output:
	subi	$t7,$t2,1
	add	$v1,$0,$t7
	j	end5
return_value:
	move	$t7,$a1
	j	end5
end5:
	add	$v1,$0,$t7
	#load onto stack
	lw	$t1,0($sp)
	lw	$t2,4($sp)	
	lw	$t3,8($sp)
	lw	$t4,16($sp)
	lw	$t5,20($sp)
	addi	$sp,$sp,24
	jr	$ra		

