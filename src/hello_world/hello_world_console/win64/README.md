# Hello World 64-bit Program
An assembly program for displaying a message using windows [GetStdHandle](https://learn.microsoft.com/en-us/windows/console/getstdhandle) that Retrieves a handle to the specified standard device (standard input, standard output, or standard error). and [WriteConsole](https://learn.microsoft.com/en-us/windows/console/writeconsole) that Writes a character string to a console screen buffer beginning at the current cursor location.

## Info

Only on Windows

Also note the 64 bit registers 

## Assembling

* Make sure you've installed [The Netwide Assembler](https://www.nasm.us)
* Make sure [GCC (GNU Compiler Collection is installed)](https://gcc.gnu.org) or msvc linker since we are using the linker provided by msvc (ptovided by Visual Studio 2022), we'll need to add to the environment, make sure we can run vcvars32.bat , if not add it to your environment path

* Now on to assembling:

```bash
nasm -fwin64 hello_world64.asm
```

## GCC
* We link with gcc 

```bash
gcc -o hello_world64.exe hello_world64.obj -L"{location of 64-bit kernel32.lib}" -lkernel32 --entry=main
```

```bash
gcc -o hello_world64.exe hello_world64.obj -L"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64" -lkernel32 --entry=main
```


## MSVC LINKER

```bash
vcvars64
```

```bash
link /entry:main /subsystem:console hello_world64.obj /LIBPATH:"{location of 64-bit kernel32.lib}" kernel32.lib
```

```bash
link /entry:main /subsystem:console hello_world64.obj /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64" kernel32.lib
```

Run the program

```bash
./hello_world64
```

# Should Display
![Image](/src/hello_world/hello_world_console/win64/images/hello_world_console.JPG "Hello World")