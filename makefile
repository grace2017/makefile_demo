.PHONY: all clean create_module build_module clean_module test

TARGET := computer

export ROOT_PATH := $(shell pwd)
export DEPS_PATH := $(ROOT_PATH)/deps
export OBJS_PATH := $(ROOT_PATH)/objs
export INC_PATH := $(ROOT_PATH)/inc
export LIB_PATH := $(ROOT_PATH)/lib

TARGET_DEP_OBJS := play.o keyboard.o calc.o
TARGET_DEP_OBJS := $(addprefix $(OBJS_PATH)/, $(TARGET_DEP_OBJS))

#目标程序依赖的静态库
TARGET_DEP_SLIBS := libdisasm.a libmouse.a
ifneq ($(TARGET_DEP_SLIBS),)
CFLAGS = -L$(LIB_PATH) $(addprefix -l, $(TARGET_DEP_SLIBS:lib%.a=%))
endif

SUBDIRS := $(shell ls -F | grep '/$$')
SUBDIRS := $(filter-out objs/, $(SUBDIRS))
SUBDIRS := $(filter-out deps/, $(SUBDIRS))
SUBDIRS := $(filter-out inc/, $(SUBDIRS))
SUBDIRS := $(filter-out lib/, $(SUBDIRS))

#-----------------------------------------------------
$(TARGET): $(TARGET_DEP_OBJS)
	gcc -o $@ $^ $(CFLAGS)

clean:
	rm -rf *.o
	rm -rf $(TARGET)
	rm -rf $(OBJS_PATH)/*.o
	rm -rf $(DEPS_PATH)/*.d
	rm -rf $(LIB_PATH)/*

create_module:
	@if [ -z "$$module_name" ]; then	\
		echo "1";			\
	else					\
		echo "2";			\
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
