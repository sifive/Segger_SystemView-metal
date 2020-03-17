
override CURRENT_DIR := $(patsubst %/,%, $(dir $(abspath $(firstword $(MAKEFILE_LIST)))))

override SOURCE_DIR := $(CURRENT_DIR)/SystemView
BUILD_DIR ?= $(CURRENT_DIR)/build

include scripts/SystemView_core.mk

################################################################################
#                        COMPILATION FLAGS
################################################################################
override CFLAGS += $(foreach dir,$(INCLUDE_DIRS),-I $(dir))

override ASFLAGS = $(CFLAGS)

ifeq ($(origin ARFLAGS),default)
	ifeq ($(VERBOSE),TRUE)
		override ARFLAGS :=	cruv
	else
		override ARFLAGS :=	cru
	endif
else
	ifeq ($(VERBOSE),TRUE)
		ARFLAGS ?= cruv
	else
		ARFLAGS ?= cru
	endif
endif

################################################################################
#                               MACROS
################################################################################
ifeq ($(VERBOSE),TRUE)
	HIDE := 
else
	HIDE := @
endif

################################################################################
#                                RULES
################################################################################

libSystemView.a : err $(OBJS)
	$(HIDE) mkdir -p $(BUILD_DIR)/lib
	$(HIDE) $(AR) $(ARFLAGS) $(BUILD_DIR)/lib/libSystemView.a $(OBJS)

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.c err
	$(HIDE) mkdir -p $(dir $@)
	$(HIDE) $(CC) -c -o $@ $(CFLAGS) $<

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.S err
	$(HIDE) mkdir -p $(dir $@)
	$(HIDE) $(CC) -D__ASSEMBLY__ -c -o $@ $(ASFLAGS) $<

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.s err
	$(HIDE) mkdir -p $(dir $@)
	$(HIDE) $(CC) -D__ASSEMBLY__ -c -o $@ $(ASFLAGS) $<

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.asm err
	$(HIDE) mkdir -p $(dir $@)
	$(HIDE) $(CC) -D__ASSEMBLY__ -c -o $@ $(ASFLAGS) $<

.PHONY: err
err: 
	$(ERR)

.PHONY : clean
clean:
	rm -rf ./$(BUILD_DIR)
