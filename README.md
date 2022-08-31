# learning-assembly
These are examples taken from Learn to Program with Assembly by Jonathan Bartlett (2021).  I really like the book (ISBN-13: 978-1-4842-7436-1).  Bartlett's book is very current and nicely written.

The book assumes linux, and even provides a docker setup in case you don't have a linux box.  I didn't want to use a linux setup — prefering to use the 'built-in' tools that come with osx and the xcode tools.

Having had nothing but issues getting started on this, I thought I'd capture some tips here to help my fellow osx using assembler writing hopefuls.

## Pro-Tips
- There is no such thing as assembly.  There are assemblers.  Probably dozens of them for each Instruction Set Architecture (ISA).  Hard learn.  Aside from some very basic one off examples, I found nothing that used the built-in tools found on Monterey (12.5).  Everyone started with installing yasm, nasm, tasm, gas or equivalent plus gcc and gdb.
- The built-in assembler on Monterey is a variation of clang (llvm).  Which, as far as I can tell is the only binary used for as, ld, cc, and clang.  They all have the same inode on my machine.
- To assemble I used `as -g -o file.o file.s`
- To link I used `ld --static -o file file.s`.
- You don't have to statically link like I did.  You can use `ld hello.o -lSystem -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib` instead.
- The clang integrated assembler is meant to be compatible with the GNU Assembler, so look to those sources for guidance.
- System call numbers for linux and osx aren't the same.  So no stuffing 60 into %rax and expecting that to work.  Check my code samples for the way to do that on osx, if that is something you want to do.
- The start label on OSX is `start` rather than `_start`.
