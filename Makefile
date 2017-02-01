CXX=g++
RM=rm -rf
# flags
CXXFLAGS=-std=c++17 -pthread
CPPFLAGS=
# target dirs
OBJDIR=obj
SRCDIR=src
RECDIR=rec
# executable name
TARGET=main

MKDIR=@mkdir -p
dir_guard=$(MKDIR) $(@D)

REC_T=*.txt
RECT=txt

DEBUG ?= 1

ifeq ($(DEBUG),1)
	CXXFLAGS +=-DLOG_LEVEL=DEBUG_LEVEL -O0 -ggdb
	CPPFLAGS +=-Wall -Wconversion -Wnarrowing -Wextra -pedantic
else
	CXXFLAGS  +=-Ofast -g
endif

SRCS=$(wildcard $(SRCDIR)/*.cpp)
OBJS=$(addprefix $(OBJDIR)/, $(notdir $(SRCS:.cpp=.o)))
RECS=$(wildcard $(REC_T))

all: $(TARGET)

$(TARGET): $(OBJS)
	@echo [INFO] Creating executable [$(TARGET)]
	@$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $(TARGET) $(OBJS)

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	$(dir_guard)
	@echo [CC] $<
	@$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $<

$(RECDIR):
ifeq ($(RECS),)
else
	@echo [INFO] Handling recources [$(RECT)]
	@$(MKDIR) $(RECDIR)
	@mv $(RECS) $(RECDIR)
endif

clean:
	@echo "[Cleaning]"
	@$(RM) $(OBJS)

dist-clean: clean
	@$(RM) $(TARGET)
