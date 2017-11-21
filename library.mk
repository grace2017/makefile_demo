.PHONY: all

include $(ROOT_PATH)/module.mk

ifeq ("$(LIB_TYPE)", "dynamic")
	CREATE_LIB_ACTION := gcc -shared -fPCI -o
else
	CREATE_LIB_ACTION := ar rcs
endif

all: $(LIB_NAME)

$(LIB_NAME): $(LIB_DEP_OBJS)
	$(CREATE_LIB_ACTION) $@ $^
