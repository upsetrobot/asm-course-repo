
# 3-24 File Handling - Knowledge Check Solution

[Back to README](README.md)

1. What is the standard Unix file descriptor for terminal output?
    ```
    ANSWER: `1`.
    ```

2. What is the standard Unix file descriptor for terminal input?
    ```
    ANSWER: `0`.
    ```

3. What syscall is used to make a new file on Linux?
    ```
    ANSWER: `open`.
    ACCEPTABLES ANSWER: `sys_open`.
    ACCEPTABLES ANSWER: `creat`.
    ACCEPTABLES ANSWER: `sys_creat`.
    ```

4. What syscall is used add data to a file on Linux?
    ```
    ANSWER: `write`.
    ACCEPTABLE ANSWER: `sys_write`.
    ```

5. What syscall is used to get data from a file on Linux?
    ```
    ANSWER: `read`.
    ACCEPTABLE ANSWER: `sys_read`.
    ```

6. What mode can be `open` flag can be used if you want to edit a file?
    ```
    ANSWER: `O_WRONLY`.
    ACCEPTABLE ANSWER: `O_RDWR`.
    ACCEPTABLE ANSWER: `1`.
    ACCEPTABLE ANSWER: `2`.
    ```


[Back to README](README.md)


<!--- End of file. --->
