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
extern GetLastError
extern MessageBoxA
extern MessageBoxW
extern ExitProcess

%include "errors.asm"

section .bss
    written resd 1  ; Reserve space for one 32-bit integer

section .data
    hello db "Hello, World", 0
    hello_length equ $-hello ; Length of hello string

    STD_OUTPUT_HANDLE equ -11  ; -11 is the value for STD_OUTPUT_HANDLE


section .data

%define t(x) __?utf8?__(x) 
%define u(x) __?utf16?__(x) 
%define w(x) __?utf32?__(x) 

    HelloA db "Hello, World (ANSI)", 0
    helloa_length equ $-HelloA ; Length of hello string

    HelloW dw u('Hello, World (Unicode)'), 0 
    hellow_length equ ($-HelloW)/2 ; Length of Unicode hello string (divide by 2 to get the character count)

    STD_OUTPUT_HANDLE equ -11  ; -11 is the value for STD_OUTPUT_HANDLE

    USE_UNICODE equ 1


section .text
    global main

main:
    sub rsp, 28h  ; Allocate shadow space for Windows x64 calling convention

    ; Call GetStdHandle(STD_OUTPUT_HANDLE)
    mov ecx, STD_OUTPUT_HANDLE   ; nStdHandle
    call GetStdHandle
    cmp rax, 0                   ; Check if GetStdHandle failed
    je GetStdHandleError                 ; Jump to error handling if it failed

    mov ecx, USE_UNICODE

    cmp ecx, 0
    jz Unicode  ; If USE_UNICODE is zero, jump to Unicode section
    jmp ANSI   ; Otherwise, jump to ANSI section

    ; Exit the process
    xor ecx, ecx  ; exit code 0
    call ExitProcess

    add rsp, 28h  ; Clean up shadow space


Exit:
    ; Exit the process
    xor ecx, ecx  ; exit code 0
    call ExitProcess

    add rsp, 28h  ; Clean up shadow space


ANSI:
    ; Preparing the values for WriteConsoleA
    mov rcx, rax           ; hConsoleOutput (returned by GetStdHandle)
    lea rdx, [rel HelloA]   ; lpBuffer
    mov r8d, helloa_length  ; nNumberOfCharsToWrite
    lea r9, [rel written]  ; lpNumberOfCharsWritten (address of written)
    mov qword [rsp], 0     ; lpReserved (NULL)
    call WriteConsoleA

    ;mov rax, 0             ; Force WriteConsoleA to return 0 instead of non zero
    ;test rax, rax           ; Check if WriteConsoleA failed
    ;jz WriteConsoleError            ; Jump to error handling if it failed
    
    cmp rax, 0
    jz WriteConsoleError 

    jmp Exit

Unicode:
    ; Preparing the values for WriteConsoleW
    mov rcx, rax           ; hConsoleOutput (returned by GetStdHandle)
    lea rdx, [rel HelloW]   ; lpBuffer
    mov r8d, hellow_length  ; nNumberOfCharsToWrite
    lea r9, [rel written]  ; lpNumberOfCharsWritten (address of written)
    mov qword [rsp], 0     ; lpReserved (NULL)
    call WriteConsoleW

    ;mov rax, 0             ; Force WriteConsoleW to return 0 instead of non zero
    ;test rax, rax           ; Check if WriteConsoleW failed
    ;jz WriteConsoleError            ; Jump to error handling if it failed

    cmp rax, 0
    jz WriteConsoleError   
    jmp Exit



