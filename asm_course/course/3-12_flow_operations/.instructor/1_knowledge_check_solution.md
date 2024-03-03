
# 3-12 Flow Operations - Knowledge Check Solution

[Back to README](README.md)

1. What does the `cmp` instruction do?
    ```
    ANSWER: It performs a subtraction of the second operand from the first 
    operand with adjusting the operand values and sets the flags in the flags 
    register. These flags can be used with conditional operations.
    ```

2. How many bytes can a short jump mov `eip` forward in 32-bit mode?
    ```
    ANSWER: 127.
    ```

3. What flag does the `je` instruction check?
    ```
    ANSWER: `ZF`.
    ```

4. How would check if `rax` larger `-2` and jump to the `.best` label if true?
    ```
    ANSWER: `cmp rax, -2` followed by `ja .best`.
    ```

5. What conditional jump instruction is used to jump if a unsigned value is 
larger or equal a value that was compared?
    ```
    ANSWER: `jge`.
    ```

[Back to README](README.md)


<!--- End of file. --->
