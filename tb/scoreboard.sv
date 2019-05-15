class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)

	extern function new(string name="scoreboard", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass

//new 
function scoreboard::new(string name="scoreboard", uvm_component parent);
	super.new(name, parent);

endfunction

//build
function void scoreboard::build_phase(uvm_phase phase);
	super.build_phase(uvm_phase phase);

endfunction
