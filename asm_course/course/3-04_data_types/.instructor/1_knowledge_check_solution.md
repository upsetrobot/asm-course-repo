
# 3-04 Data Types - Knowledge Check Solution

[Back to README](README.md)

1. What are the four common data sizes in assembly?
    ```
    ANSWER: 
    1. byte
    2. word
    3. dword
    4. qword
    ```

2. What is the assumed size of the immediate in the following statement 
`mov eax, 35`?
    ```
    ANSWER: dword
    ```

3. What decimal value is stored in `rax` after `mov eax, 0xff`?
    ```
    ANSWER: 255
    ```

4. If `rax` has a value of `0xfeedcafebabebeef`, what is the value stored in 
`rax` after `mov eax, 0`?
    ```
    ANSWER: 0x0
    OTHER ACCEPTABLE ANSWERS: 0
    WHY: 32-bit move operation zero-extends.
    ```

5. If `rax` has a value of `0xfeedcafebabebeef`, what is the value stored in 
`rax` after `mov al, 0`?
    ```
    ANSWER: 0xfeedcafebabebe00
    WHY: 8-bit move does not zero-extend.
    ```

6. How do you define a constant named `ACID_BURN` in assembly with a value of 
`0x1337`?
    ```
    ANSWER: ACID_BURN equ 0x1337
    ACCEPTABLE ANSWER: %assign ACID_BURN 0x1337
    ACCEPTABLE ANSWER: %define ACID_BURN 0x1337
    ```

7. How do you allocate a global variable named `HAXR` with a size of eight 
bytes and a value of `'ELITE'` in NASM?
    ```
    ANSWER: HAXR dq 'ELITE'
    ```

8. What section do you place initialized global variables in assembly?
    ```
    ANSWER: .data
    ```

9. How do you allocate a global variable named `HAXR` with a size of eight 
bytes without an initialized value in NASM?
    ```
    ANSWER: HAXR resq 1
    ```

10. How do you declare an array named `WAREWOLF` with 10 elements each of 
dword-size and all with a value of 0xbad?
    ```
    ANSWER: WAREWOLF times 10 dw 0xbad
    ```

[Back to README](README.md)


<!--- End of file. --->
