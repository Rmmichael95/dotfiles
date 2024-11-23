CC=zig cc
RM=rm -rf
LIBS=-lm
# flags
LDFLAGS=
CFLAGS=-g -Wall
# target dirs
OBJDIR=obj
SRCDIR=src
RECDIR=rec
# executable name
TARGET=main

MKDIR=@mkdir -p
dir_guard=$(MKDIR) $(@D)

SRCT=*.c *.h
RECT=txt
SRC_T=*.$(SRCT)
REC_T=*.$(RECT)

DEBUG ?= 1

ifeq ($(DEBUG),1)
	LDFLAGS +=-DLOG_LEVEL=DEBUG_LEVEL -O0 -ggdb
	CFLAGS +=-Wall -Wconversion -Wnarrowing -Wextra -pedantic
else
	CFLAGS  +=-Ofast -g
endif

SRCS=$(wildcard $(SRCDIR)/*.c)
OBJS=$(addprefix $(OBJDIR)/, $(notdir $(SRCS:.c=.o)))
RECS=$(wildcard $(REC_T))

all: $(TARGET)

$(TARGET): $(OBJS)

	@echo [INFO] Creating executable [$(TARGET)]
	@$(CC) $(LDFLAGS) $(CFLAGS) -o $(TARGET) $(OBJS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(dir_guard)
	@echo [C] $<
	@$(CC) $(LDFLAGS) $(CFLAGS) -c -o $@ $<

rt: $(SRCDIR) $(RECDIR)

$(SRCDIR):
ifeq ($(SRC_T),)
else
	@echo [INFO] Handling SAUCE [$(SRCT)]
	@$(MKDIR) $(SRCDIR)
	@mv $(SRCT) $(SRCDIR)
endif

$(RECDIR):
ifeq ($(RECS),)
else
	@echo [INFO] Handling resources [$(RECT)]
	@$(MKDIR) $(RECDIR)
	@mv $(RECS) $(RECDIR)
endif

clean:
	@echo "[Cleaning]"
	@$(RM) $(OBJS)

dist-clean: clean
	@$(RM) $(TARGET)
