
# 3-10 Boolean Operations - Knowledge Check Solution

[Back to README](README.md)

1. What bitwise boolean operation can be used to invert all bits in a register?
    ```
    ANSWER: `not`
    ```

2. If `rax` has a random value, what operation and immediate value can you use 
to check get the value of only the two lower bytes and store them in `rax`?
    ```
    ANSWER: `and rax, 0xffff`

    ALTERNATIVE ANSWER: `and rax, ffffh`
    ```

3. If `rax` has a value of `0b 1110 1010 1111` and `rbx` has a value of `0b 
1111 0000`, what is the value of `or rax, rbx`?
    ```
    ANSWER: `0b 1010 0000`
    ```

4. What value can you `or` `rax` with to store `-1` in `rax`?
    ```
    ANSWER: `-1`
    ```

5. What value can you `and` `rax` with to store `0` in `rax`?
    ```
    ANSWER: `0`
    ```

6. How can you zero `rax` using `xor`?
    ```
    ANSWER: `xor rax, rax`
    ```

7. How can you set the `ZF` if `rax` has a value of `0` and not zero it if 
`rax` has some other value all without affecting the value of `rax`?
    ```
    ANSWER: `test rax, rax`
    ```

8. What operations are needed to convert an arbitrary negative number in `rcx` 
to a positive absolute value of `rcx` and store it in `rcx`?
    ```
    ANSWER: `not rcx` followed by `inc rcx`
    ```

[Back to README](README.md)


<!--- End of file. --->
