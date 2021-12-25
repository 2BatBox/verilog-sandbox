target = go-board
.DEFAULT_GOAL = build

source_lib_path=$(addprefix ../../../lib/, $(source))
source_list=$(addsuffix .v, $(source_lib_path))
source_list+=top.v

$(target).blif: $(source_list)
	yosys -p "synth_ice40 -blif $(target).blif" -q -l $(target).log  $(source_list)
	
$(target).txt: $(target).blif
	arachne-pnr --device 1k --package vq100 -p ../$(target).pcf -o $(target).txt $(target).blif
	
$(target).bin: $(target).txt
	icepack $(target).txt $(target).bin

build: $(target).bin

prog: build
	iceprog $(target).bin
	
prog-sram: build
	iceprog -S $(target).bin
	
clean:
	rm -f $(target).blif
	rm -f $(target).log
	rm -f $(target).txt
	rm -f $(target).bin
