class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(virtual_sequencer)
	
	wr_sequencer wr_seqrh[];
	rd_sequencer rd_seqrh[];

	env_config e_cfg;


	extern function new(string name = "virtual_sequencer", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

//new
	function virtual_sequencer::new(string name= "virtual_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void virtual_sequencer::build_phase(uvm_phase phase);
			super.build_phase(phase);
	
		if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
			`uvm_fatal("CONFIG","Cannot get() e_cfg from uvm_congig_db. Have you set it?")
			wr_seqrh=new[e_cfg.no_of_wagent];
			rd_seqrh=new[e_cfg.no_of_ragent];
	endfunction
