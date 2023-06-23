# CPSC 3615 - A
# Assignment: 4
# Kaelan Croucher

# Small program that reverses the order of two seperate strings.
.text
main:

    #Print the program welcome message.
    la $a0, prompt_welcome
    li $v0, 4
    syscall

    #Print the program description.
    la $a0, prompt_info
    li $v0, 4
    syscall

    #Print an example of a valid input.
    la $a0, prompt_example
    li $v0, 4
    syscall

    #Print a prompt for the users input.
    la $a0, prompt_input
    li $v0, 4
    syscall

    #Collect the users input
    li $v0, 8

    #Store the input into input_raw variable.
    la $a0, input_raw
    li $a1, 50
    move $t0, $a0
    syscall

    #jump to string splitter function.
    j string_split

print_result:
    #Print the output message to the console.
    la $a0, output
    li $v0, 4
    syscall

    #print the reversed first name.
    la $a0, output_first_name
    li $v0, 4
    syscall

    #print a space character between reveresed strings.
    la $a0, space_char
    li $v0, 4
    syscall

    #print the reversed last name.
    la $a0, output_last_name
    li $v0, 4
    syscall

    exit_prog:
    #Exit the program.
    li $v0, 10
    syscall

string_split:

    li $t1, 0 #Set iterator for loop to zero
    li $t2, 0 #iterator for working through input
    li $t5, 0 #Count the number of chars in first name.

    la $s1, space_char #Load bit of space char var for use in loop.
    lb $s2, 0($s1)

    #loop to count the number of chars in first name
    split_first_name:

        add $t2, $a0, $t1 #iterate through the input stored in $a0
        lb $t4, 0($t2) #load the bit into pointer $t4
        addi $t1, $t1, 1 #increment iterator
        beq $t4, $s2, end_split_first_name #check if current char == " ", if so break loop
        addi $t5, $t5, 1 #else increment char counter

        j split_first_name

    end_split_first_name:

        li $t0, 0 #initialze iterator for storing bites in correct position
        li $t2, 0 #iterator for working through input

    #loop to reverse the first name and store in var.
    reverse_first_name:

        add $t2, $a0, $t5 #iterate through input starting at the end of first name.
        lb $t4, 0($t2) #load the current bit to pointer $t4.
        sb $t4, output_first_name($t0) #store bit in pointer $t4 to first position of var
        beq $t5, 0, end_reverse_first_name #if $t5 (first name length) reaches zero break loop.
        addi $t0, $t0, 1 #Increment to next posistion in var.
        sub $t5, $t5, 1 #reduce the number of chars left in first name by 1.

        j reverse_first_name

    end_reverse_first_name:

        li $t6, 0 # set counter for counting number of chars in last name

    #loop to count the number of chars in last name
     split_last_name:

        add $t2, $a0, $t1 #iterate through in input starting at first letter of last name.
        lb $t4, 0($t2) #load current bit.
        beqz $t4, end_split_last_name #if current bit is equal to null break loop.
        addi $t6, $t6, 1 #increment to number of chars in last name
        addi $t1, $t1, 1 #increment iterator through input string.

        j split_last_name

    end_split_last_name:

        li $t0, 0 #set iterator for storing string bits in correct posistion to zero.
        sub $t1, $t1, 2 #The last loop runs for two iterations extra.
        sub $t6, $t6, 2 #this is just to correct for that error.

    #loop to reverse last name string
    reverse_last_name:

        add $t2, $a0, $t1 #Iterate through input string starting at last position in string.
        lb $t4, 0($t2) #load bit to pointer $t4
        sb $t4, output_last_name($t0) #store bit in current position in var. (starts at 0)
        beq $t6, 0, end_reverse_last_name #if $t6 (last name string length) reaches zero break.
        addi $t0, $t0, 1 #increment to next position in var.
        sub $t1, $t1, 1 # reduce position in input by 1.
        sub $t6, $t6, 1 # reduce chars left in last name string by 1.

        j reverse_last_name

    end_reverse_last_name:

        j print_result



.data
    input_raw: .space 256
    output_first_name: .space 256
    output_last_name: .space 256
    space_char: .asciiz " "
    prompt_welcome: .asciiz "Welcome to String Reverser."
    prompt_info: .asciiz "\nPlease input your first and last name seperated by a space."
    prompt_example: .asciiz "\nExample: Kaelan Croucher"
    prompt_input: .asciiz "\nPlease input your name: "
    output: .asciiz "\nYour name reversed is: "
