class wr_driver extends uvm_driver #(write_xtn);
		`uvm_component_utils(wr_driver)
		 virtual fifo_if.WDR_MP vif;
		 wr_agent_config w_cfg;

		 extern function new (string name="wr_driver", uvm_component parent);
		 extern function void build_phase(uvm_phase phase);
		 extern function void connect_phase(uvm_phase phase);
		 extern task run_phase(uvm_phase phase);
		 extern task send_to_dut(write_xtn xtn);

endclass

//new
	function wr_driver::new(string name = "wr_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void wr_driver::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
			`uvm_fatal("CONFIG","Cannot get() w_cfg from uvm_config_db. Have you set() it?")
	endfunction

//connect
	function void wr_driver::connect_phase(uvm_phase phase);
		vif = w_cfg.vif;
	endfunction

//run
	task wr_driver::run_phase(uvm_phase phase);
		vif.wdr_cb.resetn<=1'b0;
		repeat(2)
		@(vif.wdr_cb);
		vif.wdr_cb.resetn<=1'b1;
		@(vif.wdr_cb);
		
		
				forever
				  begin
						seq_item_port.get_next_item(req);
							send_to_dut(req);
						seq_item_port.item_done();
					end 
	endtask

//send
	task wr_driver::send_to_dut(write_xtn xtn);
	
			vif.wdr_cb.write_enb<=xtn.write_enb;
			vif.wdr_cb.data_in<=xtn.data_in;
			//@(vif.wdr_cb);
			//wait(~vif.wdr_cb.empty)
			vif.wdr_cb.read_enb<=xtn.read_enb;

			`uvm_info("WR_DRIVER",$sformatf("printing from wr_driver \n %s", xtn.sprint()),UVM_LOW) 
	 		@(vif.wdr_cb);	
		endtask

