// Alles-OS Kernel
// Phase 1

#include <stdint.h>

static volatile uint16_t* vga = (uint16_t*)0xB8000;
static int cursor = 0;

void terminal_write(char c)
{
    vga[cursor++] = (uint16_t)c | 0x0700;
}

void terminal_print(const char* text)
{
    while (*text)
    {
        terminal_write(*text++);
    }
}

void kernel_main(void)
{
    terminal_print("==========================\n");
    terminal_print("       Alles OS\n");
    terminal_print("       Version 0.1\n");
    terminal_print("==========================\n\n");
    terminal_print("64-bit kernel started!\n");

    while (1)
    {
        __asm__("hlt");
    }
}
