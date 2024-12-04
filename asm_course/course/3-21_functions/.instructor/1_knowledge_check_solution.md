
# 3-21 Functions - Knowledge Check Solution

[Back to README](README.md)

1. What instruction is used to start a subroutine or function?
    ```
    ANSWER: `call`.
    ```

2. What instruction is used to end a function and return to calling the 
function?
    ```
    ANSWER: `ret`.
    ```

3. If you intend to link a library to your binary. The libary has a function 
named `totallyFunctional`. How do you declare this library function in NASM 
before calling it?
    ```
    ANSWER: `extern totallyFunctional`.
    ```

4. You want to export some functions to be called from another program or 
from a different object file. What keyword do you use to declare a function 
as exportable?
    ```
    ANSWER: `global`.
    ```

5. What registers are used to pass the first four integer arguments in Windows 
x64 calling convention?
    ```
    ANSWER: `rcx`, `rdx`, `r8`, `r9`.
    ```

6. What are four non-volatile registers on Linux x64 calling convention?
    ```
    ANSWER: `rbp`, `rsp`, `rbx`, `r12`, `r13`, `r14`, `r15`.
    ```

7. What does the `call` function do to the stack (in normal near calls)?
    ```
    ANSWER: It pushes the return address onto the stack.
    ```

8. What two operations is the `leave` instruction eqivalent to on x64?
    ```
    ANSWER: It is equivalent to `mov rsp, rbp`, `pop rbp`.
    ```

9. What three operations is the operation `enter 0x10, 0` equivalent to (x64)?
    ```
    ANSWER: It is equivalent to `push rbp`, `mov rbp, rsp`, `sub rsp, 0x10`.
    ```


[Back to README](README.md)


<!--- End of file. --->
