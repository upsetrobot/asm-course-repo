
# 3-17 Stack - Knowledge Check Solution

[Back to README](README.md)

1. What type of interface model for insertion and removal does a stack have 
(FIFO, FILO, LIFO, LILO)?
    ```
    ANSWER: LIFO.
    Arguably acceptable answer: FILO.
    ```

2. How do you increase the stack size by 0x100 bytes?
    ```
    ANSWER: `sub rsp, 0x100`
    ```

3. How decrease the stack size by 0x18 bytes?
    ```
    ANSWER: `add rsp, 0x18`
    ```

4. What are two reasons for using the stack?
    ```
    ANSWER: Storing local variables, saving and restoring registers, passing 
    arguments to functions, and temporary storage of data.
    ```

5. How do you save the flag state of the processor?
    ```
    ANSWER: `pushf`
    ```

6. What does the `pop` instruction do?
    ```
    ANSWER: Move value pointed to by `rsp` into operand and then adds 8 (in 
    x64) to `rsp`.
    ```


[Back to README](README.md)


<!--- End of file. --->
