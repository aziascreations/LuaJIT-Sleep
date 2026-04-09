# LuaJIT - Sleep
Pure LuaJIT bindings and wrappers for native sleep functions on Win32 and Linux.

**📢 This is library is in low maintenance mode** \
I consider it feature-complete, and unless a bug is found, I don't plan on updating it.


## Features
* Second-level sleeps
* Millisecond-level sleeps
* Ability to supress all errors


## Requirements
* A somewhat modern OS
    * Windows XP or newer *(x86/x64) (Untested on ARM32/ARM64)*
    * Windows Server 2003 or newer *(x86/x64) (Untested on ARM32/ARM64)*
    * Linux 4.4+ *(x86/x64) (Untested on ARM32/ARM64/RISCV/...)*
* *LuaJIT v2.1.*


## Installation

### Manual
1. Download the [latest release](https://github.com/aziascreations/LuaJIT-Sleep/releases).
2. Extract the content of the archive in your `lua/` folder.

### LuaRocks
* TODO: Will be done soon-ish


## Example

```lua
local sleep_lib = require("sleep")

print("Now sleeping for 3 seconds...")

sleep_lib.sleep_s(3)

print("Now sleeping for 500 milliseconds...")

sleep_lib.sleep_ms(500)

print("I'm back and awake")
```


## License

The code in this repository is licensed under
[CC0 1.0 Universal (CC0 1.0) (Public Domain)](LICENSE).
