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
extern WriteConsoleW
extern ExitProcess

section .bss
    written resd 1  ; Reserve space for one 32-bit integer

section .data
    aHello db "Hello, World (ANSI)", 0
    ahello_length equ $-aHello ; Length of hello string

    uHello dw "Hello, World (Unicode)", 0, 0
    uhello_length equ ($-uHello)/2 ; Length of Unicode hello string (divide by 2 to get the character count)

    STD_OUTPUT_HANDLE equ -11  ; -11 is the value for STD_OUTPUT_HANDLE

    USE_UNICODE equ 0

section .text
    global main

Exit:
    ; Exit the process
    xor ecx, ecx  ; exit code 0
    call ExitProcess

    add rsp, 28h  ; Clean up shadow space


main:
    sub rsp, 28h  ; Allocate shadow space for Windows x64 calling convention

    ; Call GetStdHandle(STD_OUTPUT_HANDLE)
    mov ecx, STD_OUTPUT_HANDLE   ; nStdHandle
    call GetStdHandle

    mov ecx, USE_UNICODE

    cmp ecx, 0
    jz Unicode  ; If USE_UNICODE is zero, jump to Unicode section
    jmp ANSI   ; Otherwise, jump to ANSI section

    jmp Exit

ANSI:
    ; Preparing the values for WriteConsoleA
    mov rcx, rax           ; hConsoleOutput (returned by GetStdHandle)
    lea rdx, [rel aHello]   ; lpBuffer
    mov r8d, ahello_length  ; nNumberOfCharsToWrite
    lea r9, [rel written]  ; lpNumberOfCharsWritten (address of written)
    mov qword [rsp], 0     ; lpReserved (NULL)
    call WriteConsoleA
    
    jmp Exit

Unicode:
    ; Preparing the values for WriteConsoleW
    mov rcx, rax           ; hConsoleOutput (returned by GetStdHandle)
    lea rdx, [rel uHello]   ; lpBuffer
    mov r8d, uhello_length  ; nNumberOfCharsToWrite
    lea r9, [rel written]  ; lpNumberOfCharsWritten (address of written)
    mov qword [rsp], 0     ; lpReserved (NULL)
    call WriteConsoleW

    jmp Exit

