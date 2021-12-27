CC = iverilog
FLAGS = -Wall -g2005-sv
INCLUDE = ../../../
.DEFAULT_GOAL = test

$(tbench).vpp: $(TOP)
	$(CC) -I$(INCLUDE) $(FLAGS) -o $(TEST_BENCH).vpp $(TOP)
	
test: $(tbench).vpp
	./$(TEST_BENCH).vpp
	
view: test
	gtkwave $(TEST_BENCH).vcd
	
clean:
	rm -rf $(TEST_BENCH).vpp
	rm -rf $(TEST_BENCH).vcd
	
