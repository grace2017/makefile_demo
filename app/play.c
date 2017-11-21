#include <stdio.h>

#include "keyboard.h"
#include "mouse.h"
#include "calc.h"
#include "disasm.h"
#include "usb.h"

int main()
{
	keyboard_init();
	mouse_init();
	calc_init();
	init_disasm();
	printf("usb init: %d \n", init_usb());
	
	return 0;
}
