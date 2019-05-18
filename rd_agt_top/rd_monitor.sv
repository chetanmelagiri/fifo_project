
class rd_monitor extends uvm_monitor;
	`uvm_component_utils(rd_monitor)
	virtual fifo_if.RMON_MP vif;
	rd_agent_config r_cfg;
	uvm_analysis_port #(read_xtn) monitor_port;

	extern function new(string name = "rd_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase (uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data;
endclass

//new
	function rd_monitor :: new(string name ="rd_monitor",uvm_component parent);
		super.new(name, parent);
		monitor_port = new("monitor_port", this);
	endfunction

//build
	function void rd_monitor::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",r_cfg))
		`uvm_fatal("CONFIG","Cannot get() r_cfg from uvm_config_db. Have you set() it?")
	endfunction

//connect
	function void rd_monitor::connect_phase(uvm_phase phase);
		vif = r_cfg.vif;
	endfunction

//run
	task rd_monitor::run_phase(uvm_phase phase);
		forever
		begin
			collect_data();
		end 
	endtask

//collect
	task rd_monitor::collect_data;
	
		read_xtn data_sent;
		data_sent = read_xtn::type_id::create("data_sent");
		begin
			@(vif.rmon_cb);	
				begin
				
				data_sent.read_enb=vif.rmon_cb.read_enb;
				data_sent.full=vif.rmon_cb.full;
				data_sent.empty=vif.rmon_cb.empty;
				data_sent.data_out=vif.rmon_cb.data_out;
				
				end
		
		
		
		
		monitor_port.write(data_sent);
   		 `uvm_info("RD_MONITOR",$sformatf("printing from rd monitor \n %s", data_sent.sprint()),UVM_LOW)
		end	
 	endtask


