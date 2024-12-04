
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-08 Competency 1 Speed - Competency Lab
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
;;     ##    ####  #    # 
;;    #  #  #      ##  ## 
;;   #    #  ####  # ## # 
;;   ######      # #    # 
;;   #    # #    # #    # 
;;   #    #  ####  #    # 
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



; 1. Calculate Average Speed Using Points and Time.
; 
; int studentFunction1(int x1, int y1, int x2, int y2, unsigned int time);
;
; @brief    (`x1`, `y1`) and (`x2`, `y2`) are coordinates in a 2-dimensional 
;           plane in miles. `time` is in minutes and is the target time one 
;           is to travel from point (`x1`, `y1`) to point (`x2`, `y2`). Assume  
;           `time` is positive. Function returns the minimum speed in miles 
;           per hour (rounded UP to nearest integer) that one must travel at 
;           to travel the distance in time.
;
;           `sqrt((y2 - y1)^2 + (x2 - x1)^2) // (t // 60)`.
;
;           You can think of it like this:
;
;           `floor(sqrt((y2 - y1)^2 + (x2 - x1)^2) / (t / 60)) + 1`.
;
; @param    x1      The x-coordinate of point 1.
; @param    y1      The y-coordinate of point 1.
; @param    x2      The x-coordinate of point 2.
; @param    y2      The y-coordinate of point 2.
; @param    time    The time to travel between the two points in minutes. 
; @return   int     Returns the minumum speed in miles per hour that one must 
;                   travel to get from point 1 to point 2 in `time` minutes.
;
; TODO: Implement this function.
; RULE: Do NOT use macros, assignments or directives.
; RULE: Do not use memory.
; RULE: Only use the following operations: 
;           `mov`, `add`, `sub`, `int3`, `inc`, `dec`, `mul`, `imul`, `div`,
;           `idiv`, `lea`, `xchg`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
; RULE: Do NOT use jumps or loops.
; INFO: A `sqrt` function has been provided for you. The `sqrt` function does 
;       not clobber any registers except for `rax`. You place the number you 
;       want square-rooted in `edi` and the result will be in `eax`.
; ASSUME:   time > 0.
; ASSUME:   sqrt(x) = rounded to nearest integer.
; ASSUME:   x // y = floor(x / y) (rounded towards 0).
; ASSUME:   Your return value should be positive regardless of point positions.
; ASSUME:   Your return value should be ceiling(result) (result + 1).
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

    ; --- Add your solution below this line -----------------------------------

   

    ; --- Do not edit below this line -----------------------------------------
    ret

; End studentFunction1.



; ************************* DO NOT EDIT THIS FUNCTION. *************************
;
; int sqrt(int a);
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



; End of file.
