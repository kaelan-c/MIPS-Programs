# Small program that accepts a list of user selected size, 
# Then determines the largest and smallest integer in that list.
.text
main:

# Print prompt_first_int to the terminal.
la $a0, prompt_list_size
li $v0, 4
syscall

#Collect user size for list.
li $v0, 5
syscall

#Store size for list.
la $t0, list_size
sw $v0, 0($t0)
move $a1, $v0

#Prep iterator and list for loop.
li $s1, 0
la $t0, list
li $t2, 0

#initialize largest and smallest numbers
la $a2, max_int
la $a3, min_int

#enter the loop.
in_loop:
addi $s1, $s1, 1
bgt $s1, $a1, end_in_loop

la $a0, prompt_list_contents
li $v0, 4
syscall

li $v0, 5
syscall

add $t3, $t0, $t2
sw $v0, 0($t3)
addi $t2, $t2, 4

j in_loop

#exit the loop
end_in_loop:

#output prompt for list contents
la $a0, output_list_contents
li $v0, 4
syscall

#prep list and iterator for loop
la $t0, list_size
lw $a1, 0($t0)

li $s1, 0
la $t0, list
li $t2, 0

#loop To out put the list
out_loop:
addi $s1, $s1, 1
bgt $s1, $a1, end_out_loop

add $t3, $t0, $t2
lw $a0, 0($t3)
addi $t2, $t2, 4

li $v0, 1
syscall

la $a0, output_list_spaces
li $v0, 4
syscall

j out_loop

#exit loop
end_out_loop:

#prep list and iterator for loop
la $t0, list_size
lw $a1, 0($t0)

li $s1, 0
la $t0, list
li $t2, 0

#Loop To find Maximum number
max_loop:
addi $s1, $s1, 1
bgt $s1, $a1, end_max_loop

add $t3, $t0, $t2
lw $a0, 0($t3)
addi $t2, $t2, 4

j update_max

#exit loop
end_max_loop:

#prep list and iterator for loop
la $t0, list_size
lw $a1, 0($t0)

li $s1, 0
la $t0, list
li $t2, 0

#loop to find Minimum number
min_loop:
addi $s1, $s1, 1
bgt $s1, $a1, end_min_loop

add $t3, $t0, $t2
lw $a0, 0($t3)
addi $t2, $t2, 4

j update_min

#exit loop
end_min_loop:

#Output the Maximum number to console
la $a0, output_max_int
li $v0, 4
syscall

lw $a0, max_int
li $v0, 1
syscall

#Output the smallest number to console
la $a0, output_min_int
li $v0, 4
syscall

lw $a0, min_int
li $v0, 1
syscall

#Exit the program.
exit_prog:

li $v0, 10
syscall

#update the maximum int
update_max:

lw $t4, max_int
bgt $t4, $a0, max_loop

la $t7, max_int
sw $a0, 0($t7)
move $a2, $a0

j max_loop

#update the minimum int
update_min:

lw $t4, min_int
blt $t4, $a0, min_loop

la $t7, min_int
sw $a0, 0($t7)
move $a3, $a0

j min_loop

.data
list: .space 100
list_size: .word 0
max_int: .word 0
min_int: .word 100
prompt_list_size: .asciiz "\nInput the size of your list please: "
prompt_list_contents: .asciiz "\nInput an integer please: "
output_list_contents: .asciiz "\n The list contains: "
output_list_spaces: .asciiz ", "
output_max_int: .asciiz "\n The largest int is: "
output_min_int: .asciiz "\n The smallest int is: "
