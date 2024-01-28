const UART = @import("uart.zig");
const RISCV = @import("riscv.zig");
const SYS = @import("sys.zig");

const reg = RISCV.reg;

const STACK_SIZE = 1024;

const task0_stack: [STACK_SIZE]reg = undefined;

var ctx_os: RISCV.context = RISCV.default_context;
var ctx_task: RISCV.context = RISCV.default_context;

fn task0() noreturn {
    UART.printf("task0\n", .{});
    while (true) {}
}

export fn os_main() noreturn {
    UART.printf("Hello, world!\n", .{});
    ctx_task.ra = @intFromPtr(&task0);
    ctx_task.sp = @intFromPtr(&task0_stack[STACK_SIZE - 1]);
    SYS.sys_switch(&ctx_os, &ctx_task);
    while (true) {}
}
