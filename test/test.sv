class base_test extends uvm_test;
`uvm_component_utils(base_test)

	env envh;
	env_config e_cfg;
	wr_agent_config w_cfg[];
	rd_agent_config r_cfg[];

	int no_of_ragent = 1;
	int no_of_wagent=1;
	int has_ragent = 1;
	int has_wagent = 1;

	extern function new(string name = "base_test" , uvm_component parent);
	extern function void configuration();
	extern function void build_phase(uvm_phase phase);

endclass

//new
function base_test::new(string name = "base_test" , uvm_component parent);
	super.new(name,parent);
endfunction

//config
function void base_test::configuration();
	if (has_wagent) 
	begin
        	w_cfg = new[no_of_wagent];
	       	foreach(w_cfg[i]) 
		begin
        		w_cfg[i]=wr_agent_config::type_id::create($sformatf("w_cfg[%0d]", i));
			if(!uvm_config_db #(virtual bridge_if)::get(this,"", $sformatf("vif_%0d",i),w_cfg[i].vif))
			begin
				`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
              		end
			w_cfg[i].is_active = UVM_ACTIVE;
                	e_cfg.w_cfg[i] = w_cfg[i];
                end
	end
         
	if (has_ragent) 
	begin
        	r_cfg=new[no_of_ragent];
		foreach(r_cfg[i]) 
		begin
			r_cfg[i]=rd_agent_config::type_id::create($sformatf("r_cfg[%0d]",i));
			if(!uvm_config_db #(virtual bridge_if)::get(this,"",$sformatf("vif_%0d",i),r_cfg[i].vif))
			begin
				`uvm_fatal("VIF CONFIG","cannot get() interface vif from uvm_config_db. Have you set() it?")
			end
			r_cfg[i].is_active = UVM_ACTIVE;
			e_cfg.r_cfg[i]=r_cfg[i];
         
           	end
	end
						
        e_cfg.no_of_ragent = no_of_ragent;
        e_cfg.no_of_wagent = no_of_wagent;
									 
        e_cfg.has_ragent = has_ragent;
        e_cfg.has_wagent = has_wagent;
  endfunction 


//build
function void base_test::build_phase(uvm_phase phase);
	e_cfg=env_config::type_id::create("e_cfg");
               
	if(has_wagent)
       		e_cfg.w_cfg = new[no_of_wagent];
          
	if(has_ragent)
		e_cfg.r_cfg = new[no_of_ragent];
	
	configuration();
	uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);
    	super.build();
	envh=env::type_id::create("envh", this);
endfunction

