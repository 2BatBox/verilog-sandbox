module = IRotaryEncoder
build_dir = build

tmpdir:
	mkdir -p $(build_dir)

sim: tmpdir
	iverilog -o $(build_dir)/$(module)_tb.vvp $(module).v $(module)_tb.v
	cd $(build_dir) && ./$(module)_tb.vvp && cd ..

show:
	yosys -p 'read_verilog '$(module)'.v; select '$(module)'; show; stat;'

build: tmpdir
	yosys -p "synth_ice40 -json $(build_dir)/$(module).json" -q $(module).v $(module)_top.v
	nextpnr-ice40 --up5k --package sg48 --json $(build_dir)/$(module).json --asc $(build_dir)/$(module).asc --pcf icebreaker.pcf -q -l $(build_dir)/$(module).log
	icepack $(build_dir)/$(module).asc $(build_dir)/$(module).bin
	cat $(build_dir)/$(module).log

prog: build
	iceprog -d i:0x0403:0x6010:0 $(build_dir)/$(module).bin

clean:
	rm -f $(build_dir)/$(module)_tb.vvp
	rm -f $(build_dir)/$(module)_tb.vcd
	rm -f $(build_dir)/$(module).json
	rm -f $(build_dir)/$(module).asc
	rm -f $(build_dir)/$(module).log
	rm -f $(build_dir)/$(module).bin
	rm -d $(build_dir)
