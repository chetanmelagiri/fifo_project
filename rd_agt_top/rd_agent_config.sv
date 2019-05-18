class rd_agent_config extends uvm_object;
	`uvm_object_utils(rd_agent_config)
	virtual fifo_if vif;
	uvm_active_passive_enum is_active=UVM_PASSIVE;  

	extern function new (string name = "rd_agent_config");

endclass

//new
	function rd_agent_config::new(string name = "rd_agent_config");
		super.new(name);
	endfunction
