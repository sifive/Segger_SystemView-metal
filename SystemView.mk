#
# Copyright 2019 SiFive, Inc #
# SPDX-License-Identifier: Apache-2.0 #
#

TMPVAR=$(abspath $(dir $(lastword ${MAKEFILE_LIST})))/SystemView
SEGGER_SYSTEMVIEW_DIR := $(shell realpath --relative-to . $(TMPVAR))

# ----------------------------------------------------------------------
# CORE PART
# ----------------------------------------------------------------------
SEGGER_SYSTEMVIEW_C_SOURCE = SEGGER_SYSVIEW.c
SEGGER_SYSTEMVIEW_C_SOURCE += SEGGER_RTT.c
SEGGER_SYSTEMVIEW_C_SOURCE += SEGGER_RTT_printf.c


# ----------------------------------------------------------------------
# Includes Location
# ----------------------------------------------------------------------
SEGGER_SYSTEMVIEW_INCLUDES := -I${SEGGER_SYSTEMVIEW_DIR}/SEGGER
SEGGER_SYSTEMVIEW_INCLUDES += -I${SEGGER_SYSTEMVIEW_DIR}/Config

# ----------------------------------------------------------------------
# Modify the VPATH
# ----------------------------------------------------------------------
VPATH:=${SEGGER_SYSTEMVIEW_DIR}/SEGGER:${VPATH}
