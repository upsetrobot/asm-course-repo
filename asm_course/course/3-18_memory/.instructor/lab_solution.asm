
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-18 Memory - Lab Solution
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
;;   ░███░  ▒███▒  ██▓█▓                                         
;;   █▒ ▒█  █▒ ░█  █▒█▒█                                         
;;       █  █▒░    █ █ █                                         
;;   ▒████  ░███▒  █ █ █                                         
;;   █▒  █     ▒█  █ █ █                                         
;;   █░ ▓█  █░ ▒█  █ █ █                                         
;;   ▒██▒█  ▒███▒  █ █ █
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


section .data

    g_val       dd  15264253
    g_arr       dq  124523, 186654, 452588, 156467886784233, 1538180001, 
                dq  165448548648, 486445422, 4424148454645, 12345678
    g_arr_sz    equ ($ - g_arr) / 8
    g_str       db  "You take the blue pill - the story ends, you wake up in "
                db  "your bed and believe whatever you want to believe. You "
                db  "take the red pill - you stay in Wonderland, and I show "
                db  "you how deep the rabbit-hole goes.", 10, 0
    g_str_len   equ $ - g_str - 1



section .bss

    buffer: resb 256



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



; 1. Sum of Global.
;
; int studentFunction1(int a); 
;
; @brief    Function adds `a` and the global `g_val` and returns the sum.
;
; @param    a           The addend.
; @return   long long   Returns the sum of `a` and `g_val`.
;
; TODO: Implement this function.
;
studentFunction1:
    push rbp
    mov rbp, rsp

    ; --- Add your solution below this line -----------------------------------

    mov eax, [g_val]
    add eax, edi

    ; --- Do not edit below this line -----------------------------------------
    mov rsp, rbp
    pop rbp
    ret

; End studentFunction1.



; 2. Array Index.
; 
; long long studentFunction2(unsigned int index); 
;
; @brief    Function returns the value from the global array `g_arr` with the 
;           array size `g_arr_sz` at the specified index `index`. If the index
;           is out of bounds, function returns `-1`. 
;
;           Pseudocode: `return g_arr[index]`.
;
; @param    index       Index of element to return from array `g_arr`.
; @return   long long   Returns the element.
;
; TODO: Implement this function.
;
studentFunction2:
    push rbp
    mov rbp, rsp

    ; --- Add your solution below this line -----------------------------------

    cmp rdi, g_arr_sz
    jl .valid

    or rax, -1
    jmp .end

    .valid:
        mov rax, [g_arr + rdi*8]    

    .end:

    ; --- Do not edit below this line -----------------------------------------
    mov rsp, rbp
    pop rbp
    ret

; End studentFunction2.



; 3. Sum Array.
;
; long long studentFunction3()
;
; @brief    Function returns the sum of all elements in the global long long 
;           array `g_arr` which has `g_arr_sz` elements.
;
; @return   long long   Sum of `g_arr` elements.
;
; TODO: Implement this function.
;
studentFunction3:
    push rbp
    mov rbp, rsp

    ; --- Add your solution below this line -----------------------------------

    mov rdi, g_arr
    mov rcx, g_arr_sz
    xor rax, rax

    test rcx, rcx
    jz .end

    .loop:
        add rax, [rdi]
        add rdi, 8
        loop .loop

    .end:

    ; --- Do not edit below this line -----------------------------------------
    mov rsp, rbp
    pop rbp
    ret

; End studentFunction3.



; 4. Overwrite String.
; 
; char* studentFunction4()
;
; @brief    Function changes the contents of the global string `g_str` with 
;           length `g_str_len` to all 'e's and returns a pointer to the global
;           string.
;
;           Example: If string was "hello", string should become "eeeee".
;
; @return   char*   Pointer to global string `g_str`.
;
; TODO: Implement this function.
;
studentFunction4:
    push rbp
    mov rbp, rsp

    ; --- Add your solution below this line -----------------------------------

    mov rax, g_str
    mov rdi, rax
    mov rcx, g_str_len

    test rcx, rcx
    jz .end
    
    .loop:
        mov byte [rdi], 'e'
        inc rdi
        loop .loop

    .end:

    ; --- Do not edit below this line -----------------------------------------
    mov rsp, rbp
    pop rbp
    ret

; End studentFunction4.



; 5. Copy String to Buffer.
; 
; char* studentFunction5(char* str)
;
; @brief    Function copies string given by pointer `str` to a global buffer 
;           called `buffer` and returns to pointer to `buffer`. Assumes string 
;           given is less than buffer size (255 bytes) and that string is 
;           null-terminated. This function also null-terminates the buffer 
;           after copying the string.
;
; @param    str     String to copy into `buffer`.
; @return   char*   Pointer to global string `buffer`.
;
; TODO: Implement this function.
;
studentFunction5:
    push rbp
    mov rbp, rsp

    ; --- Add your solution below this line -----------------------------------

    mov rsi, buffer

    .while:
        cmp byte [rdi], 0
        je .endWhile

        mov al, [rdi]
        mov [rsi], al
        inc rdi
        inc rsi
        jmp .while

    .endWhile:
        mov byte [rsi], 0    
        mov rax, buffer

    ; --- Do not edit below this line -----------------------------------------
    mov rsp, rbp
    pop rbp
    ret

; End studentFunction5.



; ********************************* NOT USED **********************************
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
