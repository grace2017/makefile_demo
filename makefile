.PHONY: all clean build_module clean_module test

TARGET := computer

export ROOT_PATH := $(shell pwd)
export OBJS_PATH := $(addsuffix /objs, $(ROOT_PATH))

TARGET_DEP_OBJS := $(wildcard $(OBJS_PATH)/*.o)

SUBDIRS := $(shell ls -F | grep '/$$')
SUBDIRS := $(filter-out objs/, $(SUBDIRS))

#-----------------------------------------------------
$(TARGET): $(TARGET_DEP_OBJS)
	gcc -o $@ $^

clean:
	rm -rf *.o
	rm -rf $(TARGET)
	rm -rf $(OBJS_PATH)/*.o

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
