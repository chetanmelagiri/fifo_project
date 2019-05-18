class wr_agent_config extends uvm_object;
	`uvm_object_utils(wr_agent_config)
	virtual fifo_if vif;

	uvm_active_passive_enum is_active ;  

	extern function new (string name = "wr_agent_config");

	endclass

	function wr_agent_config::new(string name = "wr_agent_config");
		super.new(name);
	endfunction
