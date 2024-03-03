
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-22 Competency 5 Locked Up - Lab Solution
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
;;    █████╗ ███████╗███╗   ███╗
;;   ██╔══██╗██╔════╝████╗ ████║
;;   ███████║███████╗██╔████╔██║
;;   ██╔══██║╚════██║██║╚██╔╝██║
;;   ██║  ██║███████║██║ ╚═╝ ██║
;;   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ 
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


%define ARR_LEN     12



section .bss

    arr:    resb    ARR_LEN

    ; --- Use for global uninitialized variables if you want below this line --



    ; End .bss section.



section .data

    combo_1     db  "Combo 1: %d, %d, %d, %d", 10, 0
    combo_2     db  "Combo 2: %d, %d, %d, %d", 10, 0
    combo_3     db  "Combo 3: %d, %d, %d, %d", 10, 0

    ; --- Use for global initialized variables if you want below this line ----



    ; End .data section.



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



; You have to implement studentFunction1, but you can make as many additional
; local functions as desired.
; --- Add your solution below this line ---------------------------------------


; 1. Competency 5 Locked Up.
;
; char* studentFunction1(
;   unsigned int volume_1,
;   unsigned int volume_2, 
;   unsigned int volume_3, 
;   unsigned int tension_1,
;   unsigned int tension_2,
;   unsigned int tension_3
; );
;
; @brief    Function returns a pointer to a `char` array global called `arr`.
;           Function takes values for the volume constant and the tension 
;           constant for three dials of the vault and calculates the 
;           combinations to each of the three locks and returns a pointer to 
;           the array with the first four elements as the combination to the 
;           first lock in order, then the second for four elements as the 
;           combination to the second lock, and finally the last four elements 
;           as the combination to the last lock. 
;
;           Each lock's combination is derived using the following formula:
;               Find the minimum value for x for the range `0` to `64` in the 
;               equation: 
;                   `N = (x - (3*(volume_1 + prev_N) % 67))**2 
;                   + (x - (5*(tension_1 + prev_N) % 67))**2`.
;
;               Then, the value `x` is saved as the first number in the 
;               combination. Then, the value of calculated `N` is used in the 
;               subsequent calculation to find the next combination value by 
;               trying `x` for the range of `0` to `64`:
;                   `N_2 = (x - (3*(volume_1 + N) % 67))**2 
;                   + (x - (5*(tension_1 + N) % 67))**2`.
;
;               The formula must be done four consecutive times to get each 
;               combination number for the one lock.
;               
;               The second lock uses `volume_2` and `tension_2`, and the 
;               third lock uses `volume_3` and `tension_3`.
;
;           You can use the `printCombos` function if you want to print 
;           the array. To use this function, simply use `call printCombos`. 
;           This function follows standard calling conventions and always 
;           returns `0`.          
;
;
; @param    volume_1        Volume constant of dial 1 (integer between `1` and 
;                           `99`).
; @param    volume_2        Volume constant of dial 2 (integer between `1` and 
;                           `99`).
; @param    volume_3        Volume constant of dial 3 (integer between `1` and 
;                           `99`).
; @param    tension_1       Tension constant of dial 1 (integer between `1` and 
;                           `99`).
; @param    tension_2       Tension constant of dial 2 (integer between `1` and 
;                           `99`).
; @param    tension_3       Tension constant of dial 3 (integer between `1` and 
;                           `99`).
; @return   char*           Returns pointer to global array `arr` with 12 
;                           `char` values. The first four represent the four 
;                           combination values in order to the first lock; the 
;                           second four represent the values for the second 
;                           combination, and the last four represent the four 
;                           values for the last lock. 
;
; TODO: Implement this function.
; ASSUME: Input is correct even for invalid starting constants. In other words,
;         there is no requirement for error-checking parameters.
;
studentFunction1:
    enter 0, 0
    push r12
    push r13
    push r14
    push r15

    mov r12d, esi           ; volume_2.
    mov r13d, edx           ; volume_3.
    mov r14d, r8d           ; tension_2.
    mov r15d, r9d           ; tension_3

    ; Get first set of combos.
    mov rsi, rcx
    push rdi
    push rsi
    xor rdx, rdx
    xor rcx, rcx
    call getMinN

    mov rdi, [rsp + 8]
    mov rsi, [rsp]
    mov rdx, rax
    mov rcx, 1
    call getMinN

    mov rdi, [rsp + 8]
    mov rsi, [rsp]
    mov rdx, rax
    mov rcx, 2
    call getMinN

    pop rsi
    pop rdi
    mov rdx, rax
    mov rcx, 3
    call getMinN

    ; Get second set of combos.
    mov rdi, r12
    mov rsi, r14
    xor rdx, rdx
    mov rcx, 4
    call getMinN

    mov rdi, r12
    mov rsi, r14
    mov rdx, rax
    mov rcx, 5
    call getMinN

    mov rdi, r12
    mov rsi, r14
    mov rdx, rax
    mov rcx, 6
    call getMinN

    mov rdi, r12
    mov rsi, r14
    mov rdx, rax
    mov rcx, 7
    call getMinN

    ; Get second set of combos.
    mov rdi, r13
    mov rsi, r15
    xor rdx, rdx
    mov rcx, 8
    call getMinN

    mov rdi, r13
    mov rsi, r15
    mov rdx, rax
    mov rcx, 9
    call getMinN

    mov rdi, r13
    mov rsi, r15
    mov rdx, rax
    mov rcx, 10
    call getMinN

    mov rdi, r13
    mov rsi, r15
    mov rdx, rax
    mov rcx, 11
    call getMinN

    call printCombos

    mov rax, arr

    pop r15
    pop r14
    pop r13
    pop r12
    leave
    ret

; End studentFunction1.



; long long getN(v, t, n, pos, x);
;
getN:
    enter 0, 0
    push r12

    add rdi, rdx                ; v + n.
    add rsi, rdx                ; t + n.

    mov rax, rdi
    mov rcx, 3
    mul ecx                     ; rax = 3*(v + n).

    xor rdx, rdx
    mov rcx, 67
    div ecx                     ; rdx = 3*(v + n) % 67.

    mov rax, r8
    sub rax, rdx
    imul rax
    mov r12, rax                ; r12 = (x - (3*(v + n) % 67))**2.

    mov rax, rsi                ; t + n.
    mov rcx, 5
    mul ecx                     ; rax = 5*(t + n).

    xor rdx, rdx
    mov rcx, 67
    div ecx                     ; rdx = 5*(t + n) % 67.

    mov rax, r8
    sub rax, rdx
    imul rax                    ; rax = (x - (5*(t + n) % 67))**2.

    add rax, r12

    pop r12
    leave
    ret



; long long getMinN(v, t, n, pos);
; 
getMinN:
    enter 0, 0
    push r12
    push r13
    push r14
    mov r12, 9999
    mov r13, 65
    mov r14, rcx
    
    xor rcx, rcx

    .for:
        cmp rcx, 65             ; If `i` >= 65, exit loop.
        je  .endFor

        push rdi
        push rsi
        push rdx
        push rcx
        mov r8, rcx
        mov rcx, r14
        call getN

        pop rcx
        pop rdx
        pop rsi
        pop rdi
        cmp rax, r12            ; If `N` < `min_N`, replace `min_N` and `min_x`.
        jge .next

        mov r12, rax
        mov r13, rcx

        .next:
            inc rcx
            jmp .for

    .endFor:

    mov [arr + r14], r13b       ; Record combo in position `pos`.
    mov rax, r12                ; Return min `N`.

    pop r14
    pop r13
    pop r12
    leave 
    ret



; --- Do not edit below this line ---------------------------------------------

extern printf


; ************************ DO NOT EDIT THIS FUNCTION. *************************
;
; void printCharArray(char* arr, size_t arr_len);
;
; @brief    Function prints the given `char` array and returns `0`. 
;
;           *** If you have a SEGFAULT on `movaps` or some instruction in 
;           `printf`, then `push` a dummy value onto the stack before calling 
;           this function to align the stack. Then `pop` it after the call.
;
; @param    arr       The number to be rooted.
;
printCombos:
                enter   0, 0

    .print_1:   xor     rsi, rsi
                xor     rdx, rdx
                xor     rcx, rcx
                xor     r8,  r8
                mov     rdi, combo_1
                mov     sil, [arr]
                mov     dl,  [arr + 1]
                mov     cl,  [arr + 2]
                mov     r8b, [arr + 3]
                call    printf

    .print_2:   xor     rsi, rsi
                xor     rdx, rdx
                xor     rcx, rcx
                xor     r8,  r8
                mov     rdi, combo_2
                mov     sil, [arr + 4]
                mov     dl,  [arr + 5]
                mov     cl,  [arr + 6]
                mov     r8b, [arr + 7]
                call    printf

    .print_3:   xor     rsi, rsi
                xor     rdx, rdx
                xor     rcx, rcx
                xor     r8,  r8
                mov     rdi, combo_3
                mov     sil, [arr + 8]
                mov     dl,  [arr + 9]
                mov     cl,  [arr + 10]
                mov     r8b, [arr + 11]
                call    printf

    .end:       xor     rax,rax
                leave
                ret

; End printCharArray.



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
