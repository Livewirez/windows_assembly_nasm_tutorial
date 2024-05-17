# Hello World 64-bit Program
An assembly program for displaying a message using windows modal dialog box as well as displaying the shell notification from custom static library

`show_desktop_notification_prog_name` and `show_desktop_notification_` come from a custom static library called notification.lib which was compiled by GCC

## Info

Only on Windows

Also note the 64 bit registers instead of pushing to the stack like 32-bit

## External Functions

* `show_desktop_notification_prog_name`:

```c
void show_desktop_notification_prog_name(const char* program_name, const char* message);
```

* `MessageBoxA`:

```c
int MessageBoxA(
  [in, optional] HWND   hWnd,
  [in, optional] LPCSTR lpText,
  [in, optional] LPCSTR lpCaption,
  [in]           UINT   uType
);
```

* `ExitProcess`:

```c
void ExitProcess(
  [in] UINT uExitCode
);
```


## Assembling

* Make sure you've installed [The Netwide Assembler](https://www.nasm.us)
* Make sure [GCC (GNU Compiler Collection is installed)](https://gcc.gnu.org) 

### NOTE
* We cannot use the linker from msvc because of different compilers and will error out during linking due to undefined symbols like `snprintf` or `StringCbPrintfA` (still researching compatibiblity)

* Now on to assembling:

```bash
nasm -fwin64 hello_world64_notification.asm
```

* We link with gcc 

```bash
gcc -o hello_world64_notification.exe hello_world64_notification.obj -L"{location of 64-bit user32.lib & kernel32.lib}" -L"L{location of ucrt library}" -L"{Location of custom notification static library}" -luser32 -lkernel32 -lshell32 -lucrt -lnotification -lstrsafe --entry=main
```

NOTE `user32.lib and kernel32.lib 64-bit versions are located in the same directory`

```bash
gcc -o hello_world64_notification.exe hello_world64_notification.obj -L"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64" -L"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\ucrt\x64" -L"D:\Software\Lessons\Assembly\notification" -luser32 -lkernel32 -lshell32 -lucrt -lnotification -lstrsafe --entry=main
```


Run the program

```bash
./hello_world64_notification
```

# Should Display
![Image](/src/hello_world/hello_world_desktop_notification_gcc/win64/images/hello_world64_desktop_notification_gcc1.JPG "Hello World")

![Image](/src/hello_world/hello_world_desktop_notification_gcc/win64/images/hello_world64_desktop_notification_gcc2.JPG "Hello World Shell Notification")