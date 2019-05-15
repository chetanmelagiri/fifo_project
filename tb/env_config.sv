class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	bit has_scoreboard = 1;
	bit has_wagent = 1;
	bit has_ragent = 1;
	bit has_wtop = 1;
	bit has_rtop = 1;

	bit has_virtual_sequencer = 1;
	wr_agent_config w_cfg[];
	rd_agent_config r_cfg[];

	int no_of_wagent=1;
	int no_of_ragent=1;
	int no_of_wtop=1;
	int no_of_rtop=1;
	int no_of_sb=1;
	
	extern function new(string name = "env_config");

endclass: env_config

function env_config::new(string name = "env_config");
  super.new(name);
endfunction
