
# 🏗️ 3-27 Structs - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Structure Notation](#structure-notation)
- [Linked List Example](#linked-list-example)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Structure Notation

In NASM, `struc` is used to define a structure. This definition can be used 
to calculate offsets automatically using a dot notation. You can define a 
structure type using the following notation:

``` x86asm
struc myStrucType
    
    .member1:   resd    1
    .member2:   resb    1
    .member3:   resq    1
    .member4:   resw    1

endstruc
```

Structure fields can be accessed by adding offsets to the structure base 
address (e.g., `mov rax, [rdi + myStrucType.member2]` if `rdi` has the 
structure base address). You can also use `<strucname>_size` to get the total
size of the structure.

``` x86asm
struc myStructure

    .integer_value:     resd    1
    .curr_sum:          resd    1

endstruc

section .text

    myFunction:
        ...

        mov rdi, thing1     ; Load structure base address. Can be global 
                            ; any memory global, local on stack, or 
                            ; dynamically allocated.
        mov dword [rdi + myStructure.integer_value], 22
        mov dword [rdi + myStructure.curr_sum], 0

        ...

        mov rdi, thing1
        add dword [rdi + myStructure.curr_sum], 8
        cmp dword [rdi + myStructure.integer_value], 50
        jge .greater

        ...

        cmp dword [rdi + myStructure.curr_sum], 100
        jge .end
        jmp .top

        ...

        leave
        ret


section .bss

    thing1:     resb    myStructure_size
    thing2:     resb    myStructure_size

```


## Linked List Example

Here is an example of a linked list implemented in `NASM`.

``` x86asm
%define SYS_BRK     12

%define NEWLINE     10
%define NULL        0

%define EXIT_SUCCESS    0
%define EXIT_FAILURE    -1

struc node

    .next:  resq    1
    .value: resq    1

endstruc


section .data

    msg                 db  "Element: %d", NEWLINE, NULL
    init_elements       dq  12, 333, 4522, 24134, 99
    init_elements_len   equ 5


section .bss

    head:   resq    1


section .text

global main                   ; Needed to avoid gcc warning for entry point.
extern printf                 ; For sake of brevity, we are using libc.

    main:                     ; Used if you are compiling with gcc.
        push rbp
        mov rbp, rsp

        ; Allocate 5 elements and use the values from our hard-coded array.
        ; Alternatively, you can get elements from user if you write a scanf-
        ; like function or a getNumber function or whatever parsing you want 
        ; to do to get info from user or another source like a file.
        xor rcx, rcx
        mov rsi, init_elements              ; array.
        mov rdi, head                       ; last_node.

        .createList:                        ; For loop.
                                            ; You could use a `loop` loop if 
                                            ; you didn't mind the list being 
                                            ; backwards or if you did the 
                                            ; math to account for that.
            cmp rcx, init_elements_len
            je .endCreateList

            push rdi                        ; Save registers in case call 
            push rsi                        ; clobbers them.
            push rcx
            mov rdi, node_size
            call allocate

            pop rcx                         ; Restore registers in reverse 
            pop rsi                         ; order.
            pop rdi
            test rax, rax
            jz .err

            mov rdx, [rsi + rcx*8]          ; array element.
            mov [rax + node.value], rdx     ; Save value.
            mov qword [rax + node.next], NULL   ; Not really needed because 
                                                ; `allocate` zeros memory, but  
                                                ; just as an example.
            mov [rdi + node.next], rax      ; Save pointer. Works because 
                                            ; `.next` is the first value, so
                                            ; that `head` can just be a pointer.
            mov rdi, rax                    ; prev_node = curr_node.
            inc rcx
            jmp .createList

        .endCreateList:

        ; Now, let's print the linked list.
        mov rdi, [head]                     ; curr_node.
        push 0                              ; To fix stack alignment due to 
                                            ; `movaps` instruction in `printf`.

        .while:
            test rdi, rdi                   ; If curr_node == NULL.
            jz .endWhile

            push rdi                        ; Save curr_node. Alternatively, 
                                            ; you could use a non-volatile 
                                            ; register or a local stack 
                                            ; variable.
            mov rsi, [rdi + node.value]
            mov rdi, msg
            call printf                     ; libc function or you could use 
                                            ; syscalls or a custom print 
                                            ; function or macro using syscalls.
            pop rdi                         ; Restore curr_node.
            mov rdi, [rdi + node.next]      ; curr_node = curr_node.next.
            jmp .while

        .endWhile:

        pop rax                             ; Restore from `movaps` fix.
        xor rax, rax                        ; EXIT_SUCCESS.
        jmp .end

        .err:
            or rax, EXIT_FAILURE

        .end:
            leave
            ret

    ; End main.


    ; void* allocate(size_t bytes);
    ; As an allocation example for heap using syscalls. If you are using libc, 
    ; you could `malloc` or some other heap manager.
    allocate:
        push rbp
        mov rbp, rsp
        push r12
        push r13

        mov r12, rdi            ; num_bytes.
        mov rax, SYS_BRK
        xor rdi, rdi
        syscall

        mov r13, rax            ; curr_brk.
        mov rax, SYS_BRK
        lea rdi, [r13 + r12]    ; desired_brk.
        syscall

        cmp rax, r13            ; Is new_brk == curr_brk.
        je .err

        ; Zero memory. Avoids uninitialized memory warnings.
        mov rdi, r13
        mov rcx, r12
        mov al, NULL
        cld
        rep stosb
        mov rax, r13            ; Returns pointer to new allocation.
        jmp .end

        .err:
            xor rax, rax        ; Return NULL on error.

        .end:
            pop r13
            pop r12
            leave
            ret

    ; End allocate.
```

When run, output is:

```
Element: 12
Element: 333
Element: 4522
Element: 24134
Element: 99
```


## Sources

None.


## Required Additional Readings

None.


## Resources

1. ***5.9 Structure Data Types***. 
https://www.nasm.us/doc/nasmdoc5.html#section-5.9.1. 
NASM Manual Chapter on Structures. 


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
