extern GetLastError
extern MessageBoxA
extern ExitProcess

section .data
    dialog_box_title db "Hello World 64 Console", 0

    WriteConsoleAErrorMessage db "WriteConsoleAError::Could not print to console", 0

    GetStdHandleErrorErrorMessage db "GetStdHandleError::Error getting the standard input handle", 0

section .text

WriteConsoleError:
    ; Display error message using MessageBoxA
    mov rcx, 0   ; hWnd
    lea rdx, [rel WriteConsoleAErrorMessage] ; lpText
    lea r8, [rel dialog_box_title] ; lpCaption
    mov r9d, 0   ; uType
    call MessageBoxA

    ; Exit the process with error code from GetLastError
    xor ecx, ecx  ; exit code 0
    call GetLastError
    call ExitProcess


GetStdHandleError:
    ; Display error message using MessageBoxA

    ;----------------------------------------------------
    ;  64-bit Version
    ;----------------------------------------------------

    mov rcx, 0   ; hWnd
    lea rdx, [rel GetStdHandleErrorErrorMessage] ; lpText
    lea r8, [rel dialog_box_title] ; lpCaption
    mov r9d, 0   ; uType
    call MessageBoxA

    ; Exit the process with error code from GetLastError
    xor ecx, ecx  ; exit code 0
    call GetLastError
    call ExitProcess

