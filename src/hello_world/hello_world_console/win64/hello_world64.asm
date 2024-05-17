; hello_world64.asm 64-bit
;
; Author: Steve M <livewirez@github.com>
; Date: 16/05/2024
;
; Assembled using Nasm (Netwide Assembler)
; Linked with The GCC (GNU Compiler Collection) or MSVC Linker
; Using Windows Console Api for Stdout https://learn.microsoft.com/en-us/windows/console/getstdhandle and https://learn.microsoft.com/en-us/windows/console/writeconsole


extern GetStdHandle
extern WriteConsoleA
extern ExitProcess

section .bss
    written resd 1  ; Reserve space for one 32-bit integer

section .data
    hello db "Hello, World", 0
    hello_length equ $-hello ; Length of hello string

    STD_OUTPUT_HANDLE equ -11  ; -11 is the value for STD_OUTPUT_HANDLE

section .text
    global main

main:
    sub rsp, 28h  ; Allocate shadow space for Windows x64 calling convention

    ; Call GetStdHandle(STD_OUTPUT_HANDLE)
    mov ecx, STD_OUTPUT_HANDLE   ; nStdHandle
    call GetStdHandle

    ; Preparing the values for WriteConsoleA
    mov rcx, rax           ; hConsoleOutput (returned by GetStdHandle)
    lea rdx, [rel hello]   ; lpBuffer
    mov r8d, hello_length  ; nNumberOfCharsToWrite
    lea r9, [rel written]  ; lpNumberOfCharsWritten (address of written)
    mov qword [rsp], 0     ; lpReserved (NULL)
    call WriteConsoleA

    ; Exit the process
    xor ecx, ecx  ; exit code 0
    call ExitProcess

    add rsp, 28h  ; Clean up shadow space
