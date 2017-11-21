.PHONY: all

#测试用，实际是由总控makefile传入
#OBJS_PATH := $(shell pwd)

SOURCES := $(wildcard *.c)
DFILES := $(SOURCES:.c=.d)

OBJS := $(addprefix $(OBJS_PATH)/, $(SOURCES:.c=.o))

all: $(DFILES) $(OBJS)

ifneq ("$(wildcard $(DFILES))",)
-include $(DFILES)
endif

%d: %c
	gcc -MM $^ | sed 's,\(.*\).o:,$(OBJS_PATH)/\1.o:,g' > $@

$(OBJS_PATH)/%o:
	gcc -c -o $@ $(filter %.c, $^)
