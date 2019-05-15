class wr_agent extends uvm_agent;
	`uvm_component_utils(wr_agent)

	wr_agent_config w_cfg;
	wr_driver drvh;
	wr_monitor monh;
	wr_sequencer m_sequencer;

	extern function new(string name="wr_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

//new function
function wr_agent::new(string name="wr_agent", uvm_component parent);
	super.new(name, parent);
endfunction

//build phase
function void wr_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
	begin
		`uvm_fatal("CONFIG","Cannot get() w_cfg from uvm_config_db. Have you set it?")
	end
	monh=wr_monitor::type_id::create("monh",this);
	if(w_cfg.is_active==UVM_ACTIVE)
	begin
		drvh=wr_driver::type_id::create("drvh",this);
		m_sequencer=wr_sequencer::type_id::create("m_sequencer",this);
	end
endfunction

//connect phase
function void wr_agent::connect_phase(uvm_phase phase);
	if(w_cfg.is_active==UVM_ACTIVE)
	begin
		drvh.seq_item_port.connect(m_sequencer.seq_item_export);
	end
endfunction
