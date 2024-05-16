; hello_world.asm 32-bit
;
; Author: Steve M <livewirez@github.com>
; Date: 16/05/2024
;
; Assembled using Nasm (Netwide Assembler)
; Linked with The MSVC Linker
; Using MessageBox from windows api to display string https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messageboxa


global _main
extern _MessageBoxA@16
extern _ExitProcess@4

section .text:

_main:
    push 0                  ; uType
    ;push 0                 ; lpCaption
    push dialog_box_title   ; lpCaption
    push hello              ; lpText
    push 0                  ; hWnd
    call _MessageBoxA@16
    mov ecx, 0
    call _ExitProcess@4


section .data:

hello:
    db "Hello, World", 0

dialog_box_title:
    db "Hello World", 0


