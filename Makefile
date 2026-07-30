ASM=nasm
CC=x86_64-elf-gcc
LD=x86_64-elf-ld

CFLAGS=-ffreestanding -m64 -O2 -Wall

all: os.bin

boot.bin:
	$(ASM) -f bin boot/boot.asm -o boot.bin

kernel.o:
	$(CC) $(CFLAGS) -c kernel/kernel.c -o kernel.o

kernel.bin: kernel.o
	$(LD) -T linker.ld kernel.o -o kernel.bin

os.bin: boot.bin kernel.bin
	cat boot.bin kernel.bin > os.bin

clean:
	rm -f *.bin *.o
