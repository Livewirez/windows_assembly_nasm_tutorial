; hello_world_notification.asm 64-bit
;
; Author: Steve M <livewirez@github.com>
; Date: 16/05/2024
;
; Assembled using Nasm (Netwide Assembler)
; Linked with The GCC (GNU Compiler Collection)
; Using MessageBox from windows api to display string https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messageboxa 
; and custom static library to call shell notification


extern MessageBoxA
extern ExitProcess
;extern show_desktop_notification_
extern show_desktop_notification_prog_name

section .data:
    hello:
        db "Hello, World", 0

    dialog_box_title:
        db "Hello World", 0

section .text:
    global main

main:
    sub rsp, 28h ; Allocate shadow space for Windows x64 calling convention
    
    mov rcx, 0   ; hWnd
    ;mov rdx, 0   ; lpText
    lea rdx, [rel hello] ; lpText
    lea r8, [rel dialog_box_title] ; lpCaption
    mov r9d, 0   ; uType
    call MessageBoxA

    ;lea rcx, [rel hello] ; First argument for show_desktop_notification_
    ;call show_desktop_notification_

    lea rcx, [rel dialog_box_title] ; First argument for show_desktop_notification_prog_name
    lea rdx, [rel hello] ; Second argument for show_desktop_notification_prog_name
    call show_desktop_notification_prog_name

    ;mov ecx, 0
    xor ecx, ecx  ; exit code 0
    call ExitProcess

    add rsp, 28h ; Clean up shadow space





