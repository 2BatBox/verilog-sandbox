target = go-board

modules_path=$(addprefix ../../../modules/, $(modules))
modules_files=$(addsuffix .v, $(modules_path))
modules_files+=$(sketch).v

test:
	echo '$(modules)'
	echo '$(modules_files)'

build: 
	yosys -p "synth_ice40 -json $(target).json" -q $(modules_files)
	nextpnr-ice40 --hx1k --package vq100 --json $(target).json --asc $(target).asc --pcf ../$(target).pcf -q -l $(target).log
	icepack $(target).asc $(target).bin
	cat $(target).log

prog: build
	iceprog -d i:0x0403:0x6010:0 $(target).bin

clean:
	rm -f $(target).json
	rm -f $(target).asc
	rm -f $(target).log
	rm -f $(target).bin
