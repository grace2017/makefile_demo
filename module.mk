.PHONY: all

SOURCES := $(wildcard *.c)
OBJS := $(SOURCES:.c=.o)
DFILES := $(SOURCES:.c=.d)

all: $(DFILES) $(OBJS)

ifneq ("$(wildcard $(DFILES))",)
-include $(DFILES)
endif

%d: %c
	gcc -MM $^ > $@
%o:
	gcc -c -o $@ $(filter %.c, $^)
