# Hello World 32-bit Program
An assembly program for displaying a message using windows [GetStdHandle](https://learn.microsoft.com/en-us/windows/console/getstdhandle) that Retrieves a handle to the specified standard device (standard input, standard output, or standard error). and [WriteConsole](https://learn.microsoft.com/en-us/windows/console/writeconsole) that Writes a character string to a console screen buffer beginning at the current cursor location.

## Info

Only on Windows

Also note the 32 bit registers 

## Assembling

* Make sure you've installed [The Netwide Assembler](https://www.nasm.us)
* since we are using the linker provided by msvc (ptovided by Visual Studio 2022), we'll need to add to the environment, make sure we can run vcvars32.bat , if not add it to your environment path

* Now on to assembling:

```bash
nasm -fwin32 hello_world.asm
```

* setup the environment for mscv linker

```bash
vcvars32
```

* We link with msvc linker 

```bash
link /entry:main /subsystem:console hello_world.obj /LIBPATH:"{Directory path for 32-bit versions of user32.lib and kernel32.lib }" kernel32.lib user32.lib
```

NOTE `user32.lib and kernel32.lib 32-bit versions are located in the same directory`

```bash
link /entry:main /subsystem:console hello_world.obj /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x86" kernel32.lib user32.lib
```


Run the program

```bash
./hello_world
```

# Should Display
![Image](/src/hello_world/hello_world_console/win32/images/hello_world_console.JPG "Hello World")