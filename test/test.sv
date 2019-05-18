	class base_test extends uvm_test;

	`uvm_component_utils(base_test)

    	 tb envh;
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
							   if(!uvm_config_db #(virtual fifo_if)::get(this,"", $sformatf("vif_%0d",i),w_cfg[i].vif))
										`uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?") 
              
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
								if(!uvm_config_db #(virtual fifo_if)::get(this,"",$sformatf("vif_%0d",i),r_cfg[i].vif))
									`uvm_fatal("VIF CONFIG","cannot get() interface vif from uvm_config_db. Have you set() it?")
										r_cfg[i].is_active = UVM_PASSIVE;
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
		envh=tb::type_id::create("envh", this);
	endfunction

	//-----------------TEST_1--------------------

class seq_1_test extends base_test;
		`uvm_component_utils(seq_1_test)
	
		vseq_1 vseq_1h;

		extern function new(string name="seq_1_test", uvm_component parent);
		extern function void build_phase(uvm_phase phase);
		extern task run_phase(uvm_phase phase);

endclass

//new
	function seq_1_test::new(string name="seq_1_test", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void seq_1_test:: build_phase(uvm_phase phase);
		  super.build_phase(phase);
	endfunction

//run
 	task seq_1_test::run_phase(uvm_phase phase);
      phase.raise_objection(this);
      			
			vseq_1h=vseq_1::type_id::create("vseq_1h");
			vseq_1h.start(envh.v_seqrh);
			#500;
      phase.drop_objection(this);
	endtask   

/*	//-----------------TEST_2--------------------

class seq_2_test extends base_test;
		`uvm_component_utils(seq_2_test)
	
		vseq_2 vseq_2h;

		extern function new(string name="seq_2_test", uvm_component parent);
		extern function void build_phase(uvm_phase phase);
		extern task run_phase(uvm_phase phase);

endclass

//new
	function seq_2_test::new(string name="seq_2_test", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void seq_2_test:: build_phase(uvm_phase phase);
		  super.build_phase(phase);
	endfunction

//run
 	task seq_2_test::run_phase(uvm_phase phase);
      phase.raise_objection(this);
			vseq_2h=vseq_2::type_id::create("vseq_2h");
			vseq_2h.start(envh.v_seqrh);
			#200;
      phase.drop_objection(this);
	endtask   

	//-----------------TEST_3--------------------

class seq_3_test extends base_test;
		`uvm_component_utils(seq_3_test)
	
		vseq_3 vseq_3h;

		extern function new(string name="seq_3_test", uvm_component parent);
		extern function void build_phase(uvm_phase phase);
		extern task run_phase(uvm_phase phase);

endclass

//new
	function seq_3_test::new(string name="seq_3_test", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void seq_3_test:: build_phase(uvm_phase phase);
		  super.build_phase(phase);
	endfunction

//run
 	task seq_3_test::run_phase(uvm_phase phase);
      phase.raise_objection(this);
			vseq_3h=vseq_3::type_id::create("vseq_3h");
			vseq_3h.start(envh.v_seqrh);
			#200;
      phase.drop_objection(this);
	endtask   

	//-----------------TEST_4--------------------

class seq_4_test extends base_test;
		`uvm_component_utils(seq_4_test)
	
		vseq_4 vseq_4h;

		extern function new(string name="seq_4_test", uvm_component parent);
		extern function void build_phase(uvm_phase phase);
		extern task run_phase(uvm_phase phase);

endclass

//new
	function seq_4_test::new(string name="seq_4_test", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void seq_4_test:: build_phase(uvm_phase phase);
		  super.build_phase(phase);
	endfunction

//run
 	task seq_4_test::run_phase(uvm_phase phase);
      phase.raise_objection(this);
			vseq_4h=vseq_4::type_id::create("vseq_4h");
			vseq_4h.start(envh.v_seqrh);
			#200;
      phase.drop_objection(this);
	endtask   

		//-----------------TEST_5--------------------

class seq_5_test extends base_test;
		`uvm_component_utils(seq_5_test)
	
		vseq_5 vseq_5h;

		extern function new(string name="seq_5_test", uvm_component parent);
		extern function void build_phase(uvm_phase phase);
		extern task run_phase(uvm_phase phase);

endclass

//new
	function seq_5_test::new(string name="seq_5_test", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void seq_5_test:: build_phase(uvm_phase phase);
		  super.build_phase(phase);
	endfunction

//run
 	task seq_5_test::run_phase(uvm_phase phase);
      phase.raise_objection(this);
			vseq_5h=vseq_5::type_id::create("vseq_5h");
			vseq_5h.start(envh.v_seqrh);
			#300;
      phase.drop_objection(this);
	endtask   

*/
