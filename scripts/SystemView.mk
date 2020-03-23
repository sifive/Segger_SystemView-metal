#
# Copyright 2019 SiFive, Inc #
# SPDX-License-Identifier: Apache-2.0 #
#

ifeq ($(SEGGER_SYSTEMVIEW_DIR),)
	ERR = $(error Please specify SystemView directory by using SYSTEMVIEW_DIR variable )
endif

# ----------------------------------------------------------------------
# Includes Location
# ----------------------------------------------------------------------
override SEGGER_SYSTEMVIEW_INCLUDES := 	${SEGGER_SYSTEMVIEW_DIR}/SystemView/SEGGER \
										${SEGGER_SYSTEMVIEW_DIR}/SystemView/Config