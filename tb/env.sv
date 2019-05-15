class env extends uvm_env;
	`uvm_component_utils(env)

	env_config e_cfg;
	wr_agent_top wtop;
	rd_agent_top rtop;
	scoreboard sb;
	virtual_sequencer v_seqrh;

	extern function new(string name="env", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass

//new
function env::new(string name="env", uvm_component parent);
	super.new(name,parent);
endfunction:new

//build phase
function void env::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
	begin
		`uvm_fatal("CONFIG", "Cannot get() e_cfg from uvm_config")
	end
	super.build_phase(phase);

	if(e_cfg.has_wtop==1) 
		 wtop=wr_agent_top::type_id::create("wtop",this);

	if(e_cfg.has_rtop==1) 
	 	 rtop=rd_agent_top::type_id::create("rtop",this);
							
	if(e_cfg.has_virtual_sequencer)
		v_seqrh=virtual_sequencer::type_id::create("v_seqrh",this);

	if(e_cfg.has_scoreboard) 
	       	sb=scoreboard::type_id::create("sb",this);
        
endfunction

//connect phase
function void env::connect_phase(uvm_phase phase);
	//logic need to be updated
endfunction
