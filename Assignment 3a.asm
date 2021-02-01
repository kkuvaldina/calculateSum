#Assignment 3a
#Author: Kseniia Kuvaldina
#CSIS-2810

.data
    prompt1:    .asciiz "\n\nEnter first integer: "
    prompt2:    .asciiz "Enter second integer: "
    prompt3:    .asciiz "Enter third integer: "
    prompt4:    .asciiz "\nDo you want to run again? 1 - yes, 0 - no: "
    result1:    .asciiz  "\nThe sum of the numbers: "
    result2:    .asciiz  "\nThe largest of the numbers: "
    result3:    .asciiz  "\nThe smallest of the numbers: "

.text
loop:
main:
#Enter three integers from the keyboard
    #asking the user to provide the first number
    li  $v0, 4          
    la  $a0, prompt1    
    syscall             
    
    #the next block of code is for reading the first number provided by the user
    li  $v0, 5          
    syscall             
    move    $t0, $v0    
    
    #asking the user to provide the second number
    li  $v0, 4          
    la  $a0, prompt2    
    syscall             
    
    #reading the second number to be provided to the user
    li  $v0, 5          
    syscall             
    move    $t1, $v0    

    #asking the user to provide the third number
    li  $v0, 4          
    la  $a0, prompt3    
    syscall             
    
    #reading the third number to be provided to the user
    li  $v0, 5          
    syscall             
    move    $t2, $v0    

    li  $s0, 0      # sum = 0

#Calculate and display the sum of the numbers
    #calculate the sum $s0 of three integers
    add    $s0, $t0, $t1
    add    $s0, $s0, $t2

    # print "The sum of the numbers: "
    li      $v0, 4          
    la      $a0, result1
    syscall

    # print $s0 sum
    li      $v0, 1          
    move	$a0, $s0
    syscall

#Select and display the largest of the numbers
    #print "The largest of the numbers: "
    li      $v0, 4          
    la      $a0, result2
    syscall

    ble     $t0, $t1, else
    ble     $t0, $t2, else
    j   max1

else:
    ble     $t1, $t2, max3
    j   max2

max1:
    li      $v0, 1
    move    $a0, $t0
    syscall
    j   MIN

max2:
    li      $v0, 1
    move    $a0, $t1 
    syscall
    j   MIN

max3:
    li      $v0, 1
    move    $a0, $t2
    syscall
    j   MIN


#Select and display the smallest of the numbers
MIN:    
    #print "The smallest of the numbers: "
    li      $v0, 4          
    la      $a0, result3
    syscall

    bge     $t0, $t1, else2
    bge     $t0, $t2, else2
    j   min1

else2:
    bge     $t1, $t2, min3
    j       min2

min1:
    li      $v0, 1
    move    $a0, $t0 
    syscall
    j   runAgain

min2:
    li      $v0, 1
    move    $a0, $t1
    syscall
    j   runAgain

min3:
    li      $v0, 1
    move    $a0, $t2 
    syscall
    j   runAgain

#Allow for multiple iterations during the same run
runAgain:
    #print "Do you want to run again? 1 - yes, 0 - no"
    li      $v0, 4          
    la      $a0, prompt4
    syscall

    li      $v0, 5          
    syscall             
    move    $t3, $v0   

    beq     $t3, 0, end
    j   loop

end:   