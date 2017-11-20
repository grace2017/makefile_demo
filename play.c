#include "keyboard/keyboard.h"
#include "mouse/mouse.h"
#include "calc/calc.h"

int main()
{
	keyboard_init();
	mouse_init();
	calc_init();
	
	return 0;
}
