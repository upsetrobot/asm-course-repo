
# 3-03 Registers - Knowledge Check Solution

[Back to README](README.md)

1. What are the three main categories of registers?
    ```
    ANSWER: 
    1. General registers.
    2. Control registers.
    3. Segment registers.
    ```

2. What are three types of general registers?
    ```
    ANSWER: 
    1. Data registers.
    2. Pointer registers.
    3. Index registers.
    ```

3. Which register is also known as the accumulator and is often used to hold 
the return value of a function?
    ```
    ANSWER: rax, eax, or ax are acceptable answers.
    ```

4. Which register is often used as a counter in iterative operations?
    ```
    ANSWER: rcx, ecx, or cx are acceptable answers.
    ```

5. Which register is the instruction pointer on 32-bit systems?
    ```
    ANSWER: eip
    ```

6. Which register is the stack pointer on 64-bit systems?
    ```
    ANSWER: rsp
    ```

7. Which register is used as the frame pointer when programming a 32-bit 
program on a 64-bit system?
    ```
    ANSWER: ebp
    ```

8. Which index register is often used to hold a pointer to a source string in 
64-bit?
    ```
    ANSWER: rsi
    ```

9. What does the word "set" mean when referring to a bit flag?
    ```
    ANSWER: The bit value is 1.
    ```

10. What does the word "cleared" mean when referring to a bit flag?
    ```
    ANSWER: The bit value is 0.
    ```

11. Which flag bit in the control register `FLAGS` is set when an operation 
results in a zero (such as `8 - 8 = 0`)?
    ```
    ANSWER: zf
    ```

12. Which flag bit is set when a negative number is loaded into `rax`?
    ```
    ANSWER: sf
    ```

13. The binary number `11010100` is loaded into `al`. Will the `pf` flag be set 
or cleared?
    ```
    ANSWER: The parity flag will be cleared.
    ```

14. What flag can you check to know if you did an integer overflow such as in 
the operation of `255 + 1` in an 8-bit register?
    ```
    ANSWER: of will be set.
    ```

15. What is the 16-bit register of `r11`?
    ```
    ANSWER: r11w
    ```

16. If `rbx` has a value of `0xfeedbabedeadbeef`, what will the register value 
be after moving `0xdecafdad` into `ebx`?
    ```
    ANSWER: 0x00000000decafdad
    ```

[Back to README](README.md)


<!--- End of file. --->
