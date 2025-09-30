CXX = /usr/bin/g++
CXXFLAGS = -I/$(MGC_HOME)/shared/include -std=c++17
SRCS = main.cpp outer_product.cpp
OBJS = $(SRCS:.cpp=.o)
OUT = outer_product

all: $(OUT)

$(OUT): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean:
	rm -f $(OBJS) $(OUT)