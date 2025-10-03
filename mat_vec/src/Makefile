CXX = /usr/bin/g++
CXXFLAGS = -I/$(MGC_HOME)/shared/include -std=c++17
SRCS = main.cpp mat_vec.cpp
OBJS = $(SRCS:.cpp=.o)
OUT = mat_vec

all: $(OUT)

$(OUT): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean:
	rm -f $(OBJS) $(OUT)
