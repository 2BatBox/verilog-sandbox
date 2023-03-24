CC = iverilog
FLAGS = -Wall -g2005-sv
INCLUDE = ../../../
.DEFAULT_GOAL = test
TOP = top.v

$(tbench).vpp: $(TOP)
	$(CC) -I$(INCLUDE) $(FLAGS) -o $(TEST_BENCH).vpp $(TOP) -pRECURSIVE_MOD_LIMIT=64
	
test: $(tbench).vpp
	./$(TEST_BENCH).vpp
	
view: test
	gtkwave $(TEST_BENCH).vcd
	
clean:
	rm -rf $(TEST_BENCH).vpp
	rm -rf $(TEST_BENCH).vcd
	
