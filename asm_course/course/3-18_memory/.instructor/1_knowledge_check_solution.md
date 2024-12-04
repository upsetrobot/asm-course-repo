
# 3-18 Memory - Knowledge Check Solution

[Back to README](README.md)

1. What permissions are given to the memory section `.rodata` is mapped to?
    ```
    ANSWER: Read-only (no-write; no-execute).
    ```

2. What memory section is executable code in for a typical assembly program?
    ```
    ANSWER: `.text`.
    ```

3. What is the `.bss` section for?
    ```
    ANSWER: Reserving space for unitialized global data.
    ```

4. How do you dereference a pointer in NASM?
    ```
    ANSWER: You use brackets.
    ```

5. You would like to make a global `int` array with the values `3`, `1`, `3`, 
`3`, `7` and the name `dope_array` to your program. What line do you add to 
the `.data` section?
    ```
    ANSWER: `dope_array dw 3, 1, 3, 3, 7`
    ```

6. You would like to add the string "What do you think you are doing" to your 
program with a label `the_string_of_inquisition`. What line do you add to the 
`.data` section?
    ```
    ANSWER: `the_string_of_inquisition db "What do you think you are doing", 0`
    ```

7. You want to reserve space for a character array with a label named `buf` 
and space for 31 characters. What line do you add to the `.bss` section?
    ```
    ANSWER: `buf: resb 31`
    ```

8. There is a global array of `unsigned long long`s named `bazooka` with `122` 
elements. How do you load the value of the 96th element into `rax`?
    ```
    ANSWER: `mov rax, bazooka[95]`
    ACCEPTABLE ANSWER: `mov rax, [bazooka + 95*8]`
    ```

9. There is a global array of `unsigned long long`s named `bazooka` with `122` 
elements. How do you load the address of the 101st element into `rax`?
    ```
    ANSWER: `lea rax, bazooka[100]`
    ACCEPTABLE ANSWER: `lea rax, [bazooka + 100*8]`
    ```

10. You have the pointer to a global buffer `globalest_buffer` in `rdi`. How 
do you check if the fourth letter is a `!` or not?
    ```
    ANSWER: `cmp byte [rdi + 3], '!'`, then check or branch using the `ZF`.
    ACCEPTABLE ANSWER: `mov al, byte [rdi + 3]` then `test al, '!'` or 
    something similar. 
    Student may include the branch (`je .label`) to their answer.
    ```


[Back to README](README.md)


<!--- End of file. --->
