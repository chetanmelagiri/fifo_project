class rd_driver extends uvm_driver #(read_xtn);
		`uvm_component_utils(rd_driver)
		 virtual fifo_if.RDR_MP vif;
		 rd_agent_config r_cfg;

		 extern function new (string name="rd_driver", uvm_component parent);
		 extern function void build_phase(uvm_phase phase);
		 extern function void connect_phase(uvm_phase phase);
	//	 extern task run_phase(uvm_phase phase);
	//	 extern task send_to_dut(read_xtn xtn);
endclass

//new
	function rd_driver::new(string name = "rd_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void rd_driver::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(rd_agent_config)::get(this, "","rd_agent_config",r_cfg))
			`uvm_fatal("CONFIG","Cannot get() r_cfg from uvm_config_db. Have you set() it?")
	endfunction

//connect
	function void rd_driver::connect_phase(uvm_phase phase);
		vif = r_cfg.vif;
	endfunction
/*
//run
	task rd_driver::run_phase(uvm_phase phase);
			forever
				  begin
						seq_item_port.get_next_item(req);
								send_to_dut(req);
						seq_item_port.item_done();
					end
	endtask

//send_to_dut
	task rd_driver::send_to_dut(read_xtn xtn);
			
				@(vif.rdr_cb);
			
			

  	`uvm_info("RD_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW) 

		endtask

	*/
