; hello_world64.asm 64-bit
;
; Author: Steve M <livewirez@github.com>
; Date: 16/05/2024
;
; Assembled using Nasm (Netwide Assembler)
; Linked with Microsoft Linker from Visual Studio 2022
; Using MessageBox from windows api to display string https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messageboxa


global main
extern MessageBoxA
extern ExitProcess

section .text:

main:
    sub rsp, 28h ; Allocate shadow space for Windows x64 calling convention
    mov rcx, 0   ; hWnd
    ;mov rdx, 0   ; lpText
    lea rdx, [rel hello] ; lpCaption
    lea r8, [rel dialog_box_title] ; lpCaption
    mov r9d, 0   ; uType
    call MessageBoxA
    mov ecx, 0
    call ExitProcess
    add rsp, 28h ; Clean up shadow space

section .data:

hello:
    db "Hello, World", 0

dialog_box_title:
    db "Hello World", 0

