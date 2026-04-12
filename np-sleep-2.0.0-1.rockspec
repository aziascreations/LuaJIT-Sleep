package = "np-sleep"
version = "2.0.0-1"
source = {
   url = "https://github.com/aziascreations/LuaJIT-Sleep/archive/refs/tags/v2.0.0.tar.gz",
   dir = "LuaJIT-Sleep-2.0.0",
}
description = {
   summary = "Pure LuaJIT bindings and wrappers for Win32 and Linux sleep functions.",
   detailed = "Module that exposes millisecond and second precision sleep functions for Linux and Windows without having to compile anything.",
   homepage = "https://github.com/aziascreations/LuaJIT-Sleep",
   license = "CC0 1.0 Universal"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      sleep = "sleep.lua"
   },
}
