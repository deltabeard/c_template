# Deprecation Notice

I am no longer supporting this template because I now recommend using cmake when
building projects for Windows NT. This keeps Makefiles simple and easy to
understand, whilst an additional Cmakelists.txt file can be used to support a
wide variety of operating systems that do not support GNU Make's default rules.

# c_template

A C project template with some good pre-configured default settings. Only
requires GNU Make.

When starting a new project:
* Place your .c source files in the src folder, and your .h header files in the
  inc folder.
* Edit the variables at the top of the Makefile file, such as NAME, DESCRIPTION,
  etc.
* Replace the meta/icon.ico file with your own application icon.
* If you would like to support 32-bit Windows XP platform, edit Makefile and
  follow the guide written within. Windows XP support for Visual Studio must be
  installed.
* Replace this README.md file with your own, explaining your project and how to
  build.

To build on Unix-like platforms such as Linux, BSD, and macOS:
* Execute GNU Make in your shell with `make`

To build on Windows with Visual Studio Native Tools Command Prompt:
* Make sure you have `gnumake.exe` in your PATH.
* Execute GNU Make `gnumake` within the Native Tools for Command Prompt shell.

Limitations:
* Only one output target is supported.
* If external libraries are required, LDLIBS must be manually added to the
  Makefile.

## License

Copyright (c) 2020 Mahyar Koshkouei<br/>
Redistribution and use in source and binary forms, with or without modification, are permitted.<br/>
THIS SOFTWARE IS PROVIDED 'AS-IS', WITHOUT ANY EXPRESS OR IMPLIED WARRANTY. IN NO EVENT WILL THE AUTHORS BE HELD LIABLE FOR ANY DAMAGES ARISING FROM THE USE OF THIS SOFTWARE. 
