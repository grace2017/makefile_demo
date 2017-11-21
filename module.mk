#---------------------------------
# [公用] 自动生成依赖，将.c文件生成.o文件
# 
# zhangyu
# 644735414@qq.com
# 2017-11-20
#---------------------------------

.PHONY: all

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
	gcc -I$(INC_PATH) -MM $^ | sed 's,\(.*\).o:,$(OBJS_PATH)/\1.o:,g' > $@

$(OBJS_PATH)/%o:
	gcc -I$(INC_PATH) -c -o $@ $(filter %.c, $^)
