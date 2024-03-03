
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-24 Competency 6 Its About Time - Competency Lab
;;
;; This file is module specific and houses assembly application labs for 
;; students. Students should edit this file and run `make` to test their 
;; solutions.
;;
;; @file        4_lab.asm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        17 Feb 2024
;; @copyright   Copyright (c) 2024
;;
;; Student TODO:    Complete the lab assignment below.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    █████\  ███████ /███   /███
;;   ██\  ██\ ██::::/ /████ /████
;;   ███████\ ███████ /██ ████/██
;;   ██\  ██\ \::::██ /██ /██ /██
;;   ██\  ██\ ███████ /██     /██
;;   \\\  \\\ \:::::/ ///     ///
;;    \\\  \\\ \\|// ///     /// 
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


%define     SYS_READ    0
%define     SYS_WRITE   1
%define     SYS_TIME    201

%define     STDIN       0
%define     STDOUT      1

%define     BUFSZ       255



section .bss

    buf:    resb    BUFSZ

    ; --- Use for global uninitialized variables if you want below this line --

    

    ; End .bss section.



section .data

    time        db  "TIME: "
    time_len    equ $ - time

    colon       db  ":"
    colon_len   equ $ - colon

    newline     db  10
    newline_len equ $ - newline

    hours       db  "Enter hours: "
    hours_len   equ $ - hours

    mins        db  "Enter minutes: "
    mins_len    equ $ - mins

    error       db  "Error: Invalid Input", 10
    error_len   equ $ - error

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


; 1. Competency 6 Its About Time.
;
; unsigned int studentFunction1();
;
; @brief    This function gets the time using the `time` syscall (which returns
;           the time in seconds in UTC time since January 1, 1970). Then the 
;           time is converted to time in EST zone hours and minutes. The time 
;           is printed in hh:mm format. Then the user is prompted for hours 
;           to add in form of one or two digits. Then the user is prompted for 
;           minutes to add in the form of one or two digits. The hours are 
;           added to the current hours, and the minutes are added to the 
;           current minutes. Then the new time is printed. Finally, the 
;           function returns the current time value of hours and minutes in 
;           the number of seconds. 
;
;           The number of EST hours is calculated using the following 
;           equation:
;               `h = (s // 60 // 60 % 24) - 5
;               if h > 0: h = h % 12
;               else: h = (h + 24) % 12`.
;
;           The number of minutes is calculated using the following equation:
;               `m = s // 60 % 60`.
;
;           After the time is set, the minutes are added using this equation:
;               `new_m` = (m + user_m) % 60`.
;
;           And the new hours are added using this equation:
;               `new_h = (h + user_h + (m + user_m) // 60) % 12`.
;
;           The return value is calculated using the following equation:
;               `return new_h*3600 + new_m*60`.
;
;           Full Python code example can be found in the `1_competency.md` 
;           file.
;
; @return   unsigned int    Returns the new time in EST in the number of
;                           seconds from the number of hours and minutes. 
;
; TODO: Implement this function.
; RULE: Do NOT use external libraries.
;
; *********************** !!! TESTING INSTRUCTIONS !!! ************************
;       For Testing with `make`, enter `0` for first input and `0` for second.
;       Enter `1` for first input and `1` for second.
;       Enter `25` for first input and `61` for second.
;       Enter `33` for first input and `33` for second.
;       This has to be done before the system time minute changes, so if you 
;       fail, try testing again!
;
studentFunction1:
    


; End studentFunction1.




; --- Do not edit below this line ---------------------------------------------
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
