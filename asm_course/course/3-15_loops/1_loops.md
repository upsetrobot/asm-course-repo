
# ➿ 3-15 Loops - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Introduction to Loops](#introduction-to-loops)
- [For Loops](#for-loops)
- [While Loops](#while-loops)
- [Do-while Loops](#do-while-loops)
- [Other Loops?](#other-loops)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Introduction to Loops

Loops are very flexible in assembly. You can make traditional "for" loops, 
"while" loops, "do-while" loops, or even custom loops. 


## For Loops

The traditional for loop has a counter and one or more conditions to exit the 
loop. This is easy to do in assembly. If you want to do something 10 times, 
there are two main ways to set up your for loop:


``` x86asm
myForLoopExample1:
    ...

    xor rcx, rcx        ; Setup "i = 0".

    .for:               ; Your loop label.
        cmp rcx, 10     ; "i < 10".
        je .endFor      ; Your loop exit label.

        ...             ; Do something.

        inc rcx         ; Your "i++".
        jmp .for

    .endFor:
        ...             ; Outside of loop.

    ret


myForLoopExample2:
    ...

    mov rcx, 10         ; Setup "i = 10"

    .for:
        ...             ; Do something.
        
        loop .for       ; "i > 0" and "i--".

    ...                 ; Outside loop.

    ret


myForLoopExample3:
    ...

    mov rcx, 10

    .for:
        ...         ; Do something.

        dec rcx     ; "i--".
                    ; Zero flag will be set when this operation results in `0`.
        jz .for     ; "i > 0".

    ...             ; Outside of loop.
```

You can even use negative numbers and count up if you want or use other for 
loop variations. Let us see what the `gcc` compiler does.

```c
void simpleForLoop() {
    int a = 11;
    for (unsigned int i = 0; i < 10; i++)
        a++;
    return;
}
```

The compiler produces assembly something like this:

``` x86asm
void simpleForLoop() {
	       endbr64 
	       push   rbp
	       mov    rbp,rsp

    int c = 11;
	       mov    DWORD PTR [rbp-0x8],0xb

    for (unsigned int i = 0; i < 10; i++) {
	       mov    DWORD PTR [rbp-0x4],0x0
	   /-- jmp    <simpleForLoop+0x20>
       |
        c++;
	/--|-> add    DWORD PTR [rbp-0x8],0x1
    |  |
    for (unsigned int i = 0; i < 10; i++) {
	|  |   add    DWORD PTR [rbp-0x4],0x1
	|  \-> cmp    DWORD PTR [rbp-0x4],0x9
	\----- jbe    <simpleForLoop+0x18>
    }

    return;
	       nop
	       pop    rbp
	       ret
```

So it looks like the compiler does the same thing, but it puts the compare at 
the bottom of the loop.

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
To do this yourself, you can write a C file, then use the `-g` flag of `gcc` 
to compile with source code like `gcc -g investigate.c -o investigate`. Then 
you can use flags of `objdump` to customize the output of the disassembly like 
`objdump -d -M intel investigate -S --no-show-raw --no-addresses `
`--visualize-jumps=color`. `-S` is for including the source if you want. 
`--no-show-raw` removes the machine code from the output. `--no-addresses` 
removes the addresses from the output. And `--visualize-jumps` shows the 
jump links.
</span></span>


## While Loops

While loops are just more generalized for loops. You can easily make while 
loops in assembly.

``` x86asm
    ...

    .while:
        test rdi, rdi       ; "while (rdi != NULL)". 
        jz .endWhile

        ...                 ; Do something.

        jmp .while

    .endWhile:
        ...
```

Here is a simple while loop in C:

``` c
void simpleWhileLoop() {
    int a = 10;
    while (a)
        a--;
    return;
}
```

And here is how `gcc` compiles it:

``` x86asm
void simpleWhileLoop() {
	       endbr64 
	       push   rbp
	       mov    rbp,rsp

    int a = 10;
	       mov    DWORD PTR [rbp-0x4],0xa

    while (a)
	   /-- jmp    <simpleWhileLoop+0x15>
       |
        a--;
	/--|-> sub    DWORD PTR [rbp-0x4],0x1
    |  |
    while (a)
	|  \-> cmp    DWORD PTR [rbp-0x4],0x0
	\----- jne    <simpleWhileLoop+0x11>

    return;
	       nop
}
	       pop    rbp
	       ret
```


## Do While Loops

Do-while loops just do something at least once before checking for a 
condition. These can be done in assembly as well. You just put the condition 
at the bottom of the block:

``` x86asm
    ...

    .do:
        ...                 ; Do something.

        cmp rcx, 100
        jle .do             ; "while (rcx <= 100)".

    ...                     ; Outside of loop.
```

Here is a simple do-while loop in C:

``` c
void simpleDoWhileLoop() {
    int a = 10;
    do
        a--;
    while (a);
}
```

And here is how `gcc` compiles it:

``` x86asm
void simpleDoWhileLoop() {
	    endbr64 
	    push   rbp
	    mov    rbp,rsp

    int a = 10;
	    mov    DWORD PTR [rbp-0x4],0xa

    do
        a--;
	/-> sub    DWORD PTR [rbp-0x4],0x1
    |
    while (a);
	|   cmp    DWORD PTR [rbp-0x4],0x0
	\-- jne    <simpleDoWhileLoop+0xf>
}
	    nop
	    nop
	    pop    rbp
	    ret 
```


## Other Loops?

In assembly, you can make custom complex loops. You can make nested loops, 
loops that jump into each other, recursive loops, or virtually any loops you 
could think of.

For example, here are some interconnected loops:

``` x86asm
    ...

    .label1:
        test rcx, rcx
        jz .label2

        test rax, rax
        js .out

        ...             ; Do something.

        jmp .label1

    .label2:
        test rax, rax
        jz .label3

        ...             ; Do something.

        jmp .label1

    .label3:
        ...             ; Do something.

        dec rcx
        jmp .label2

    .out:
        ...
```


## Sources

None.


## Required Additional Readings

None.


## Resources

None.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
