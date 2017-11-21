.PHONY: all

include $(ROOT_PATH)/module.mk

all: $(LIB_NAME)

$(LIB_NAME): $(LIB_DEP_OBJS)
	ar rcs $@ $^
