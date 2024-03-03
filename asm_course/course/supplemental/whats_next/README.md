
# 🎉 CONGRATULATIONS!

[<&nbsp;&nbsp; Previous Section](../3-27_structs/README.md) 

Congratulations, you completed the course!

Eventhough, you completed the course, there is still much to learn about 
assembly, including position-independent code (PIC), shellcode, 32-bit x86 
assembly, Windows assembly, assembly optimizations, floating point in 
assembly, ARM assembly, MIPS assembly, and much more.

For example, this course did not go over floating point operations. Check this 
out:

``` x86asm
    cvtsi2sd xmm0, edi              ; x.
    movsd   qword [a], xmm0         ; a = x.
    mulsd   xmm0, xmm0              ; x^2.
    
    movsd   xmm1, qword [b]         ; 1 for arcsin(x) = arctan(x/sqrt(1-x^2)).
    subsd   xmm1, xmm0              ; 1 - x^2.
    sqrtsd  xmm0, xmm1              ; sqrt(1 - x^2).
    movsd   qword [b], xmm0

    fld     qword [a]               ; st(0) = x.
    fld     qword [b]               ; st(0) = sqrt(1 - x^2), st(1) = x.
    fpatan                          ; arcsin(x) in radians.
    fstp    qword [result]          ; q = arcsin(x).

    movsd   xmm0, qword [result]
    mulsd   xmm0, qword [degrees]
    divsd   xmm0, qword [pi]
    movsd   qword [result], xmm0

    cvtsd2si eax, qword [result]    ; Convert.
```

Here are some sources for information on floating point in 64-bit x86 assembly:

- https://en.wikibooks.org/wiki/X86_Assembly/Floating_Point

- https://eng.libretexts.org/Bookshelves/Computer_Science/Programming_Languages/x86-64_Assembly_Language_Programming_with_Ubuntu_(Jorgensen)/18%3A_Floating-Point_Instructions

- https://redirect.cs.umbc.edu/portal/help/nasm/sample_64.shtml

There are tons of other resources online as well. Feel free to talk to an instructor about where to go next. 


## Goodbye

Congratulations on your new skill. Few have such a skill, and this skill will 
help you greatly with programming, computer engineering, understanding 
computers, cybersecurity, exploit development, bug hunting, and much more. 

Again, Congrats and happy coding!


<!--- End of file. --->
