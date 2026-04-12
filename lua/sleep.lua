--- Pure LuaJIT bindings for Windows and Linux native `sleep` function.
-- 
-- @module sleep
-- @author Herwin Bozet (NibblePoker)
-- @license CC0 1.0 Universal (CC0 1.0) (Public Domain)
-- @copyright 2026
--
-- @release 2.0.0


-- Setup
-- -----

local ffi = require("ffi")

local _is_win32 = ffi.os == "Windows"
local _is_linux = ffi.os == "Linux"

local M = {}



-- Config
-- ------

--- Allows you to ignore errors about negative numbers and others returned by the OS.
M.ignore_errors = false



-- Private globals
-- ---------------

-- @function _win32_sleep
local _win32_sleep

-- @function _linux_nanosleep
local _linux_nanosleep



-- Bindings
-- --------

if _is_win32 then
    -- Documentation:
    --  * https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-sleep

    local _kernel32_lib = ffi.load("kernel32")

    ffi.cdef [[
        typedef unsigned long DWORD;
        void Sleep(DWORD dwMilliseconds);
    ]]

    _win32_sleep = _kernel32_lib.Sleep

elseif _is_linux then
    -- Documentation:
    --  * https://man7.org/linux/man-pages/man3/sleep.3.html
    --  * https://man7.org/linux/man-pages/man2/nanosleep.2.html

    ffi.cdef [[
        typedef long time_t;
    
        typedef struct {
            time_t tv_sec;
            long   tv_nsec;
        } timespec_t;
    
        int nanosleep(const timespec_t *req, timespec_t *rem);
    ]]

    _linux_nanosleep = ffi.C.nanosleep

else
    error("Library must be used on Win32 or Linux platforms ! (os: " .. ffi.os .. ")")
end



-- Wrappers
-- --------

--- Sleeps for a given amount of milliseconds and returns. \
--- May be interrupted by the OS.
--- @param milliseconds number Amount of milliseconds to sleep.
--- @return nil
function M.sleep_ms(milliseconds)
    if milliseconds < 0 then
        if M.ignore_errors then
            milliseconds = 0
        else
            error("milliseconds: argument must be a non-negative integer")
        end
    end

    if _is_win32 then
        _win32_sleep(milliseconds)
    elseif _is_linux then
        -- timespec_t { seconds, milliseconds_left_as_ns }
        local req = ffi.new(
            "timespec_t", math.floor(milliseconds / 1000), (milliseconds % 1000) * 1e6
        )

        if _linux_nanosleep(req, nil) ~= 0 then
            if not M.ignore_errors then
                error(string.format("sleep_ms: sleep: nanosleep failed (errno %d)", ffi.errno()))
            end
        end
    else
        error("Library must be used on Win32 or Linux platforms ! (os: " .. ffi.os .. ")")
    end

    return nil
end

--- Sleeps for a given amount of seconds and returns. \
--- May be interrupted by the OS.
--- @param seconds number Amount of seconds to sleep.
--- @return nil
function M.sleep_s(seconds)
    return M.sleep_ms(seconds * 1000)
end


return M
