
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-11 Competency 2 Cannon Fire - Competency Lab
;;
;; This file is module specific and houses assembly application labs for 
;; students. Students should edit this file and run `make` to test their 
;; solutions.
;;
;; @file        4_lab.nasm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        13 Feb 2024
;; @copyright   Copyright (c) 2024
;;
;; Student TODO:    Complete the lab assignment below.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  
;;    _|_|      _|_|_|  _|      _|
;;  _|    _|  _|        _|_|  _|_|
;;  _|_|_|_|    _|_|    _|  _|  _|
;;  _|    _|        _|  _|      _|
;;  _|    _|  _|_|_|    _|      _|
;; 
;; The basics of the Linux x64 calling convention:
;;
;;     - Arguments are passed in `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`, in 
;;       that order and any additional arguments are passed on the stack.
;;     - The return value is stored in `rax`.
;;
;; You can reference the System V ABI manual for more details.
;; The Intel Manual, Volume 2 has detailed information about how each
;; instruction behaves.
;;
;; Good luck! Have fun!
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



; int studentFunction1(unsigned long long range, unsigned long long velocity);
;
; @brief    Function calculates and returns the appropriate angle to set a 
;           cannon to given `range` to the target and `velocity` of the 
;           cannonball. Gravitational acceleration is set to 10 meters per 
;           second per second.
;
;           Calculation uses the equation 
;
; @param    range       Range to intended target in meters.
; @param    velocity    Velocity of cannonball in meters per second.
; @return   int         Returns the angle needed to hit the target.
;
; TODO: Implement this function.
; RULE: Do NOT use macros, assignments or directives.
; RULE: Do not use memory.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
; RULE: Do NOT use jumps or loops.
; INFO: A `sqrt` function has been provided for you. The `sqrt` function does 
;       not clobber any registers except for `rax`. You place the number you 
;       want square-rooted in `edi` and the result will be in `eax`.
; ASSUME:   time > 0.
; ASSUME:   sqrt(x) = rounded to nearest integer.
; ASSUME:   x // y = floor(x / y) (rounded towards 0).
; ASSUME:   Your return value should be positive.
; HINT: Because you are using integer division, you lose information every 
;       time you divide, therefore you want to divide as few times as 
;       possible in order to maintain accuracy.
; HINT: You also want to avoid division-by-zero errors. Because 
;       integer division of a numerator smaller than a denominator is 0, you 
;       want to avoid dividing by that quotient. I.e., if a < b, then a // b 
;       = 0. So, you can use algebra to help with multiple levels of division. 
;       If a = b // (c // d), then a = d * b // c. This method turns two 
;       divisions into one and avoids a division-by-zero error if c is not 
;       equal to 0.
;
studentFunction1:

    ; -- Add your solution below this line -------------------------------------

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


    ; -- Do not edit below this line -------------------------------------------
    ret

; End studentFunction1.



; ************************* DO NOT EDIT THIS FUNCTION. *************************
;
; int sqrt(int a)
;
; @brief    Function finds the integer square root of `a`.
;
; @param    a       The number to be rooted.
; @return   int     Returns the square-root of `a` as an integer rounded to  
;                   nearest integer.
;
; To use this function, simply move `a` into `edi` (`mov edi, a`) and 
; `call sqrt`.
;
sqrt:
    push rbp
    mov rbp, rsp

    push rdx            ; Save rdx.
    xor rax, rax        ; Clear rax and rdx.
    xor rdx, rdx
    mov eax, edi

    cdq                 ; Find abs(a).
    xor eax, edx
    sub eax, edx

    inc eax             ; Find sqrt(abs(a)).
    shr eax, 1
    mov edx, -1
    
    .loop:
        inc edx
        sub eax, edx
        ja .loop

    mov eax, edx
    pop rdx

    .end:
        leave
        ret

; End sqrt.


; ********************************* NOT USED **********************************
studentFunction2: ret
studentFunction3: ret
studentFunction4: ret
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



section .data

    a       dq  0
    b       dq  1.0
    degrees dq  180.0
    pi      dq  3.141592654
    result  dq  0



; End of file.