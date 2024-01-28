const UART = 0x10000000;
const UART_THR: *u8 = @ptrFromInt(UART + 0x00); // THR:transmitter holding register
const UART_LSR: *u8 = @ptrFromInt(UART + 0x05); // LSR:line status register
const UART_LSR_EMPTY_MASK = 0x40; // LSR Bit 6: Transmitter empty; both the THR and LSR are empty

const fmt = @import("std").fmt;
const Writer = @import("std").io.Writer;
pub const writer = Writer(void, error{}, callback){ .context = {} };

fn callback(_: void, string: []const u8) error{}!usize {
    lib_puts(string);
    return string.len;
}

fn lib_putc(ch: u8) u8 {
    while ((UART_LSR.* & UART_LSR_EMPTY_MASK) == 0) {}
    UART_THR.* = ch;
    return ch;
}

fn lib_puts(s: []const u8) void {
    for (s) |ch| {
        _ = lib_putc(ch);
    }
}

pub fn printf(comptime format: []const u8, args: anytype) void {
    fmt.format(writer, format, args) catch unreachable;
}
