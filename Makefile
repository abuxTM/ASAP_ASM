AS = nasm
ASFLAGS = -f elf64 -I include/
LD = ld

SRC = $(wildcard src/*.asm)
OBJ = $(patsubst src/%.asm, build/%.o, $(SRC))

TARGET = bin/zen_dir

all: $(TARGET)

build/%.o: src/%.asm
	$(AS) $(ASFLAGS) -o $@ $<

$(TARGET): $(OBJ)
	$(LD) -o $@ $^

run: all
	clear
	@./$(TARGET)

clean:
	rm -rf build/*.o $(TARGET)
