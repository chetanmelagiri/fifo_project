class rd_driver extends uvm_driver #(read_xtn);
       `uvm_component_utils(rd_driver)
	virtual fifo_if.WDR_MP vif;
 	rd_agent_config r_cfg;

	extern function new(string name="rd_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(read_xtn xtn);

endclass

//new function
function rd_driver::new(string name="rd_driver", uvm_component parent);
	super.new(name, parent);
endfunction:name 

//build
function void rd_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",r_cfg))
	begin
		`uvm_fatal("CONFIG","Cannot get() r_cfg fron uvm_config_db. have you set it?")
	end
endfunction:build_phase 

//connect 
function void rd_driver::connect_phase(uvm_phase phase);
	vif = r_cfg.vif;
endfunction:connect_phase

//run
task rd_driver::run_phase(uvm_phase phase);
	//driver logic need to be rditten
endtask:run_phase

//send to DUT task
task rd_driver::send_to_dut(read_xtn xtn);
	//logic need to be updated
endtask:send_to_dut

