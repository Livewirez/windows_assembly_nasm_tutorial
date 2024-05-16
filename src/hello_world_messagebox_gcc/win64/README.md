# Hello World 64-bit Program
An assembly program for displaying a message using windows modal dialog box

## Info

Only on Windows

Also note the 64 bit registers instead of pushing to the stack like 32-bit

## Assembling

* Make sure you've installed [The Netwide Assembler](https://www.nasm.us)
* Make sure [GCC (GNU Compiler Collection is installed)](https://gcc.gnu.org) 

* Now on to assembling:

```bash
nasm -fwin64 hello_world64.asm
```

* We link with gcc 

```bash
gcc -o hello_world64.exe hello_world64.obj -L"{location of 64-bit user32.lib & kernel32.lib}" -luser32 -lkernel32 --entry=main
```

NOTE `user32.lib and kernel32.lib 64-bit versions are located in the same directory`

```bash
gcc -o hello_world64.exe hello_world64.obj -L"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64" -luser32 -lkernel32 --entry=main
```


Run the program

```bash
./hello_world
```

# Should Display
![Image](/src/hello_world_messagebox_gcc/win64/images/hello_world64gcc.JPG "Hello World")