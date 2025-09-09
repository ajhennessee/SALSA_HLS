CXX = /usr/bin/g++
CXXFLAGS = -I/$(MGC_HOME)/shared/include -std=c++17
SRCS = main.cpp cholesky.cpp
OBJS = $(SRCS:.cpp=.o)
OUT = cholesky

all: $(OUT)

$(OUT): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean:
	rm -f $(OBJS) $(OUT)