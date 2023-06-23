# Small program that accepts two integers and preforms simple arithmetic.
.text
main:

# Print prompt_first_int to the terminal.
la $a0, prompt_first_int
li $v0, 4
syscall

#Collect user first int.
li $v0, 5
syscall

#Store user first int.
la $s0, first_int
sw $v0, 0($s0)

#Print prompt_second_int to the terminal.
la $a0, prompt_second_int
li $v0, 4
syscall

#Collect user second int.
li $v0, 5
syscall

#store user second int.
la $s1, second_int
sw $v0, 0($s1)

addition:
#preform Addition
la $t0, result_add
lw $s2, 0($s0)
lw $s3, 0($s1)
add $t0, $s2, $s3

# Print the result of Addition to terminal.
la $a0, output_message
li $v0, 4
syscall

lw $a0, 0($s0)
li $v0, 1
syscall

la $a0, output_operator_add
li $v0, 4
syscall

lw $a0, 0($s1)
li $v0, 1
syscall

la $a0, output_message_end
li $v0, 4
syscall

move $a0, $t0
li $v0, 1
syscall

subtraction:
#Preform Subtraction
la $t0, result_sub
lw $s2, 0($s0)
lw $s3, 0($s1)
sub $t0, $s2, $s3

# Print the result of subtraction to terminal.
la $a0, output_message
li $v0, 4
syscall

lw $a0, 0($s0)
li $v0, 1
syscall

la $a0, output_operator_sub
li $v0, 4
syscall

lw $a0, 0($s1)
li $v0, 1
syscall

la $a0, output_message_end
li $v0, 4
syscall

move $a0, $t0
li $v0, 1
syscall

division:
#Preform Division
la $t0, result_div
lw $s2, 0($s0)
lw $s3, 0($s1)
div $t0, $s2, $s3

# Print the result of division to terminal.
la $a0, output_message
li $v0, 4
syscall

lw $a0, 0($s0)
li $v0, 1
syscall

la $a0, output_operator_div
li $v0, 4
syscall

lw $a0, 0($s1)
li $v0, 1
syscall

la $a0, output_message_end
li $v0, 4
syscall

move $a0, $t0
li $v0, 1
syscall

multiplication:
#Preform Multiplication
la $t0, result_mul
lw $s2, 0($s0)
lw $s3, 0($s1)
mul $t0, $s2, $s3

# Print the result of multiplicatoion to terminal.
la $a0, output_message
li $v0, 4
syscall

lw $a0, 0($s0)
li $v0, 1
syscall

la $a0, output_operator_mul
li $v0, 4
syscall

lw $a0, 0($s1)
li $v0, 1
syscall

la $a0, output_message_end
li $v0, 4
syscall

move $a0, $t0
li $v0, 1
syscall

exit_prog:
#Exit the program.
li $v0, 10
syscall

.data
first_int: .word 0
second_int: .word 0
result_add: .word 0
result_sub: .word 0
result_div: .word 0
result_mul: .word 0
prompt_first_int: .asciiz "Input your first integer please: "
prompt_second_int: .asciiz "\nInput your second integer please: "
output_message: .asciiz "\nThe result of "
output_operator_add: .asciiz " + "
output_operator_sub: .asciiz " - "
output_operator_div: .asciiz " / "
output_operator_mul: .asciiz " * "
output_message_end: .asciiz ": "
