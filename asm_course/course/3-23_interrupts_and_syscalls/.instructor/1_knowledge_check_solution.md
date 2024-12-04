
# 3-23 Interrupts and Syscalls - Knowledge Check Solution

[Back to README](README.md)

1. What interrupt can be used to request a kernel syscall on x86 32-bit Linux?
    ```
    ANSWER: `int 0x80`.
    ```

2. How do you find syscall numbers to load into `rax`?
    ```
    ANSWER: `cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h` or 
    `cat /usr/include/x86_64-linux-gnu/asm/unistd_32.h`.
    ACCEPTABLE ANSWER: Internet sources.
    ```

3. What instruction is used to make a system call on x64?
    ```
    ANSWER: `syscall`.
    ```

4. What source will you give information on syscalls on Linux?
    ```
    ANSWER: `man pages`.
    ACCEPTABLE ANSWER: Internet sources.
    ```


[Back to README](README.md)


<!--- End of file. --->
