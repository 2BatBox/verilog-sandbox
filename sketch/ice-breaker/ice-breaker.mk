target = ice-breaker

modules_path=$(addprefix ../../../lib/, $(modules))
modules_files=$(addsuffix .v, $(modules_path))
modules_files+=$(sketch).v

build: 
	yosys -p "synth_ice40 -blif $(target).blif" -q $(modules_files)
	arachne-pnr --device 5k --package sg48 -p ../$(target).pcf -o $(target).txt $(target).blif
	icepack $(target).txt $(target).bin

prog: build
	iceprog $(target).bin

clean:
	rm -f $(target).blif
	rm -f $(target).txt
	rm -f $(target).bin
