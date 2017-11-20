.PHONY: all clean build_module clean_module

TARGET := computer
TARGET_DEP_OBJS := calc/calc.o keyboard/keyboard.o mouse/mouse.o play.o

ROOT_PATH := $(shell pwd)
SUBDIRS := $(shell ls -F | grep '/$$')

#-----------------------------------------------------
$(TARGET): $(TARGET_DEP_OBJS)
	gcc -o $@ $^

clean:
	rm -rf *.o
	rm -rf $(TARGET)

build_module:
	@for subdir in $(SUBDIRS); do	\
		$(MAKE) -C $$subdir;    \
	done
clean_module:
	@for subdir in $(SUBDIRS); do	\
		cd $$subdir;   		\
		rm -rf *.o;		\
		rm -rf *.d;		\
		cd $(ROOT_PATH);	\
	done
	
