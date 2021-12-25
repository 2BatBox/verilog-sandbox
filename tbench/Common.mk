CC = iverilog
FLAGS = -Wall -g2005-sv
INCLUDE = ../../../
.DEFAULT_GOAL = test

$(tbench).vpp: $(tbench).v
	$(CC) -I$(INCLUDE) $(FLAGS) -o $(tbench).vpp $(tbench).v
	
test: $(tbench).vpp
	./$(tbench).vpp
	
view: test
	gtkwave $(tbench).vcd
	
clean:
	rm -rf $(tbench).vpp
	rm -rf $(tbench).vcd
	
