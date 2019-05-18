class wr_agent_top extends uvm_env;
	`uvm_component_utils(wr_agent_top)
	
	wr_agent wagent[];
	env_config e_cfg;

	extern function new(string name= "wr_agent_top", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

//new
	function wr_agent_top::new(string name= "wr_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void wr_agent_top::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config", e_cfg))
		`uvm_fatal("CONFIG_ENV","cannot get() env_config from uvm_config_db. Have you set() it?")
			wagent=new[e_cfg.no_of_wagent];
			foreach(wagent[i])
				begin
					uvm_config_db #(wr_agent_config)::set(this,$sformatf("wagent[%0d]*",i),"wr_agent_config",e_cfg.w_cfg[i]);
					wagent[i]=wr_agent::type_id::create($sformatf("wagent[%0d]",i), this);

				end
		super.build_phase(phase);
				
	endfunction

//run
	task wr_agent_top::run_phase(uvm_phase phase);
		uvm_top.print_topology;
	endtask   


	
	
		
