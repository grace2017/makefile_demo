.PHONY: all

#测试用，实际是由总控makefile传入
#OBJS_PATH := $(shell pwd)

SOURCES := $(wildcard *.c)

DFILES := $(SOURCES:.c=.d)
DFILES := $(addprefix $(DEPS_PATH)/, $(DFILES))

OBJS := $(SOURCES:.c=.o)
OBJS := $(addprefix $(OBJS_PATH)/, $(OBJS))

all: $(DFILES) $(OBJS)

ifneq ("$(wildcard $(DFILES))",)
-include $(DFILES)
endif

$(DEPS_PATH)/%d: %c
	gcc -MM $^ | sed 's,\(.*\).o:,$(OBJS_PATH)/\1.o:,g' > $@

$(OBJS_PATH)/%o:
	gcc -c -o $@ $(filter %.c, $^)
