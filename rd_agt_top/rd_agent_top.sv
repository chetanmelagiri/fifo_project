class rd_agent_top extends uvm_env;
	`uvm_component_utils(rd_agent_top)
	
	rd_agent ragent[];
	env_config e_cfg;

	extern function new(string name ="rd_agent_top", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

//new
	function rd_agent_top::new(string name= "rd_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void rd_agent_top::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config", e_cfg))
		`uvm_fatal("CONFIG_ENV","cannot get() env_config from uvm_config_db. Have you set() it?")
			ragent=new[e_cfg.no_of_ragent];
			foreach(ragent[i])
				begin
					uvm_config_db #(rd_agent_config)::set(this,$sformatf("ragent[%0d]*",i),"rd_agent_config",e_cfg.r_cfg[i]);
					ragent[i]=rd_agent::type_id::create($sformatf("ragent[%0d]",i), this);
				end
		super.build_phase(phase);
				
	endfunction

	
	
		
