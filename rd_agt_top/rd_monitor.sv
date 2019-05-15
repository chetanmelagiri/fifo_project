class wr_monitor extends uvm_monitor;
	`uvm_component_utils(wr_monitor)
	virtual fifo_if.WMON_MP vif;
	wr_agent_config w_cfg;
	uvm_analysis_port #(write_xtn) monitor_port;

	extern function new(string name = "wr_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();

endclass


//new
function wr_monitor::new(string name="wr_monitor", uvm_component parent);
	super.new(name, parent);
	monitor_port=new("monitor_port", this);
endfunction:new

//build_phase
function wr_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
	begin
		`uvm_fatal("CONFIG","Cannot get() w_cfg from uvm_config_db.Have you set it?")
	end
endfunction:build_phase

//connect phase
function wr_monitor::connect_phase(uvm_phase phase);
	vif=w_cfg.vif;
endfunction

//run task
task wr_monitor::run_phase(uvm_phase phase);
	//logic need to be updated
endtask:run_phase

//collect data task
task wr_monitor::collect_data();
	//logic need to be updated
endtask:collect_data



