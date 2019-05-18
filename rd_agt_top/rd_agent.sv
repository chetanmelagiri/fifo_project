class rd_agent extends uvm_agent;
	`uvm_component_utils(rd_agent)
		
	rd_agent_config r_cfg;
	rd_driver drvh;
	rd_monitor monh;
	rd_sequencer m_sequencer;

	extern function new(string name="rd_agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase (uvm_phase phase);
endclass

//new
	function rd_agent::new(string name="rd_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void rd_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",r_cfg))
			`uvm_fatal("CONFIG", "cannot get() r_cfg from uvm_config_db. Have you set it?")
				monh=rd_monitor::type_id::create("monh", this);
				if(r_cfg.is_active==UVM_ACTIVE)
					begin
						$display("r_cfg=%s",r_cfg.is_active.name);
						drvh=rd_driver::type_id::create("drvh", this);
						m_sequencer=rd_sequencer::type_id::create("m_sequencer", this);
					end
		endfunction

//connect
	function void rd_agent::connect_phase(uvm_phase phase);
		if(r_cfg.is_active==UVM_ACTIVE)
			drvh.seq_item_port.connect(m_sequencer.seq_item_export);
	endfunction
