pub const reg = u32;

pub const context = extern struct {
    ra: reg,
    sp: reg,

    // callee-saved
    s0: reg,
    s1: reg,
    s2: reg,
    s3: reg,
    s4: reg,
    s5: reg,
    s6: reg,
    s7: reg,
    s8: reg,
    s9: reg,
    s10: reg,
    s11: reg,
};

pub const default_context = context{
    .ra = 0,
    .sp = 0,
    .s0 = 0,
    .s1 = 0,
    .s2 = 0,
    .s3 = 0,
    .s4 = 0,
    .s5 = 0,
    .s6 = 0,
    .s7 = 0,
    .s8 = 0,
    .s9 = 0,
    .s10 = 0,
    .s11 = 0,
};
