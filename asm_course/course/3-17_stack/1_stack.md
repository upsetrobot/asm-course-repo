
# 🥞 3-17 Stack - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [What is the Stack?](#what-is-the-stack)
- [`push` Instruction](#push-instruction)
- [`pop` Instruction](#pop-instruction)
- [Other `push` and `pop` Instructions](#other-push-and-pop-instructions)
- [Using the Stack](#using-the-stack)
    - [Local Variables](#local-variables)
    - [Saving and Restore Registers](#saving-and-restore-registers)
    - [Passing Variables on the Stack](#passing-variables-on-the-stack)
    - [Temporary Storage](#temporary-storage)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## What is the Stack?

First, what is "a" stack? A stack is a type of data structure that uses a 
last-in, first-out (LIFO) interface. In other words, it is just a type of list 
or array or thing (can be implemented in many different ways) where you can 
place new things on top, and you can pull things off the top. The traditional 
analogy is a stack of pancakes or a stack of plates; you cannot easily get 
the bottom plate without moving all the plates on top. Stacks have some 
interesting properties and applications, such as being able to be used as 
models for both binary and unary arithmetic operations. As items are added to 
the stack, the stack size grows, so it is usually considered a dynamic 
structure. Stacks are used in all kinds of programming, but "the" stack is a 
specific block of memory used by a thread or process to hold dynamic data used 
during execution of a program. It has multiple benefits and is primarily used 
to hold function arguments, local variables, and the processor state. It is a 
chunk of memory setup by the operating system when your program is loaded 
and executed. There are many sources you can use to learn more about stacks if 
needed. Here is one on stack 
[data structures](https://www.geeksforgeeks.org/stack-data-structure/) and 
here is one on the stack as used in 
[assembly](https://ctf101.org/binary-exploitation/what-is-the-stack/). 

Stacks, including "the" stack, use "push" and "pop" operations to place and 
remove items from the stack. In x86 assembly, the stack grows "up" (depending 
on how you think about it) by subtracting from `rsp` during any `push` or 
`sub rsp` operations. This makes the stack bigger. The stack gets smaller when 
you add to `rsp` during `pop` or `add rsp` operations. If you want to access 
memory on the stack, you can reference it by adding to `rsp` or even by adding 
or subtracting from `rbp` if you are using stack frames. `rsp` (or `esp` in 
32-bit assembly programming) always points to the top element of the stack. 

For 32-bit mode, The registers `SS` and `ESP` (or `SP`) are used for
implementing the stack. The top of the stack, which points to the last data
item inserted into the stack is pointed to by the `SS:ESP` register, where the
`SS` register points to the beginning of the stack segment and the `SP` (or
`ESP`) gives the offset into the stack segment [[1]](#sources).

Stack frames are just sections of the stack that are marked for one function. 
Many functions start with the operations `push rbp` which saves the old stack 
frame base pointer, and then `mov rbp, rsp` which creates a new stack frame. 
The end of the function will then have `mov rsp, rbp` which destroys the stack 
frame and `pop rbp` to restore the old stack frame. 

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
The `leave` and `enter` instructions can also be used to create stack frames 
and allocate stack room. If not given arguments, they are equivalent to the 
manual way of setting up a stack frame. However, some sources state the 
`enter` instruction is slightly slower than `mov`s and `push`s, so that may be 
why most C compilers don't use them.
</span></span>

If you think about memory from lowest address first, a 8-byte aligned stack 
may look something like this:

```
Address     Value
0x00        0x0000000000000000
...

[.text section]
...

[.data section]
...

[.bss section]
...

[heap] (grows down)
...

[stack] (grows up)              ; Next `push` goes here and `rsp` move up.
0x7f...08   0xaabbccdd11223344  ; If you `pop`, `rsp` moves down.
0x7f...10   0x6
0x7f...18   0x5
0x7f...20   0x4
0x7f...28   0x3
0x7f...30   0x2
0x7f...38   0x1
[base of stack]

[kernel memory]
...

0xff...ff
```

If you would like more info on understanding Linux `elf` memory layout, 
[this](https://gist.github.com/CMCDragonkai/10ab53654b2aa6ce55c11cfc5b2432a4) 
is an interesting source that shows some techniques for investigating the 
matter further.


## `push` Instruction

Decrements the stack pointer and then stores the source operand on the top of
the stack. [[2]](#sources).

Note that you can push immediates and different sizes of memory chunks. This 
is based on the operand size. You can push words, doublewords, and quadwords 
onto the stack (not bytes). The most common use of `push` is to save register 
values. 

Example:

``` x86asm
myFunction:
    push rbp        ; Save old frame pointer.
    mov rbp, rsp    ; Make new frame.

    ; Stack at this point has old stack stuff, then caller address, then old 
    ; frame pointer on top.

    mov rax, 22
    push rax        ; Puts `22` on top of the stack (and subtracts 8 from `rsp`).

    add rax, 33
    push rax        ; Puts `33` on top of the stack.

    mov rax, 44
    push rax        ; Puts `44` on top the stack.

    ; Now stack needs to be restored before exiting function. So every stack 
    ; push needs an accompanying `pop` or `add` to `rsp`.

    pop rdx         ; `rdx` = `44`.
    pop rcx         ; `rcx` = `33`.
    pop rax         ; `rax` = `22`.

    leave           ; In this case, same as `mov rsp, rbp`, and `pop rbp`.
    ret             ; Return to caller with old frame setup.
```

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
Notice that values come off of the stack in the reverse order from how they 
went onto the stack. So, if you push `rax`, then `rcx`, then `rdx` and you 
want to restore those registers, you have to pop `rdx` first, then `rcx`, and 
then `rax`.
</span></span>


## `pop` Instruction

Loads the value from the top of the stack to the location specified with the
destination operand (or explicit opcode) and then increments the stack pointer.
The destination operand can be a general-purpose register, memory location, or
segment register. [[3]](#sources).


## Other `push` and `pop` Instructions

There are other `push` and `pop` instructions that you should be familiar 
with. If you want to save the flags, you can use `pushf` and `popf`. `pusha` 
and `popa` are for pushing and popping all general purpose registers, but 
these two instructions are not valid in 64-bit mode.


## Using the Stack

You can use the stack for anything you want in assembly. But the most common 
uses are for storing local variables, saving and restoring registers when 
calling functions or using other blocks of code that use those registers, and 
passing arguments to functions or other code blocks.

### Local Variables

You can put a space on the stack and use those spots to store values for later 
(this is how C local variables are compiled). Some functions may need more 
variables than there are registers, so using the stack becomes necessary.

For example:

``` x86asm
myFunction:
    push rbp
    mov rbp, rsp

    sub rsp, 16             ; Give me space for four ints.
                            ; Let's call them d, c, b, and a.
    mov [rsp + 0], 1        ; a = 1.
    mov [rsp + 4], 2        ; b = 2.
    mov [rsp + 8], 3        ; c = 3.
    mov [rsp + 12], 4       ; d = 4.

    mov eax, [rsp + 0]
    add eax, [rsp + 4]      ; eax = a + b.
    sub eax, [rsp + 8]      ; eax = a + b - c.
    mov [rsp], eax          ; a = a + b - c.
    inc dword [rsp + 12]    ; d++.

    inc dword [rbp - 8]     ; Variables can be referenced with `rbp` as well.
                            ; Notice `rsp + 12` and `rbp - 8` are the same.
                            ; d++.

    ...

    ; All done, get rid of variables before returning.
    add rsp, 16
    mov rsp, rbp
    pop rbp
    ret
```


### Saving and Restore Registers

You can use the stack to save register values before calls to functions or 
sections of code that may mess with those registers.

For example:

``` x86asm
    ...
    xor rcx, rcx                    ; Use `rcx` as a counter.
    xor rdx, rdx                    ; Use `rdx` for tracking something.

    .loop:
        cmp rcx, 10
        je .endLoop

        push rdx                    ; Save the tracker.
        push rcx                    ; Save the counter.
        call myOtherFunction        ; Function also uses `rcx` and `rdx`.
        pop rcx                     ; Restore the counter.
        pop rdx                     ; Restore the tracker.

        add rdx, rax                ; Use the tracker.

        inc rcx                     ; Continue counting.
        jmp .loop

    .endLoop:
        ...
```


### Passing Variables on the Stack

Some calling conventions require use of the stack. You can use the stack to 
pass arguments to functions. Typical x86 Linux calling convention uses the 
stack for functions with more than six variables. But you can use your own 
calling convention for your own functions and pass all variables on the stack 
if you wanted to.

For example:

``` x86asm
myFunction:
    enter

    mov rdi, 1
    mov rsi, 2
    mov rdx, 3
    mov rcx, 4
    mov r8, 5
    mov r9, 6
    push 10                 ; Notice reverse order.
    push 9
    push 8
    push 7
    call nextFunction       ; nextFunction(rdi, rsi, rdx, rcx, r8, r9, 7, 8, 9, 10);

    add rsp, 0x20           ; Fix stack.

    ...

    leave
    ret


nextFunction:
    enter

    inc qword [rbp + 0x10]  ; Argument 7++. 
                            ; Notice that rbp + 0 is old frame pointer.
                            ; rbp + 8 is the return pointer.
                            ; So rbp + 16 is argument 7.
    mov rax, [rbp + 0x18]   ; `rax` = argument 8.

    ...

    leave
    ret
```


### Temporary Storage

You can use the stack for temporary storage of values. This may be useful when 
you just want to save a register or when you don't know how many values you 
are dealing with.

For example:

``` x86asm
myFunction:
    push rbp
    mov rbp, rsp

    ; In this case, rdi points to a null-terminated long long array.

    xor rcx, rcx                ; Setup counter.

    .loop:
        cmp qword [rdi], 0
        jz .endLoop

        push qword [rdi]        ; Save value on stack.
        add rdi, 8              ; Move to next item.
        inc rcx                 ; Count item.
        jmp .loop

    .endLoop:

    push rcx                    ; Save count.
    mov rdi, rcx                ; Put count in rdi.
    shl rdi, 3                  ; Multiply by 8 bytes.
    call malloc                 ; Allocate space for array.

    pop rcx                     ; Restore array length.

    mov rdi, rax

    .store:
        pop rdx                 ; Get value off stack.
        mov qword [rax], rdx    ; Save value in new memory.
        add rax, 8              ; Move to next slot.
        loop .store             ; Decrement rcx and jump up to .store.

    mov rax, rdi                ; Return pointer to copied array.

    ; Note that array was copied in reverse order, so it is reversed.

    leave
    ret
```


## Sources

1. *Assembly - Procedures*.
https://www.tutorialspoint.com/assembly_programming/assembly_procedures.htm.
2. *PUSH - Push Word, Doubleword, or Quadword onto the Stack*. 
https://www.felixcloutier.com/x86/push.
3. *POP - Pop a Value from the Stack*. 
https://www.felixcloutier.com/x86/pop.


## Required Additional Readings

None.


## Resources

None.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
