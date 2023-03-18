target = ice-sugar
device = up5k
package = sg48

.DEFAULT_GOAL = build

source = top.v

$(target).blif: $(source)
	yosys -p "synth_ice40 -blif $(target).blif" -q -l $(target).log $(source)
	
$(target).txt: $(target).blif
	arachne-pnr --device 5k --package $(package) -p ../$(target).pcf -o $(target).txt --post-pack-verilog $(target).v $(target).blif
	
$(target).bin: $(target).txt
	icepack $(target).txt $(target).bin

build: $(target).bin

prog: build
	../icesprog $(target).bin  # as root ?
	
ta: $(target).txt
	icetime -mt -p ../$(target).pcf -P $(package) -d $(device) $(target).txt
	
show:
	yosys -p 'read_verilog top.v; show top'
	
clean:
	rm -f $(target).blif
	rm -f $(target).log
	rm -f $(target).txt
	rm -f $(target).bin
	rm -f $(target).v
