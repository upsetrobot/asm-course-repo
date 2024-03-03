
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-13 Control Flow - Lab Solution
;;
;; This file is module specific and contains solutions for the module lab.
;;
;; @file        lab_solution.asm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        02 Mar 2024
;; @copyright   Copyright (c) 2024
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;         _/_/      _/_/_/  _/      _/   
;;      _/    _/  _/        _/_/  _/_/    
;;     _/_/_/_/    _/_/    _/  _/  _/     
;;    _/    _/        _/  _/      _/      
;;   _/    _/  _/_/_/    _/      _/ 
;; 
;; The basics of the Linux x64 calling convention:
;;
;;     - Arguments are passed in `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`, in 
;;       that order and any additional arguments are passed on the stack.
;;     - The return value is stored in rax.
;;
;; You can reference the System V ABI manual for more details.
;; The Intel Manual, Volume 2 has detailed information about how each
;; instruction behaves.
;;
;; Good luck! Have fun!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


section .text

global studentFunction1
global studentFunction2
global studentFunction3
global studentFunction4
global studentFunction5
global studentFunction6
global studentFunction7
global studentFunction8
global studentFunction9
global studentFunction10



; 1. Conditional Subtraction.
;
; long long studentFunction1(long long a, long long b);
;
; @brief    Function sums `a` and `b` and subtracts `1` from sum if `a` is 
;           positive.
;
;           Pseudocode: `return a + b - 1 if a >= 0 else a + b`.
;
; @param    a           Agend to add to `b` and value to test if positive. If 
;                       positive, subtract 1 from sum.
; @param    b           Addend to add to `a`.
; @return   long long   Returns `a + b` if `a` is negative; else returns 
;                       `a + b - 1` if `a` is positive.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction1:

    ; --- Add your solution below this line -----------------------------------

    mov rax, rdi
    add rax, rsi            ; ret = a + b.
    test rdi, rdi           ; if (a < 0)
    js .end                 ; return ret.

    dec rax                 ; else return ret - 1.

    .end:

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



; 2. Return 1 or 0.
; 
; long long studentFunction2(long long a, long long b);
;
; @brief    Function returns `1` if `a` is less than `b`. Otherwise returns `0`.
;
;           Pseudocode: `return 1 if a < b else 0`.
;
; @param    a           Argument to test if less than `b`.
; @param    b           Argument to test if greater than or equal to `a`.
; @return   long long   Returns `1` if `a` is less than `b`. 
;                       Otherwise returns `0`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction2:

    ; --- Add your solution below this line -----------------------------------

    xor rax, rax            ; ret = 0.
    cmp rdi, rsi            ; if (a >= b)
    jge .end                ; return 0.

    inc rax                 ; else return ret + 1.

    .end:

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction2.



; 3. Absolute Value.
;
; unsigned int studentFunction3(int a);
;
; @brief    Function returns the absolute value of `a`.
;
; @param    a               Number to return absolute value of.
; @return   unsigned int    Absolute value of `a`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction3:

    ; --- Add your solution below this line -----------------------------------

    mov eax, edi
    test eax, eax
    jns .end

    not eax
    inc eax

    .end:

    ; Alternative Solution:
    ; mov eax, edi
    ; cqd
    ; xor eax, edx

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction3.



; 4. If-Then-Else.
;
; long long studentFunction4(long long a, long long b);
;
; @brief    Function returns product of `a` and `b` if the sum of `a` and `b` 
;           is greater than 100, `a` shifted right by 4 bits if the difference 
;           between `a` and `b` is less than `0`, otherwise returns `0`.
; 
;           Pseudocode:
;               `if a + b > 100, return a * b
;               else if a - b < 0, return a >> 4
;               else return 0`
;
; @param    a           Argument to sum with `b` and multiplicand to multiply 
;                       with `b` if sum is greater than `100` or return value 
;                       to bit-shift right by `4` if difference betwen 
;                       argument and `b` is negative.
; @param    b           Argument to add to `a` to find if sum is greater than 
;                       `100` or argument to subtract from `a` to find if 
;                       difference is negative.
; @return   long long   Returns `a * b` if `a + b > 100`, else returns `a >> 4` 
;                       if `a - b < 0`, else returns `0`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction4:

    ; --- Add your solution below this line -----------------------------------

    xor rax, rax                ; ret = 0.
    mov rcx, rdi
    add rcx, rsi
    cmp rcx, 100                ; if (a + b > 100).
    jg .product                 ; goto a * b.

    cmp rdi, rsi                ; else if (a - b < 0).
    js .shift                   ; goto a >> 4.
    jmp .end                    ; else return ret.

    .product:
        mov rax, rdi
        cqo
        imul rsi                ; ret = a * b.
        jmp .end

    .shift:
        mov rax, rdi
        shr rax, 4              ; ret = a >> 4.

    .end:

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction4.



; 5. Switch.
; 
; long long studentFunction5(char a, long long b, long long c);
;
; @brief    Function check character `a` for operation to perform on `b` and 
;           `c`. Accepted operators are '+', '-', '*' (multiply), '/' (integer 
;           division), '%' (modulo), or '^' (XOR addition). If an invalid 
;           operator is given, function returns special error code 
;           `0xbaddda7abaddda7a`. Returns error code `0x6469766572726f72` upon 
;           division by zero.
;
;           Pseudocode:
;               `if a == '+' return b + c
;               else if a == '-' return b - c
;               else if a == '*' return b * c
;               else if a == '/' and c == 0 return 0x6469766572726f72
;               else if a == '/' and c != 0 return b // c
;               else if a == '%' and c == 0 return 0x6469766572726f72
;               else if a == '%' and c != 0 return b mod c
;               else if a == '^' return b xor c
;               else return 0xbaddda7abaddda7a`.
;
; @param    a           Operator selector. May be '+', '-', '*', '/', '%', or 
;                       '^'.
; @param    b           First operand.
; @param    c           Second operand.
; @return   long long   Returns the selected operation result of the two 
;                       operands depending the the operator `a`. Returns sum 
;                       `b` and `c` if `a` is '+', the difference between `b` 
;                       and `c` if `a` is '-', the product of `b` and `c` if 
;                       `a` is '*', the integer quotient of `b` and `c` if `a` 
;                       is '/', the modulus of `b` and `c` if `a` is '%', the 
;                       XOR sum of `b` and `c` if `a` is '^', or the error 
;                       code `0xbaddda7abaddda7a` if an invalid code is given 
;                       in `a`. Function also returns the error code 
;                       `0x6469766572726f72` if division by zero occurs.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
;
studentFunction5:

    ; --- Add your solution below this line -----------------------------------
    
    mov rax, rsi
    mov rcx, rdx

    cmp dil, '+'
    je .plus

    cmp dil, '-'
    je .minus

    cmp dil, '*'
    je .times

    cmp dil, '/'
    je .divide

    cmp dil, '%'
    je .mod

    cmp dil, '^'
    je .xor
    jmp .err

    .plus:
        add rax, rcx
        jmp .end

    .minus:
        sub rax, rcx
        jmp .end

    .times:
        cqo
        imul rcx
        jmp .end

    .divide:
        test rcx, rcx
        jz .err0

        cqo
        idiv rcx
        jmp .end

    .mod:
        test rcx, rcx
        jz .err0

        cqo
        idiv rcx
        mov rax, rdx
        jmp .end

    .xor:
        xor rax, rdx
        jmp .end

    .err0:
        mov rax, 0x6469766572726f72
        jmp .end

    .err:
        mov rax, 0xbaddda7abaddda7a

    .end:
    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction5.



; ********************************* NOT USED **********************************
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
