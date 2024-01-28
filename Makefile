QEMU = qemu-system-riscv32
QFLAGS = -nographic -smp 4 -machine virt -bios none

OBJDUMP = riscv64-unknown-elf-objdump

OS = zig-out/bin/roz

ZIG_FILES = $(wildcard src/*.zig)
ASM_FILES = $(wildcard src/*.S)
LD_SCRIPT = src/linker.ld

all: os.elf

$(OS): $(ZIG_FILES) $(ASM_FILES) $(LD_SCRIPT)
	zig build

qemu: $(OS)
	@qemu-system-riscv32 -M ? | grep virt >/dev/null || exit
	@echo "Press Ctrl-A and then X to exit QEMU"
	$(QEMU) $(QFLAGS) -kernel $(OS)

clean:
	rm -f *.elf
