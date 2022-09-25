SOURCES = $(shell find src -type f -name "*.cpp")
OBJDIR = obj
OBJECTS = $(addprefix $(OBJDIR)/,$(notdir $(SOURCES:.cpp=.so)))
TESTSDIR = tests

PYTHON_VERSION = python3.7
PYTHON_CFLAGS = $(shell $(PYTHON_VERSION)m-config --cflags)
PYTHON_LDFLAGS = $(shell $(PYTHON_VERSION)m-config --ldflags)
PYBIND11_INCLUDE = $(shell $(PYTHON_VERSION) -m pybind11 --includes)

CPP = clang++
CPPFLAGS = -O3 -Wall -shared -std=c++11 -fPIC $(PYTHON_CFLAGS) $(PYBIND11_INCLUDE)
LDFLAGS = $(PYTHON_LDFLAGS)

$(OBJECTS): $(SOURCES)
	$(CPP) $(CPPFLAGS) $(LDFLAGS) $^ -o $@

modules: $(OBJECTS)

all: modules

clean:
	rm -rf $(OBJDIR)/*.so

test: 
	$(foreach file, $(wildcard $(TESTSDIR)/*.py), @PYTHONPATH=$(OBJDIR) $(PYTHON_VERSION) -B $(file);)
