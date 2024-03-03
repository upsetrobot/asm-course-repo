
# 3-19 Strings - Knowledge Check Solution

[Back to README](README.md)

1. If there is a string in the `.data` section named `the_string`, what line 
can you put directly after the string declaration to save the length of the 
string as a variable named `length_of_the_string`?
    ```
    ANSWER: `length_of_the_string equ $ - the_string`.
    ```

2. What are the two main ways of storing strings or arrays in general as far 
as what to include with the array?
    ```
    ANSWER: Arrays should include explicitly storing the length of the array 
    or terminating the array with a sentinel value.
    ACCEPTABLE ANSWER: Store length or use sentinel.
    ```

3. If you want to zero out memory of a string `zero_me` with a length of `255` 
bytes, what string instruction could you use?
    ```
    ANSWER: `rep stosb`.
    ACCEPTABLE ANSWER: `mov rcx, 255`, then `cld`, then `mov rdi, zero_me`, 
    then `rep stosb`.
    ACCEPTABLE ANSWER: `stosb`.
    ACCEPTABLE ANSWER: `stos`.
    ```

4. What string instruction would you use to move a pointer to a string to 
point at the first instance of the character `.`?
    ```
    ANSWER: `repne scasb`.
    ACCEPTABLE ANSWER: `mov rcx, -1`, `mov al, '.'`, `cld`, then `rep scasb`.
    ACCEPTABLE ANSWER: `scasb`.
    ACCEPTABLE ANSWER: `scas`.
    ```

5. What string instruction would you use to copy a string?
    ```
    ANSWER: `rep movsb`.
    ACCEPTABLE ANSWER: `movsb`.
    ACCEPTABLE ANSWER: `movs`.
    ```

6. What string instruction would you use to find out if two strings are the 
same?
    ```
    ANSWER: `repe cmpsb`.
    ACCEPTABLE ANSWER: `cmpsb`.
    ACCEPTABLE ANSWER: `cmps`.
    ```

7. What are the terminating conditions of the instruction prefix `repe`?
    ```
    ANSWER: When `rcx` = 0 or when `ZF` = 0.
    ```

8. What does the `std` instruction do?
    ```
    ANSWER: It sets the `DF` so that string instructions decrement pointers 
    (vice incrementing them).
    ACCEPTABLE ANSWER: It sets the direction flag.
    ```

9. What is the hex value for the character "z"?
    ```
    ANSWER: `0x7a`.
    ```

10. What is the decimal value for the character "_"?
    ```
    ANSWER: `95`.
    ```


[Back to README](README.md)


<!--- End of file. --->
