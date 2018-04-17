CXX=clang++
CXXFLAGS=-lfl -std=c++14
all: prob1


prob1: prob1.l
	flex++ prob1.l
	$(CXX) lex.yy.cc -o prob1 $(CXXFLAGS)
	$(RM) lex.yy.cc

clean:
	$(RM) prob1 lex.yy.cc

test: prob1
	./prob1 < tests/test1.txt
	./prob1 < tests/test2.txt
	./prob1 < tests/test3.txt
