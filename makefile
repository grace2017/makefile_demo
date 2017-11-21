.PHONY: all clean create_module build_module clean_module test

TARGET := computer

export ROOT_PATH := $(shell pwd)
export DEPS_PATH := $(ROOT_PATH)/deps
export OBJS_PATH := $(ROOT_PATH)/objs
export INC_PATH := $(ROOT_PATH)/inc

TARGET_DEP_OBJS := $(wildcard $(OBJS_PATH)/*.o)

SUBDIRS := $(shell ls -F | grep '/$$')
SUBDIRS := $(filter-out objs/, $(SUBDIRS))
SUBDIRS := $(filter-out deps/, $(SUBDIRS))
SUBDIRS := $(filter-out inc/, $(SUBDIRS))

#-----------------------------------------------------
$(TARGET): $(TARGET_DEP_OBJS)
	gcc -o $@ $^

clean:
	rm -rf *.o
	rm -rf $(TARGET)
	rm -rf $(OBJS_PATH)/*.o
	rm -rf $(DEPS_PATH)/*.d

create_module:
	if [ -z "$$module_name" ]; then
		echo "1"
	else
		echo "2"
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
	@echo $(SUBDIRS)	
