#
# Copyright 2019 SiFive, Inc #
# SPDX-License-Identifier: Apache-2.0 #
#

# ----------------------------------------------------------------------
# CORE PART
# ----------------------------------------------------------------------
# keep this to give a hint in case a source dir should be added
override SOURCE_DIRS := 

# ---------------------------------------------------------------------
override C_SOURCES := $(foreach dir,$(SOURCE_DIRS),$(wildcard $(dir)/*.c))

override ASM_SOURCES := $(foreach dir,$(SOURCE_DIRS),$(wildcard $(dir)/*.[Ss])) \
						$(foreach dir,$(SOURCE_DIRS),$(wildcard $(dir)/*.asm))

# Add source files one by one (in case we can include the whole directory)
override C_SOURCES +=	$(SOURCE_DIR)/SEGGER/SEGGER_SYSVIEW.c \
						$(SOURCE_DIR)/SEGGER/SEGGER_RTT.c \
						$(SOURCE_DIR)/SEGGER/SEGGER_RTT_printf.c

SEGGER_SYSTEMVIEW_DIR := $(CURRENT_DIR)
include $(CURRENT_DIR)/scripts/SystemView.mk

override INCLUDE_DIRS := $(SEGGER_SYSTEMVIEW_INCLUDES)

override INCLUDES := $(foreach dir,$(INCLUDE_DIRS),$(wildcard $(dir)/*.h))

override C_OBJS := $(subst $(SOURCE_DIR),$(BUILD_DIR),$(C_SOURCES:.c=.o))
override ASM_OBJS := 	$(subst $(SOURCE_DIR),$(BUILD_DIR), $(patsubst %.S,%.o,$(filter %.S,$(ASM_SOURCES))))\
						$(subst $(SOURCE_DIR),$(BUILD_DIR), $(patsubst %.s,%.o,$(filter %.s,$(ASM_SOURCES))))\
						$(subst $(SOURCE_DIR),$(BUILD_DIR), $(patsubst %.asm,%.o,$(filter %.asm,$(ASM_SOURCES))))

override OBJS := $(C_OBJS) $(ASM_OBJS)