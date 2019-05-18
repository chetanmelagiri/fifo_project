class tb extends uvm_env;
	`uvm_component_utils(tb)

	env_config e_cfg;
	wr_agent_top wtop;
	rd_agent_top rtop;
	scoreboard sb;
	virtual_sequencer v_seqrh;
	
	extern function new ( string name="tb", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

//new
	function tb::new(string name = "tb", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void tb::build_phase(uvm_phase phase);
		if(!uvm_config_db #(env_config)::get(this, "","env_config",e_cfg))
			`uvm_fatal("CONFIG", "Cannot get() e_cfg  from uvm_config")
					
			super.build_phase(phase);

			if(e_cfg.has_wtop==1) 
				 wtop=wr_agent_top::type_id::create("wtop",this);

    		 if(e_cfg.has_rtop==1) 
			 	 rtop=rd_agent_top::type_id::create("rtop",this);
							
   		   if(e_cfg.has_virtual_sequencer)
	     		v_seqrh=virtual_sequencer::type_id::create("v_seqrh",this);

			 if(e_cfg.has_scoreboard) 
			 	 	begin
	         	sb=scoreboard::type_id::create("sb",this);
          end
	endfunction

		function void tb::connect_phase (uvm_phase phase);
			if(e_cfg.has_wtop==1) 
      	begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
						begin
							v_seqrh.wr_seqrh[i] = wtop.wagent[i].m_sequencer;
							wtop.wagent[i].monh.monitor_port.connect(sb.wfifo[i].analysis_export);
						end
				end
			
			if(e_cfg.has_rtop==1) 
         begin
						for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rtop.ragent[i].monh.monitor_port.connect(sb.rfifo[i].analysis_export);
								v_seqrh.rd_seqrh[i] = rtop.ragent[i].m_sequencer;
			 				end
				 end
  	endfunction


