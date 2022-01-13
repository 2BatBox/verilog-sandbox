target = ice-sugar
.DEFAULT_GOAL = build

source_lib_path=$(addprefix ../../../lib/, $(source))
source_list=$(addsuffix .v, $(source_lib_path))
source_list+=top.v

$(target).blif: $(source_list)
	yosys -p "synth_ice40 -blif $(target).blif" -q -l $(target).log $(source_list)
	
$(target).txt: $(target).blif
	arachne-pnr --device 5k --package sg48 -p ../$(target).pcf -o $(target).txt $(target).blif
	
$(target).bin: $(target).txt
	icepack $(target).txt $(target).bin

build: $(target).bin

prog: build
	icesprog $(target).bin
	
show:
	yosys -p 'read_verilog top.v; show'
	
clean:
	rm -f $(target).blif
	rm -f $(target).log
	rm -f $(target).txt
	rm -f $(target).bin
