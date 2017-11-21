#include "keyboard.h"
#include "mouse.h"
#include "calc.h"
#include "disasm.h"

int main()
{
	keyboard_init();
	mouse_init();
	calc_init();
	init_disasm();
	
	return 0;
}
