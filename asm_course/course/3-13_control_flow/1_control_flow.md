
# 🎛️ 3-13 Control Flow - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Introduction to Control Flow](#introduction-to-flow-control)
- [If Statements](#if-statements-cmp)
- [Goto Statements](#goto-statements-jmp)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Introduction to Flow Control

Control flow is the ability to allow different sections of code to be executed 
under different conditions. One way to think about control flow is in the 
context of if-else statements. "If this is true, then do that; else do this" 
is a fundamental statement in programming (try programming without such an 
ability). For loops and while loops in traditional programming languages are 
just special if-else statements or combinations of them and goto statements.
We will discuss those in the next module. For this module, we will discuss the 
traditional if-else statements, goto statements, and variations of control 
flow. 

You do not need to memorize or learn any specific control flows. The purpose 
of this lesson is to get you to think about logical controls flows and to see 
examples of the flexibility of control flow in assembly programming.


## If Statements (`cmp`)

In assembly, you may want execution to go one of two paths depending on a 
condition. This is the basic if statement in most programming and scripting 
languages. In assembly, there are many ways to change code execution, but the 
most common is via the use of the `cmp` instruction followed by a `jcc` 
instruction.

Consider the example where you want to add a number to value if it is 
positive, but you want to subtract it if it is negative. You could check the 
value and then add or subtract depending on the value, so you two code blocks 
of execution.

```x86asm
    ...

    cmp rcx, 0
    jge .positive           ; Split code blocks here.

    .negative:
        sub rax, rcx
        jmp .end

    .positive:
        add rax, rcx

    .end:                   ; Both code blocks merge again here.
        ...
```

This is equivalent to a basic if-else statement as in the C pseudo-code below:

```c
...

if (c >= 0)
    a += c;

else
    a -= c;

...
```

If you wanted to do one test like a regular if statement, you just skip a 
block of code. Sometimes, you may want to invert your condition to simplify 
your code jumps (instead of comparing for equal, perhaps you could compare to 
not equal). 

```x86asm
    ...

    cmp rcx, 0
    jne .cont           ; If not what you want, skip.

    add rax, rcx        ; This block is skipped by the conditional.

    .cont:
        inc rax

    .end:
        ...

    ; Alternatively, you could keep the jump as `je` like this.
    ...

    cmp rcx, 0
    je .over            ; Notice above that we turned two jumps into one by 
    jmp .cont           ; changing `je` to `jne`.

    .over:
        add rax, rcx

    .cont:
        inc rax

    .end:
        ...
```

The example above is logically equivalent to the if statement below:

```c
...

if (c == 0)             // Notice that the condition in C is equals, but our 
    a += c;             // assembly conditional was not equals.

a++;

...
```

You can also check several conditions similar to switch statements or else-if 
statements.  Here is an example:

```x86asm
    ...

    cmp rcx, 0
    je .zero

    cmp rcx, 1
    je .one

    cmp rcx, 2
    je .two
                            ; <-- If you had an "else", you could put it here
                            ; before the jump.
    jmp .end                ; Notice two jumps here, one conditional and one 
                            ; unconditional for all other cases.
    .zero:
        mov rax, 0
        jmp .end

    .one:
        mov rax, 1
        jmp .end

    .two:
        mov rax, 2

    .end:
        ret
```

This is logically equivalent to the statement below:

```c
...

if (c == 0) {
    a = 0;

} else if (c == 1) {
    a = 1;

} else if (c == 2) {
    a = 2;

} else {
    // Nothing.
}

return a;
```

You can also compile C code and see how the compiler handles different types 
of statements. You will do this in the application section.

For example:

```c
void basicIfTest() {
    int test = 0;

    if (test == 1)
        test++;

    test--;
}
```

The `gcc` compiler turns this C code into this assembly (we used `objdump` to 
inspect the assembly):

```x86asm
    <basicIfTest>:
        endbr64             ; Framing.
	    push   rbp
	    mov    rbp,rsp

	    mov    DWORD PTR [rbp-0x4],0x0      ; `test = 0`.

	    cmp    DWORD PTR [rbp-0x4],0x1      ; if `(test == 1)`.
	/-- jne    <basicIfTest+0x19>
    |
	|   add    DWORD PTR [rbp-0x4],0x1      ; `test++`.
    |
	\-> sub    DWORD PTR [rbp-0x4],0x1      ; `test--`.

	    nop                 ; Framing.
	    pop    rbp
	    ret

    ; With `dwarf` debugging info, the object dump looks like this:
    void basicIfTest() {
            endbr64 
            push   rbp
            mov    rbp,rsp
        int test = 0;
            mov    DWORD PTR [rbp-0x4],0x0

        if (test == 1)
            cmp    DWORD PTR [rbp-0x4],0x1
        /-- jne    <basicIfTest+0x19>
        |   test++;
        |   add    DWORD PTR [rbp-0x4],0x1
        |
        test--;
        \-> sub    DWORD PTR [rbp-0x4],0x1
    }
            nop
            pop    rbp
            ret 

```

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
`nop` instructions are "no operation" (aka "no op") instructions. They do not 
do anything but allow the processor `IP` to continue. In other words, they are 
just spacers. `push`, `pop`, `ret` will be discussed in a later module. The 
`endbr64` is basically a `nop` as well and is used for some security measures 
on some processors and is not discussed in this course. 
[Here](https://stackoverflow.com/questions/56905811/what-does-the-endbr64-instruction-actually-do)
is some more information if you are interested.
</span></span>

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


## Goto Statements (`jmp`)

In assembly, you may want execution points to go to one path from multiple 
locations. This is similar to a traditional goto statement.

```x86asm
    ...

    add rcx, 3
    cmp rcx, 1000
    jl .end

    sub rcx, 200
    cmp rcx, 10
    jg .end

    mov rax, rcx
    xor rdx, rdx
    mov rbx, 100
    mul rbx
    mov rcx, rax

    cmp rcx, 1000
    jge .end

    inc rcx

    .end:
        mov rax, rcx
        ret
```

This is logically equivalent to the C goto statements below:

```c
...

c += 3;
if (c < 1000)
    goto end;

c -= 200;
if (c > 10)
    goto end;

c *= 100;
if (c >= 1000)
    goto end;

c++;

end:
    a = c;
    return;
```

`gcc` turns the above C code into the following assembly:

```x86asm
void basicGotoTest(int a, int c) {
	             endbr64 
	             push   rbp
	             mov    rbp,rsp
	             mov    DWORD PTR [rbp-0x4],edi
	             mov    DWORD PTR [rbp-0x8],esi
    
    c += 3;
	             add    DWORD PTR [rbp-0x8],0x3
    if (c < 1000)
	             cmp    DWORD PTR [rbp-0x8],0x3e7
	/----------- jle    <basicGotoTest+0x40>
    |   goto end;
    |
    c -= 200;
	|            sub    DWORD PTR [rbp-0x8],0xc8
    if (c > 10)
	|            cmp    DWORD PTR [rbp-0x8],0xa
	|  /-------- jg     <basicGotoTest+0x43>
    |   goto end;
    |  |
    c *= 100;
	|  |         mov    eax,DWORD PTR [rbp-0x8]
	|  |         imul   eax,eax,0x64
	|  |         mov    DWORD PTR [rbp-0x8],eax
    if (c >= 1000)
	|  |         cmp    DWORD PTR [rbp-0x8],0x3e7
	|  |  /----- jg     <basicGotoTest+0x46>
    |   goto end;
    |  |  |
    c++;  |
	|  |  |      add    DWORD PTR [rbp-0x8],0x1
	|  |  |  /-- jmp    <basicGotoTest+0x47>
    |   goto end;
	\--|--|--|-> nop
	   |  |  +-- jmp    <basicGotoTest+0x47>
        goto end;
	   \--|--|-> nop
	      |  +-- jmp    <basicGotoTest+0x47>
        goto end;
	      \--|-> nop
             |
    end:     |
        a = c;
	         \-> mov    eax,DWORD PTR [rbp-0x8]
	             mov    DWORD PTR [rbp-0x4],eax
        return;
	             nop
}
	             pop    rbp
	             ret
```

It's interesting that the compiler inserts extra `nop`s and `jmp`s. Different 
compilers may implement control flow and other functions differently. You can 
make all kinds of control flows. Control flow can be an area of logic errors 
or small space or logic optimization opportunities. Here is an example of a 
more custom goto control flow:

```x86asm
    test rcx, rcx
    js .block2

    .block1:
        or rcx, 33
        inc rcx
        jmp .rightBeforeEnd         ; This is the custom goto.

    .block2:
        or rcx, 24
        and rcx, 4000
        dec rcx
        cmp rcx, 10000
        jl .end                     ; This is a conditional goto.

        inc rcx
        sub rcx, 1000

    .rightBeforeEnd:
        add rcx, 0x22

    .end:
        ret
```

And the logically equivalent weird function looks something like this:

```c
if (c < 0) {
    c |= 24;
    c &= 4000;
    c--;
    
    if (c < 10000)
        goto end;

    c++;
    c -= 1000;

} else {
    c |= 33;
    c++;
}

c += 0x22;

end:
    return;
```

And the compiler produces this:

```x86asm
void weirdControlFlowTest(int c) {
	          endbr64 
	          push   rbp
	          mov    rbp,rsp
	          mov    DWORD PTR [rbp-0x4],edi
    if (c < 0) {
	          cmp    DWORD PTR [rbp-0x4],0x0
	/-------- jns    <weirdControlFlowTest+0x36>
    |   c |= 24;
	|         or     DWORD PTR [rbp-0x4],0x18
    |   c &= 4000;
	|         and    DWORD PTR [rbp-0x4],0xfa0
    |   c--;
	|         sub    DWORD PTR [rbp-0x4],0x1
    |   
    |   if (c < 10000)
	|         cmp    DWORD PTR [rbp-0x4],0x270f
	|  /----- jle    <weirdControlFlowTest+0x44>
    |  |    goto end;
    |  |
    |   c++;
	|  |      add    DWORD PTR [rbp-0x4],0x1
    |   c -= 1000;
	|  |      sub    DWORD PTR [rbp-0x4],0x3e8
	|  |  /-- jmp    <weirdControlFlowTest+0x3e>
    |  |  |
    } else {
    |   c |= 33;
	\--|--|-> or     DWORD PTR [rbp-0x4],0x21
        c++;
	   |  |   add    DWORD PTR [rbp-0x4],0x1
    }  |  |
       |  |
    c += 0x22;
	   |  \-> add    DWORD PTR [rbp-0x4],0x22
       |
    end:
        return;
	   |  /-- jmp    <weirdControlFlowTest+0x45>
       |  | goto end;
	   \--|-> nop
        return;
	      \-> nop
}
	          pop    rbp
	          ret 
```


## Sources

None.


## Required Additional Readings

None.


## Resources

1. ***x86 Assembly/Control Flow***. 
https://en.wikibooks.org/wiki/X86_Assembly/Control_Flow. 
Wiki on several control flow mechanisms in assembly.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
