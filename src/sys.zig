const context = @import("riscv.zig").context;

pub extern fn sys_timer() void;
pub extern fn sys_switch(ctx_old: *context, ctx_new: *context) void;
