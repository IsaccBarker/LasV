#ifndef SCREEN_H
#define SCREEN_H

extern void clear_screen(void) asm("clear_screen");
extern void reset_cursor(void) asm("reset_cursor");

#endif /* SCREEN_H */

