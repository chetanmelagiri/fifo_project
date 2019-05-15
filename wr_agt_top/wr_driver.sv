class wr_driver extends uvm_driver #(write_xtn);
       `uvm_component_utils(wr_driver)
	virtual fifo_if.WDR_MP vif;
 	wr_agent_config w_cfg;

	extern function new(string name="wr_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(write_xtn xtn);

endclass

//new function
function wr_driver::new(string name="wr_driver", uvm_component parent);
	super.new(name, parent);
endfunction:name 

//build
function void wr_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
	begin
		`uvm_fatal("CONFIG","Cannot get() w_cfg fron uvm_config_db. have you set it?")
	end
endfunction:build_phase 

//connect 
function void wr_driver::connect_phase(uvm_phase phase);
	vif = w_cfg.vif;
endfunction:connect_phase

//run
task wr_driver::run_phase(uvm_phase phase);
	//driver logic need to be written
endtask:run_phase

//send to DUT task
task wr_driver::send_to_dut(write_xtn xtn);
	//logic need to be updated
endtask:send_to_dut

