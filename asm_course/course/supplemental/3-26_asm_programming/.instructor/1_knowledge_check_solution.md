
# 3-26 ASM Programming - Knowledge Check Solution

[Back to README](README.md)

1. What function should be declared as `global` if you are only using `nasm` 
and `ld` to compile your program and you want to start your program in 
assembly?
    ```
    ANSWER: `_start`.
    ```

2. What function should be declared as `global` if you are only using `nasm` 
and `gcc` to compile your program and you want to start your program in 
assembly?
    ```
    ANSWER: `main`.
    ```

3. If you want to force `nasm` default addressing mode to absolute addressing, 
what directive would you use?
    ```
    ANSWER: `default abs`.
    ```

4. If you have several lines of code that you are using many times in your 
program, what should you do to reduce the number of times you have to type 
out all the lines?
    ```
    ANSWER: Make a macro.
    ACCEPTABLE ANSWER: Make a function.
    ```

[Back to README](README.md)


<!--- End of file. --->
