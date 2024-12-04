
# 3-07 Arithmetic Operations - Knowledge Check Solution

[Back to README](README.md)

1. What operation can be used to add 1 to a register value?
    ```
    ANSWER: `inc`
    ```

2. Does `dec` instruction affect the `CF`?
    ```
    ANSWER: No, `dec` does not affect the state of the `CF`.
    ```

3. What is the difference between `mul` and `imul`?
    ```
    ANSWER: `mul` is used for unsigned multiplication, whereas `imul` is used 
    for multiplication of signed data.
    ```

4. When using the `mul` instruction, what registers do the multiplicands have 
to be in?
    ```
    ANSWER: One has to be in `rax` (or `eax`, `ax`, `al` as needed for 
    different data sizes), and the otehr can be any other register or memory 
    location.
    ```

5. Where is the product of the `mul` instruction placed?
    ```
    ANSWER: The product is placed in `rax` and `rdx`, specifically in 
    `rdx:rax`, `edx:eax`, `dx:ax`, or `ax` based on the data size of the 
    operation.
    ```

6. What is the difference between `div` and `idiv`?
    ```
    ANSWER: `div` is for unsigned data division whereas `idiv` is for signed 
    data division.
    ```

7. Where are the dividend and divisor placed when using the `div` instruction?
    ```
    ANSWER: The dividend should be placed in `ax`, `dx:ax`, `edx:eax`, or 
    `rdx:rax` depending on the desired datasize of the operation, and the 
    divisor can be in any general purpose register or memory location.
    ```

8. Where is the quotient of the `idiv` instruction placed?
    ```
    ANSWER: The quotient will be in `al`, `ax`, `eax`, or `rax` depending on 
    the data size of the operation.
    ```

9. Where is the remainder of the `idiv` instruction placed?
    ```
    ANSWER: The remainder will be in `ah`, `dx`, `edx`, or `rdx` depending on 
    the data size of the operation.
    ```

10. What are the two functions of the `lea` instruction?
    ```
    ANSWER: The `lea` operation (or "load effective address" operation) has 
    two primary functions. The first is to load a pointer (address) of 
    something into a register. The second function is a by-product of the 
    first, that `lea` can be used to do some arithmetic and move a value into 
    a register.
    ```

11. What does the `xchg` instruction do?
    ```
    ANSWER: It exchanges the contents of two operands (two registers or one 
    register and one memory location).
    ```

[Back to README](README.md)


<!--- End of file. --->
