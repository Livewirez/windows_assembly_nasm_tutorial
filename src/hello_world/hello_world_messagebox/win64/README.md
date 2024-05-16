# Hello World 64-bit Program
An assembly program for displaying a message using windows modal dialog box

## Info

Only on Windows

Also note the 64 bit registers instead of pushing to the stack like 32-bit

## Assembling

* Make sure you've installed [The Netwide Assembler](https://www.nasm.us)
* since we are using the linker provided by msvc (ptovided by Visual Studio 2022), we'll need to add to the environment, make sure we can run vcvars64.bat , if not add it to your environment path

* Now on to assembling:

```bash
nasm -fwin64 hello_world64.asm
```

```bash
vcvars64
```

```bash
link /entry:main hello_world64.obj /LIBPATH:"{location of 64-bit user32.lib}" /LIBPATH:"{location of 64-bit kernel32.lib}" user32.lib kernel32.lib
```

```bash
link /entry:main hello_world64.obj /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64" /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64" user32.lib kernel32.lib
```

* `/subsystem:windows` is optional

Run the program

```bash
./hello_world
```

# Should Display
![Image](/src/hello_world/hello_world_messagebox/win64/images/hello_world64.JPG "Hello World")