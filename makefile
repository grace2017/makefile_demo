#---------------------------------
# 主控Makefile
# 
# zhangyu
# 644735414@qq.com
# 2017-11-19 
#---------------------------------

.PHONY: all clean create_module build_module clean_module test install uninstall

DEBUG := 
ifeq ($(DEBUG),)
CC = gcc
else
CC = gcc -g
endif

TARGET := computer

export ROOT_PATH := $(shell pwd)
export DEPS_PATH := $(ROOT_PATH)/deps
export OBJS_PATH := $(ROOT_PATH)/objs
export INC_PATH := $(ROOT_PATH)/inc
export LIB_PATH := $(ROOT_PATH)/lib
export LIB_EXT_PATH := $(ROOT_PATH)/lib/ext

TARGET_DEP_OBJS := play.o keyboard.o calc.o
TARGET_DEP_OBJS := $(addprefix $(OBJS_PATH)/, $(TARGET_DEP_OBJS))

#目标程序依赖的库
TARGET_DEP_SLIBS := libdisasm.a libmouse.a
TARGET_DEP_DLIBS := libusb.so

CFLAGS =

ifneq ($(TARGET_DEP_SLIBS),)
CFLAGS += $(addprefix -l, $(TARGET_DEP_SLIBS:lib%.a=%))
endif
ifneq ($(TARGET_DEP_DLIBS),)
CFLAGS += $(addprefix -l, $(TARGET_DEP_DLIBS:lib%.so=%))
endif

ifneq ($(CFLAGS),)
CFLAGS += -L$(LIB_PATH)
endif

#获取是模块的子目录
SUBDIRS := $(shell ls -F | grep '/$$')
SUBDIRS := $(filter-out objs/, $(SUBDIRS))
SUBDIRS := $(filter-out deps/, $(SUBDIRS))
SUBDIRS := $(filter-out inc/, $(SUBDIRS))
SUBDIRS := $(filter-out lib/, $(SUBDIRS))

#-----------------------------------------------------
$(TARGET): $(TARGET_DEP_OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

clean:
	rm -rf *.o
	rm -rf $(TARGET)
	rm -rf $(OBJS_PATH)/*.o
	rm -rf $(DEPS_PATH)/*.d
	rm -rf $(LIB_PATH)/*

create_module:
	@if [ ! -z "$$module_name" ]; then				\
		touch $(INC_PATH)/$$module_name.h;			\
		mkdir -p $(ROOT_PATH)/$$module_name;			\
		touch $(ROOT_PATH)/$$module_name/$$module_name.c;	\
	fi				

build_module:
	@for subdir in $(SUBDIRS); do	\
		$(MAKE) -C $$subdir;    \
	done
clean_module:
	@for subdir in $(SUBDIRS); do	\
		cd $$subdir;   		\
		rm -rf *.d;		\
		cd $(ROOT_PATH);	\
	done
test:
	@echo $(CFLAGS)	
install:
	cp $(TARGET) /usr/bin
	cp $(addprefix $(LIB_PATH)/, $(TARGET_DEP_DLIBS)) /usr/lib
uninstall:
	rm -rf /usr/bin/$(TARGET)
	rm -rf $(addprefix /usr/lib/, $(TARGET_DEP_DLIBS))
