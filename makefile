.PHONY: all clean

TARGET := computer
TARGET_DEPS = calc.o mouse.o keyboard.o play.o

$(TARGET): $(TARGET_DEPS)
	gcc -o $@ $^


clean:
	rm -rf *.o
	rm -rf $(TARGET)
