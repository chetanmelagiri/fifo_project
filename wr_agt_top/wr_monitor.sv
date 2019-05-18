
class wr_monitor extends uvm_monitor;
	`uvm_component_utils(wr_monitor)
	virtual fifo_if.WMON_MP vif;
	wr_agent_config w_cfg;
	uvm_analysis_port #(write_xtn) monitor_port;

	extern function new(string name = "wr_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase (uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();

endclass

//new
	function wr_monitor :: new(string name ="wr_monitor",uvm_component parent);
		super.new(name, parent);
		monitor_port = new("monitor_port", this);
	endfunction

//build
	function void wr_monitor::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
		`uvm_fatal("CONFIG","Cannot get() w_cfg from uvm_config_db. Have you set() it?")
	endfunction

//connect
	function void wr_monitor::connect_phase(uvm_phase phase);
		 vif = w_cfg.vif;
	endfunction

//run
	task wr_monitor::run_phase(uvm_phase phase);
		forever
			begin
				collect_data();
			end 
	endtask

//collect
	task wr_monitor::collect_data();
		write_xtn data_sent;
		
		data_sent=write_xtn::type_id::create("data_sent");
		
	fork	
		begin
			data_sent.write_enb=vif.wmon_cb.write_enb;
			
			
			data_sent.data_in=vif.wmon_cb.data_in;
			
			data_sent.read_enb=vif.wmon_cb.read_enb;
		end
join
		
		monitor_port.write(data_sent);
    		`uvm_info("WR_MONITOR",$sformatf("printing from monitor \n %s", data_sent.sprint()),UVM_LOW)
		@(vif.wmon_cb);		
	endtask

