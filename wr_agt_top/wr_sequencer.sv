class wr_sequencer extends uvm_sequencer #(write_xtn);
	`uvm_component_utils(wr_sequencer)

	extern function new(string name="wr_sequencer", uvm_component parent);
endclass

//new
	function wr_sequencer::new(string name = "wr_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction

	
