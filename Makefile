TARGET = test

SRCDIR = tests
SRCS  = $(shell find ./$(SRCDIR) -type f -name *.cpp)
HEADS = $(shell find ./include -type f -name *.hpp)
OBJS = $(SRCS:.cpp=.o)
DEPS = Makefile.d

INCLUDES = -I./include
CXXFLAGS = -Wall -Wextra -Werror -std=c++14 $(INCLUDES)
LDFLAGS =


all: $(TARGET)

$(TARGET): $(OBJS) $(HEADS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS)

run: all
	@./$(TARGET)

.PHONY: depend clean
depend:
	$(CXX) $(INCLUDES) -MM $(SRCS) > $(DEPS)
	@sed -i 's|[a-zA-Z0-9_-]*\.o|$(SRCDIR)/&|' $(DEPS)

clean:
	$(RM) $(OBJS) $(TARGET) $(DEPS)

-include $(DEPS)
