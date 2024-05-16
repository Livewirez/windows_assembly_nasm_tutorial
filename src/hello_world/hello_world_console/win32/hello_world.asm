; hello_world.asm 32-bit
;
; Author: Steve M <livewirez@github.com>
; Date: 16/05/2024
;
; Assembled using Nasm (Netwide Assembler)
; Linked with The MSVC Linker
; Using Windows Console Api for Stdout https://learn.microsoft.com/en-us/windows/console/getstdhandle and https://learn.microsoft.com/en-us/windows/console/writeconsole


extern _GetStdHandle@4
extern _WriteConsoleA@20
extern _ExitProcess@4

section .bss
    written resd 1  ; Reserve space for one 32-bit integer

section .data
    hello db "Hello, World", 0
    hello_length equ $-hello

    STD_OUTPUT_HANDLE equ -11  ; -11 is the value for STD_OUTPUT_HANDLE

section .text
    global _main

_main:
    ; Call GetStdHandle(STD_OUTPUT_HANDLE)
    push STD_OUTPUT_HANDLE   ; nStdHandle
    call _GetStdHandle@4
    add esp, 4               ; Clean up the stack

    ; Prepare the arguments for WriteConsoleA
    mov ebx, eax             ; Save handle returned by GetStdHandle

    push 0                   ; lpReserved (NULL)
    lea eax, [written]
    push eax                 ; lpNumberOfCharsWritten
    push hello_length        ; nNumberOfCharsToWrite
    lea eax, [hello]
    push eax                 ; lpBuffer
    push ebx                 ; hConsoleOutput (handle saved in ebx)
    call _WriteConsoleA@20
    add esp, 20              ; Clean up the stack

    ; Exit the process
    push 0                   ; exit code 0
    call _ExitProcess@4

    ; No need to clean up stack for ExitProcess as it does not return
