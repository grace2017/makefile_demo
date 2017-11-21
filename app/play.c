#include "keyboard.h"
#include "mouse.h"
#include "calc.h"

int main()
{
	keyboard_init();
	mouse_init();
	calc_init();
	
	return 0;
}
