# Package

version       = "0.1.0"
author        = "ttay"
description   = "cross compile"
license       = "MIT"
srcDir        = "src"
bin           = @["zig_cross_compile"]



# Dependencies

requires "nim >= 1.3.1"

# Tasks
task crossCompile, "Cross compile for Windows":
  switch("cc","zig")
  switch("zig.options.linker","-target x86_64-windows-gnu")
  switch("zig.options.always","-target x86_64-windows-gnu")
  setCommand "c"

task crossCompile2, "First one doesn't work somehow":
  selfExec "c -f --cc:zig --zig.options.linker:\"-target x86_64-windows-gnu\" --zig.options.always:\"-target x86_64-windows-gnu\" src/zig_cross_compile.nim"

task zigCompile, "compile using zig":
  selfExec "c -f --cc:zig src/zig_cross_compile.nim"

