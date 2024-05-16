# Hello World 32-bit Program
An assembly program for displaying a message using windows modal dialog box

## Info

Only on Windows

## Assembling

* Make sure you've installed [The Netwide Assembler](https://www.nasm.us)
* since we are using the linker provided by msvc (ptovided by Visual Studio 2022), we'll need to add to the environment, make sure we can run vcvars32.bat , if not add it to your environment path

* Now on to assembling:

```bash
nasm -fwin32 hello_world.asm
```

```bash
vcvars32
```

```bash
link /entry:main /subsystem:windows hello_world.obj /LIBPATH:"{location of 32-bit user32.lib}" /LIBPATH:"{location of 32-bit kernel32.lib}" user32.lib kernel32.lib
```

```bash
link /entry:main /subsystem:windows hello_world.obj /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x86" /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x86" user32.lib kernel32.lib
```

* `/subsystem:windows` is optional

Run the program

```bash
./hello_world
```

# Should Display
![Image](/src/hello_world/hello_world_messagebox/win32/images/hello_world.JPG "Hello World")