
# 📁 3-25 File Handling - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Files](#files)
- [File Handling System Calls](#file-handling-system-calls)
- [x64 Examples](#x64-examples)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Files

The system considers any input or output data as stream of bytes. There are
three standard file streams [[1]](#sources):

- Standard input (`stdin`) [[1]](#sources) 
- Standard output (`stdout`) [[1]](#sources)
- Standard error (`stderr`) [[1]](#sources)

A file descriptor is a 16-bit integer assigned to a file as a file id. When a
new file is created or an existing file is opened, the file descriptor is used
for accessing the file. File descriptors of the standard file streams `stdin`,
`stdout` and `stderr` are `0`, `1` and `2`, respectively [[1]](#sources).

A file pointer specifies the location for a subsequent read/write operation in
the file in terms of bytes. Each file is considered as a sequence of bytes.
Each open file is associated with a file pointer that specifies an offset in
bytes, relative to the beginning of the file. When a file is opened, the file
pointer is set to zero [[1]](#sources).


## File Handling System Calls

The following table briefly describes the system calls related to file handling
for 32-bit Linux [[1]](#sources):

| `%eax` | Name        | `%ebx`           | `%ecx`         | `%edx`         |
|--------|-------------|------------------|----------------|----------------|
| 2      | `sys_fork`  | `struct pt_regs` | -              | -              |
| 3      | `sys_read`  | `unsigned int`   | `char *`       | `size_t`       |
| 4      | `sys_write` | `unsigned int`   | `const char *` | `size_t`       |
| 5      | `sys_open`  | `const char *`   | `int`          | `int`          |
| 6      | `sys_close` | `unsigned int`   | -              | -              |
| 8      | `sys_creat` | `const char *`   | `int`          | -              |
| 19     | `sys_lseek` | `unsigned int`   | `off_t`        | `unsigned int` |
[[1]](#sources)

The steps required for using the system calls are same, as we discussed
earlier [[1]](#sources):

- Put the system call number in the `EAX` register [[1]](#sources).
- Store the arguments to the system call in the registers `EBX`, `ECX`, etc
[[1]](#sources).
- Call the relevant interrupt (`80h`) [[1]](#sources).
- The result is usually returned in the `EAX` register [[1]](#sources).


### Creating and Opening a File

For creating and opening a file, perform the following tasks [[1]](#sources):

1. Put the system call `sys_creat()` number 8, in the `EAX` register
[[1]](#sources).
2. Put the filename in the `EBX` register [[1]](#sources).
3. Put the file permissions in the `ECX` register [[1]](#sources).
4. The system call returns the file descriptor of the created file in the `EAX`
register, in case of error, the error code is in the `EAX` register
[[1]](#sources).


### Opening an Existing File

For opening an existing file, perform the following tasks [[1]](#sources):

1. Put the system call `sys_open()` number 5, in the `EAX` register
[[1]](#sources).
2. Put the filename in the `EBX` register [[1]](#sources).
3. Put the file access mode in the `ECX` register [[1]](#sources).
4. Put the file permissions in the `EDX` register [[1]](#sources).
5. The system call returns the file descriptor of the created file in the `EAX`
register, in case of error, the error code is in the `EAX` register
[[1]](#sources).

Among the file access modes, most commonly used are: `read-only (0)`,
`write-only (1)`, and `read-write (2)` [[1]](#sources).


### Reading from a File

For reading from a file, perform the following tasks [[1]](#sources):

1. Put the system call `sys_read()` number 3, in the `EAX` register
[[1]](#sources).
2. Put the file descriptor in the `EBX` register [[1]](#sources).
3. Put the pointer to the input buffer in the `ECX` register [[1]](#sources).
4. Put the buffer size, i.e., the number of bytes to read, in the `EDX`
register [[1]](#sources).
5. The system call returns the number of bytes read in the `EAX` register, in
case of error, the error code is in the `EAX` register [[1]](#sources).


### Writing to a File

For writing to a file, perform the following tasks [[1]](#sources):

1. Put the system call `sys_write()` number 4, in the `EAX` register
[[1]](#sources).
2. Put the file descriptor in the `EBX` register [[1]](#sources).
3. Put the pointer to the output buffer in the `ECX` register [[1]](#sources).
4. Put the buffer size, i.e., the number of bytes to write, in the `EDX`
register [[1]](#sources).
5. The system call returns the actual number of bytes written in the `EAX`
register, in case of error, the error code is in the `EAX` register
[[1]](#sources).


### Closing a File

For closing a file, perform the following tasks [[1]](#sources):

1. Put the system call `sys_close()` number 6, in the `EAX` register
[[1]](#sources).
2. Put the file descriptor in the `EBX` register [[1]](#sources).
3. The system call returns, in case of error, the error code in the `EAX`
register [[1]](#sources).


### Updating a File

For updating a file, perform the following tasks [[1]](#sources):

1. Put the system call `sys_lseek()` number 19, in the `EAX` register
[[1]](#sources).
2. Put the file descriptor in the `EBX` register [[1]](#sources).
3. Put the offset value in the `ECX` register [[1]](#sources).
4. Put the reference position for the offset in the `EDX` register. The
reference position could be [[1]](#sources):
    - Beginning of file - value 0 [[1]](#sources)
    - Current position - value 1 [[1]](#sources)
    - End of file - value 2 [[1]](#sources)
5. The system call returns, in case of error, the error code in the `EAX`
register [[1]](#sources).

The following program creates and opens a file named `myfile.txt`, and writes a
text 'Welcome to Tutorials Point' in this file. Next, the program reads from
the file and stores the data into a buffer named info. Lastly, it displays the
text as stored in info [[1]](#sources):

``` x86asm
section	.text
   global _start         ;must be declared for using gcc
	
_start:                  ;tell linker entry point
   ;create the file
   mov  eax, 8
   mov  ebx, file_name
   mov  ecx, 0777        ;read, write and execute by all
   int  0x80             ;call kernel
	
   mov [fd_out], eax
    
   ; write into the file
   mov	edx,len          ;number of bytes
   mov	ecx, msg         ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
	
   ; close the file
   mov eax, 6
   mov ebx, [fd_out]
    
   ; write the message indicating end of file write
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_done
   mov edx, len_done
   int  0x80
    
   ;open the file for reading
   mov eax, 5
   mov ebx, file_name
   mov ecx, 0             ;for read only access
   mov edx, 0777          ;read, write and execute by all
   int  0x80
	
   mov  [fd_in], eax
    
   ;read from file
   mov eax, 3
   mov ebx, [fd_in]
   mov ecx, info
   mov edx, 26
   int 0x80
    
   ; close the file
   mov eax, 6
   mov ebx, [fd_in]
   int  0x80    
	
   ; print the info 
   mov eax, 4
   mov ebx, 1
   mov ecx, info
   mov edx, 26
   int 0x80
       
   mov	eax,1             ;system call number (sys_exit)
   int	0x80              ;call kernel

section	.data
file_name db 'myfile.txt'
msg db 'Welcome to Tutorials Point'
len equ  $-msg

msg_done db 'Written to file', 0xa
len_done equ $-msg_done

section .bss
fd_out resb 1
fd_in  resb 1
info resb  26
```
[[1]](#sources) 

When the above code is compiled and executed, it produces the following result
[[1]](#sources): 

```
Written to file
Welcome to Tutorials Point
```
[[1]](#sources)


## x64 Examples

Syscalls and arguments will be different for differents systems such as 
Windows and x64 Linux or Unix-like OS'. Here is an example of the functions 
used above in an x64 Linux program.

``` x86asm
%define SYS_READ    0
%define SYS_WRITE   1
%define SYS_OPEN    2
%define SYS_CLOSE   3
%define SYS_CREAT   85

%define O_ACCMODE   0o00000003
%define O_RDONLY    0o00000000
%define O_WRONLY    0o00000001
%define O_RDWR      0o00000002
%define O_CREAT     0o00000100
%define O_EXCL	    0o00000200
%define O_NOCTTY    0o00000400
%define O_TRUNC	    0o00001000
%define O_APPEND    0o00002000
%define O_NONBLOCK  0o00004000
%define O_SYNC	    0o04010000
%define O_LARGEFILE 0o00100000
%define O_DIRECTORY 0o00200000
%define O_NOFOLLOW  0o00400000
%define O_CLOEXEC   0o02000000
%define O_DIRECT    0o00040000
%define O_NOATIME   0o01000000
%define O_PATH      0o10000000
%define O_DSYNC	    0o00010000
%define O_TMPFILE   0o20200000

%define S_IRWXU     0o00700  ; user (file owner) has read, write, and execute permission
%define S_IRUSR     0o00400  ; user has read permission
%define S_IWUSR     0o00200  ; user has write permission
%define S_IXUSR     0o00100  ; user has execute permission
%define S_IRWXG     0o00070  ; group has read, write, and execute permission
%define S_IRGRP     0o00040  ; group has read permission
%define S_IWGRP     0o00020  ; group has write permission
%define S_IXGRP     0o00010  ; group has execute permission
%define S_IRWXO     0o00007  ; others have read, write, and execute permission
%define S_IROTH     0o00004  ; others have read permission
%define S_IWOTH     0o00002  ; others have write permission
%define S_IXOTH     0o00001  ; others have execute permission

%define STDIN       0
%define STDOUT      1
%define STDERR      2

%define NEWLINE     10
%define NULL        0

%define EXIT_SUCCESS    0
%define EXIT_FAILURE    -1

%define BUFSZ       256


section .data

    filename        db  "myfile.txt", NULL
    filename_len    equ $ - filename

    msg             db  "I want to write this into my file.", NEWLINE, NULL
    msg_len         equ $ - msg

    msg_2           db  "We overwrote the file!", NEWLINE, NULL
    msg_2_len       equ $ - msg_2

    msg_buffer      db  "Here is your file: ", NULL
    msg_buffer_len  equ $ - msg_buffer


section .bss

    buffer:     resb    BUFSZ


section .text

global main                   ; Needed for gcc.
extern perror                 ; Using this libc function to print errors.

    main:                     ; Used if you are compiling with gcc.
        enter 0, 0            ; Stack frame with no locals.

        .createNewFile:
            ; Create a new file.
            ; int creat(const char *pathname, mode_t mode);
            mov rax, SYS_CREAT
            mov rdi, filename
            mov rsi, S_IRUSR
            or  rsi, S_IWUSR
            or  rsi, S_IRGRP
            or  rsi, S_IWGRP
            or  rsi, S_IROTH
            syscall

            test rax, rax
            js .err

            mov r12, rax            ; myfile.txt fd.

            ; Write to the file.
            ; ssize_t write(int fd, const void *buf, size_t count);
            mov rax, SYS_WRITE
            mov rdi, r12
            mov rsi, msg
            mov rdx, msg_len
            syscall

            test rax, rax
            js .errClose

            ; Close file.
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

            test rax, rax
            js .err

        .openFile:
            ; Open file.
            ; int open(const char *pathname, int flags);
            ; int open(const char *pathname, int flags, mode_t mode);
            mov rax, SYS_OPEN
            mov rdi, filename
            mov rsi, O_RDONLY
            syscall

            test rax, rax
            js .errClose

            mov r12, rax

            ; Read file.
            ; ssize_t read(int fd, void *buf, size_t count);
            mov rax, SYS_READ
            mov rdi, r12
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall

            test rax, rax
            js .errClose

            ; Close file.
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

            test rax, rax
            js .err

            ; Print buffer.
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, msg_buffer
            mov rdx, msg_buffer_len
            syscall

            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall

            ; Lets clear our buffer.
            mov rcx, BUFSZ
            mov al, NULL
            mov rdi, buffer
            cld
            rep stosb

        .editFile:
            ; Overwrite beginning of file.
            ; Open file.
            mov rax, SYS_OPEN
            mov rdi, filename
            mov rsi, O_WRONLY
            syscall

            test rax, rax
            js .errClose

            mov r12, rax

            mov rax, SYS_WRITE
            mov rdi, r12
            mov rsi, msg_2
            mov rdx, msg_2_len
            syscall

            test rax, rax
            js .errClose

            ; Close file.
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

            test rax, rax
            js .err

            ; Open file.
            mov rax, SYS_OPEN
            mov rdi, filename
            mov rsi, O_RDONLY
            syscall

            test rax, rax
            js .errClose

            mov r12, rax

            ; Read file.
            mov rax, SYS_READ
            mov rdi, r12
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall

            test rax, rax
            js .errClose

            ; Close file.
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

            test rax, rax
            js .err

            ; Print buffer.
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, msg_buffer
            mov rdx, msg_buffer_len
            syscall

            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall
            
            ; Lets clear our buffer.
            mov rcx, BUFSZ
            mov al, NULL
            mov rdi, buffer
            cld
            rep stosb

        .overwriteFile:
            ; Overwrite file. This can be done with SYS_CREAT or SYS_OPEN with 
            ; O_TRUNC flag.
            ; Open file.
            mov rax, SYS_OPEN
            mov rdi, filename
            mov rsi, O_WRONLY
            or  rsi, O_TRUNC
            syscall

            test rax, rax
            js .errClose

            mov r12, rax

            mov rax, SYS_WRITE
            mov rdi, r12
            mov rsi, msg_2
            mov rdx, msg_2_len
            syscall

            test rax, rax
            js .errClose

            ; Close file.
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

            test rax, rax
            js .err

            ; Open file.
            mov rax, SYS_OPEN
            mov rdi, filename
            mov rsi, O_RDONLY
            xor rdx, rdx
            syscall

            test rax, rax
            js .errClose

            mov r12, rax

            ; Read file.
            mov rax, SYS_READ
            mov rdi, r12
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall

            test rax, rax
            js .errClose

            ; Close file.
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

            test rax, rax
            js .err

            ; Print buffer.
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, msg_buffer
            mov rdx, msg_buffer_len
            syscall

            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall

            ; Lets clear our buffer.
            mov rcx, BUFSZ
            mov al, NULL
            mov rdi, buffer
            cld
            rep stosb

        .appendFile:
            ; Open file.
            mov rax, SYS_OPEN
            mov rdi, filename
            mov rsi, O_RDWR
            or  rsi, O_APPEND
            xor rdx, rdx
            syscall

            test rax, rax
            js .errClose

            mov r12, rax

            ; Append to file.
            mov rax, SYS_WRITE
            mov rdi, r12
            mov rsi, msg
            mov rdx, msg_len
            syscall

            test rax, rax
            js .err

            ; Close file.
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

            test rax, rax
            js .err

            ; Open file.
            mov rax, SYS_OPEN
            mov rdi, filename
            mov rsi, O_RDONLY
            xor rdx, rdx
            syscall

            test rax, rax
            js .errClose

            mov r12, rax

            ; Read file.
            mov rax, SYS_READ
            mov rdi, r12
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall

            test rax, rax
            js .errClose

            ; Close file.
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

            test rax, rax
            js .err

            ; Print buffer.
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, msg_buffer
            mov rdx, msg_buffer_len
            syscall

            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall

        .success:
            xor rax, rax
            jmp .end

        .errClose:
            mov rax, SYS_CLOSE
            mov rdi, r12
            syscall

        .err:
            call perror
            or rax, -1

        .end:
            leave
            ret

    ; End main.
```

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
This program can be compiled with `nasm -f elf64 <filename>.<suffix>` followed 
by `gcc -no-pie <filename>.o -o <filename>`.
</span></span>

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
If you want to move your file pointer around, you can use functions like 
`lseek`. This allows you to move your file pointer with the file open.
</span></span>

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
The syscall numbers were found using `cat 
/usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep <syscall_name>`.
</span></span>

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
Using the man pages, you can see the include files used for C programming 
(like `unistd.h` and `fcntl.h`). Then, if you look at these files, you can get 
all the flag or constant definitions used in the man pages. Or you can write 
in a C IDE (like VS Code) a C program that uses them and then right-click on
one and "Go to Definition" (some IDEs may have slightly different verbage),
which will take you to the definitions of constants that you can use for your
asm code. That is how all the file permissions and mode flags were made in the
program above.  
</span></span>


## Sources

1. *Assembly - File Management*. 
https://www.tutorialspoint.com/assembly_programming/assembly_file_management.htm.


## Required Additional Readings

None.


## Resources

None.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
