
# 3-27 Structs - Knowledge Check Solution

[Back to README](README.md)

1. What line do you use to declare a structure type named `super_struct` in 
NASM?
    ```
    ANSWER: `struc super_struct`.
    ```

2. What line do you use to end your structure type declaration for a structure 
type named `super_struct` in NASM?
    ```
    ANSWER: `endstruc`.
    ```

3. If you want your structure type to have a member named `super_member` that 
is one quadword long and you want to use dot notation to access it later, what 
line do you add in your structure type declaration?
    ```
    ANSWER: `.super_member:     resq    1`.
    ```

4. How do you move the size of `super_struct` into `rax`?
    ```
    ANSWER: `mov rax, super_struct_size`.
    ```

5. If you have a structure type named `big` with one hundred members and you 
have created such a structure and have a pointer to it in `rdi`, how do you 
move the address of the `.findme` member into `rsi`?
    ```
    ANSWER: `lea rsi, [rdi + big.findme]`.
    ```

6. If you have a structure type named `big` with one hundred members and you 
have created such a structure and have a pointer to it in `rdi`, how do you 
move the value of the `int` member named `.im_a_int` member into `rdx`?
    ```
    ANSWER: `mov edx, [rdi + big.im_a_int]`.
    ```

7. If you have a pointer to a node in a linked list in `rcx` where the 
structure type for the nodes are called `myNode` and the next pointer is 
called `.my_nxt`, how do you reassign `rcx` to point at the next node?
    ```
    ANSWER: `mov rcx, [rcx + myNode.my_nxt]`.
    ```

8. What system call and argument(s) can be used to get the address of the 
current system break?
    ```
    ANSWER: `brk` with an argument of `0`.
    ACCEPTABLE ANSWER: `sys_brk` with an argument of `0`.
    ```


[Back to README](README.md)


<!--- End of file. --->
