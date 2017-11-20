.PHONY: all clean test

TARGET := computer
TARGET_DEP_OBJS = calc.o mouse.o keyboard.o play.o

SOURCES := $(wildcard *.c)
OBJS := $(SOURCES:.c=.o)
DFILES := $(SOURCES:.c=.d)

all: $(TARGET) $(DFILES)

#不能在生成.d文件之前引用
include $(DFILES)

$(TARGET): $(OBJS)
	gcc -o $@ $^

%.d: %.c
	gcc -MM $^ > $@

%.o:
	gcc -c -o $@ $(filter %.c, $^)	

clean:
	rm -rf *.o
	rm -rf *.d
	rm -rf $(TARGET)

test: $(DFILES)
	
