# Small program calculated the factorial of user specified int.
.text
main:

# Print prompt_welcome to the terminal.
la $a0, prompt_welcome
li $v0, 4
syscall

# Print prompt_info to the terminal.
la $a0, prompt_info
li $v0, 4
syscall

enter_num:

# Print prompt_num to the terminal.
la $a0, prompt_num
li $v0, 4
syscall

#Collect user input.
li $v0, 5
syscall

la $t0, fact_num
sw $v0, 0($t0)
move $a1, $v0

#Check to see if 0<input<12
blt $v0, 1, error_low

bgt $v0, 11, error_high

#Prep iterator and operand for loop
li $s1, 0
lw $s2, fact_num
lw $s3, fact_num

fact_loop:
addi	$s1, $s1, 1
beq $s1, $s3, end_fact_loop

mul $s2, $s2, $s1

j fact_loop

end_fact_loop:

#store result of loop to result variable
la $t0, result
sw $s2, 0($t0)
move $a1, $s2

#output the result
la $a0, output_result_1
li $v0, 4
syscall

lw $a0, fact_num
li $v0, 1
syscall

la $a0, output_result_2
li $v0, 4
syscall

lw $a0, result
li $v0, 1
syscall

#Exit the program.
exit_prog:
li $v0, 10
syscall

#Error handling for numbers above 11
error_high:

# Print error_too_high the terminal.
la $a0, error_too_high
li $v0, 4
syscall

j enter_num

#error handling for numbers below 1.
error_low:

# Print error_too_low the terminal.
la $a0, error_too_low
li $v0, 4
syscall

j enter_num

.data
fact_num: .word 0
result: .word 0
prompt_welcome: .asciiz "Welcome to Factorial Calculator."
prompt_info: .asciiz "\nCalculate the facotrial of N such that 0<N<12."
prompt_num: .asciiz "\nPlease input your chosen number: "
error_too_high: .asciiz "\n ERROR: Number must be less than 12."
error_too_low: .asciiz "\n ERROR: Number must be greater than 0."
output_result_1: .asciiz "\nThe result of "
output_result_2: .asciiz "! is: "
