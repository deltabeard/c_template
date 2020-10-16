# This file is for use with GNU Make only.
# Project details
NAME		:= Project
DESCRIPTION	:= An example C project
COMPANY		:= Company
COPYRIGHT	:= Copyright (c) 2020 Mahyar Koshkouei
LICENSE_SPDX	:= 0BSD

# Default configurable build options
BUILD	:= DEBUG

# Build help text shown using `make help`.
define help_txt
$(NAME) - $(DESCRIPTION)

Available options and their descriptions when enabled:
  BUILD=$(BUILD)
    The type of build configuration to use.
    This is one of DEBUG, RELEASE, RELDEBUG and RELMINSIZE.
      DEBUG: All debugging symbols; No optimisation.
      RELEASE: No debugging symbols; Optimised for speed.
      RELDEBUG: All debugging symbols; Optimised for speed.
      RELMINSIZE: No debugging symbols; Optimised for size.

  EXTRA_CFLAGS=$(EXTRA_CFLAGS)
    Extra CFLAGS to pass to C compiler.

  EXTRA_LDFLAGS=$(EXTRA_LDFLAGS)
    Extra LDFLAGS to pass to the C compiler.

Example: make BUILD=RELEASE EXTRA_CFLAGS="-march=native"

$(LICENSE)
endef

ifdef VSCMD_VER
	# Default compiler options for Microsoft Visual C++ (MSVC)
	CC	:= cl
	OBJEXT	:= obj
	RM	:= del
	EXEOUT	:= /Fe
	CFLAGS	:= /nologo /analyze /diagnostics:caret /W3
	LDFLAGS := /link /SUBSYSTEM:CONSOLE
	ICON_FILE := icon.ico
	RES	:= meta\winres.res
else
	# Default compiler options for GCC and Clang
	CC	:= cc
	OBJEXT	:= o
	RM	:= rm -f
	EXEOUT	:= -o
	CFLAGS	:= -std=c99 -pedantic -Wall -Wextra
endif

# Options specific to 32-bit platforms
ifeq ($(VSCMD_ARG_TGT_ARCH),x32)
	# Uncomment the following to use SSE instructions (since Pentium III).
	# The default is /arch:SSE2 (since Pentium4).
	#CFLAGS += /arch:SSE

	# Uncomment the following to support ReactOS and Windows XP.
	#CFLAGS += /Fdvc141.pdb
endif

#
# No need to edit anything past this line.
#
EXE	:= $(NAME)
LICENSE := $(COPYRIGHT); Released under the $(LICENSE_SPDX) License.
GIT_VER := $(shell git describe --dirty --always --tags --long)

SRCS := $(wildcard src/*.c)
OBJS := $(SRCS:.c=.$(OBJEXT))

# File extension ".exe" is automatically appended on MinGW and MSVC builds, even
# if we don't ask for it.
ifeq ($(OS),Windows_NT)
	EXE := $(NAME).exe
endif

# Use a fallback git version string if build system does not have git.
ifeq ($(GIT_VER),)
	GIT_VER := LOCAL
endif

# Function to check if running within MSVC Native Tools Command Prompt.
MSVC_GCC = $(if $(VSCMD_VER),$(1),$(2))

# Select default build type
ifndef BUILD
	BUILD := DEBUG
endif

# Apply build type settings
ifeq ($(BUILD),DEBUG)
	CFLAGS += $(call MSVC_GCC,/Zi /MTd /RTC1,-O0 -g3)
else ifeq ($(BUILD),RELEASE)
	CFLAGS += $(call MSVC_GCC,/MT /O2 /fp:fast,-Ofast -s)
else ifeq ($(BUILD),RELDEBUG)
	CFLAGS += $(call MSVC_GCC,/MTd /O2 /fp:fast,-Ofast -g3)
else ifeq ($(BUILD),RELMINSIZE)
	CFLAGS += $(call MSVC_GCC,/MT /O1 /fp:fast,-Os -ffast-math -s)
else
	err := $(error Unknown build configuration '$(BUILD)')
endif

override CFLAGS += -Iinc $(EXTRA_CFLAGS)
override LDFLAGS += $(EXTRA_LDFLAGS)

all: $(EXE)
$(EXE): $(OBJS) $(RES)
	$(info LINK $^)
	@$(CC) $(CFLAGS) $(EXEOUT)$@ $^ $(LDFLAGS)
	$(info OUT $@)

%.o: %.c
	$(info CC $@)
	@$(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<

# cl always prints the source file name, so we just add the CC suffix.
%.obj: %.c
	@echo CC $(dir $^)$(shell $(CC) $(CFLAGS) /Fo$@ /c /TC $^)

%.res: %.rc
	$(info RC $@)
	@rc /nologo /DCOMPANY="$(COMPANY)" /DDESCRIPTION="$(DESCRIPTION)" \
		/DLICENSE="$(LICENSE)" /DGIT_VER="$(GIT_VER)" \
		/DNAME="$(NAME)" /DICON_FILE="$(ICON_FILE)" $^

clean:
	$(RM) $(EXE) $(RES)
	cd src && $(RM) *.$(OBJEXT)

help:
	@cd
	$(info $(help_txt))
