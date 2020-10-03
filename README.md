# c_template

A C project template with some good pre-configured default settings. Only requires GNU Make.

When starting a new project:
* Place your .c source files in the src folder, and your .h header files in the inc folder.
* Edit the variables at the top of the Makefile file, such as NAME, DESCRIPTION, etc.
* Replace the meta/icon.ico file with your own application icon.
* If you would like to support 32-bit Windows XP platform, edit build_win.bat and follow the guide written within. Windows XP support for Visual Studio must be installed.

To build on Unix-like systems:
* Execute GNU Make in your shell with `make`

To build on Windows with Native Tools Command Prompt for VS2019:
* Make sure you have `gnumake.exe` in your PATH.
* Execute `build_win.bat`. This batch file produces the variables required for a successful build on Windows NT platforms, and then passes them to GNU Make.

# License

Copyright (c) 2020 Mahyar Koshkouei
Redistribution and use in source and binary forms, with or without modification, are permitted.
THIS SOFTWARE IS PROVIDED 'AS-IS', WITHOUT ANY EXPRESS OR IMPLIED WARRANTY. IN NO EVENT WILL THE AUTHORS BE HELD LIABLE FOR ANY DAMAGES ARISING FROM THE USE OF THIS SOFTWARE. 
