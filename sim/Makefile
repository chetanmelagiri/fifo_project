UVM_HOME = /cad/INCISIV131/tools/uvm/uvm_lib/uvm_sv
UVM_VERBOSITY = UVM_HIGH

cmdrun:
	irun -access rw -svseed random -uvmhome $(UVM_HOME) +UVM_VERBOSITY=$(UVM_VERBOSITY) -quiet fifo.v fifo_if.sv test_pkg.sv top.sv -gui

clean:
	rm -rf *~ core csrc simv* vc_hdrs.h *.key *.log INCA_libs .simvision
