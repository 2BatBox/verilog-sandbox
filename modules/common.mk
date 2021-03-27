sim:
	iverilog -o $(module)_tb.vvp $(module).v $(module)_tb.v
	./$(module)_tb.vvp

show:
	yosys -p 'read_verilog '$(module)'.v; select '$(module)'; show -stretch; stat;'

clean:
	rm -f $(module)_tb.vvp
	rm -f $(module)_tb.vcd
