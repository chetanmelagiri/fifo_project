class vbase_seq extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(vbase_seq)

	wr_sequencer wr_seqrh[];
	rd_sequencer rd_seqrh[];

	virtual_sequencer vseqrh;

	wr_seq_1 wr_seq_1h;
	
	

//	rd_seq_1 rd_seq_1h;

	


	env_config e_cfg;

	extern function new(string name="vbase_seq");
	extern task body();
endclass

//name
	function vbase_seq::new(string name="vbase_seq");
		super.new(name);
	endfunction

//body
	task vbase_seq::body();
	
		if(!uvm_config_db #(env_config)::get(null,get_full_name,"env_config",e_cfg))
			`uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?")
	
			wr_seqrh=new[e_cfg.no_of_wagent];
			rd_seqrh=new[e_cfg.no_of_ragent];
			assert($cast(vseqrh,m_sequencer)) 

		else 
				begin
  	  		`uvm_error("BODY", "Error in $cast of virtual sequencer")
				end
	
		foreach(wr_seqrh[i])
			 begin
 				 wr_seqrh[i] = vseqrh.wr_seqrh[i];
				//wr_seqrh[i].start(wr_seqrh[i]);
			 end
 			
		foreach(rd_seqrh[i])
	 			begin
  	 			rd_seqrh[i] = vseqrh.rd_seqrh[i];
				end

	endtask: body


//------------------------------------------------> SEQ_1
class vseq_1 extends vbase_seq;
		`uvm_object_utils(vseq_1)
			
			extern function new(string name="vseq_1");
			extern task body();
endclass

	function vseq_1::new(string name="vseq_1");
		super.new(name);
	endfunction


	task vseq_1::body();
		super.body();
		wr_seq_1h=wr_seq_1::type_id::create("wr_seq_1h");
		//rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_1h.start(wr_seqrh[i]);
							end
				end
			

			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								//rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			
		join_any
	endtask

/*/------------------------------------------------> SEQ_2

class vseq_2 extends vbase_seq;
		`uvm_object_utils(vseq_2)
			
			extern function new(string name="vseq_2");
			extern task body();
endclass


		function vseq_2::new(string name="vseq_2");
		super.new(name);
	endfunction


	task vseq_2::body();
		super.body();
		wr_seq_2h=wr_seq_2::type_id::create("wr_seq_2h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_2h.start(wr_seqrh[i]);
							end
				end
			
		if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			
		join_any
	endtask

//------------------------------------------------> SEQ_3

class vseq_3 extends vbase_seq;
		`uvm_object_utils(vseq_3)
			
			extern function new(string name="vseq_3");
			extern task body();
endclass


	function vseq_3::new(string name="vseq_3");
		super.new(name);
	endfunction


	task vseq_3::body();
		super.body();
		wr_seq_3h=wr_seq_3::type_id::create("wr_seq_3h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");

		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_3h.start(wr_seqrh[i]);
							end
				end
			
			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
		join_any
		
	endtask

//------------------------------------------------> SEQ_4

class vseq_4 extends vbase_seq;
		`uvm_object_utils(vseq_4)
			
			extern function new(string name="vseq_4");
			extern task body();
endclass


	function vseq_4::new(string name="vseq_4");
		super.new(name);
	endfunction


	task vseq_4::body();
		super.body();
		wr_seq_4h=wr_seq_4::type_id::create("wr_seq_4h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");

		
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_4h.start(wr_seqrh[i]);
							end
				end
			
				
			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			
		join_any
	endtask

//------------------------------------------------> SEQ_5

class vseq_5 extends vbase_seq;
		`uvm_object_utils(vseq_5)
			
			extern function new(string name="vseq_5");
			extern task body();
endclass


	function vseq_5::new(string name="vseq_5");
		super.new(name);
	endfunction


	task vseq_5::body();
		super.body();
		wr_seq_5h=wr_seq_5::type_id::create("wr_seq_5h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_5h.start(wr_seqrh[i]);
							end
				end
			
			
			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			
		join_any
	endtask

//------------------------------------------------> SEQ_6

class vseq_6 extends vbase_seq;
		`uvm_object_utils(vseq_6)
			
			extern function new(string name="vseq_6");
			extern task body();
endclass


	function vseq_6::new(string name="vseq_6");
		super.new(name);
	endfunction


	task vseq_6::body();
		super.body();
		wr_seq_6h=wr_seq_6::type_id::create("wr_seq_6h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_6h.start(wr_seqrh[i]);
							end
				end
			
				
			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			
		join_any
	endtask

//------------------------------------------------> SEQ_7

class vseq_7 extends vbase_seq;
		`uvm_object_utils(vseq_7)
			
			extern function new(string name="vseq_7");
			extern task body();
endclass


	function vseq_7::new(string name="vseq_7");
		super.new(name);
	endfunction


	task vseq_7::body();
		super.body();
		wr_seq_7h=wr_seq_7::type_id::create("wr_seq_7h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_7h.start(wr_seqrh[i]);
							end
				end
			
				
			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end

			
		join_any
	endtask

//------------------------------------------------> SEQ_8

class vseq_8 extends vbase_seq;
		`uvm_object_utils(vseq_8)
			
			extern function new(string name="vseq_8");
			extern task body();
endclass


	function vseq_8::new(string name="vseq_8");
		super.new(name);
	endfunction


	task vseq_8::body();
		super.body();
		wr_seq_8h=wr_seq_8::type_id::create("wr_seq_8h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_8h.start(wr_seqrh[i]);
							end
				end
				
			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			
		join_any
	endtask

//------------------------------------------------> SEQ_9

class vseq_9 extends vbase_seq;
		`uvm_object_utils(vseq_9)
			
			extern function new(string name="vseq_9");
			extern task body();
endclass


	function vseq_9::new(string name="vseq_9");
		super.new(name);
	endfunction


	task vseq_9::body();
		super.body();
		wr_seq_9h=wr_seq_9::type_id::create("wr_seq_9h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_9h.start(wr_seqrh[i]);
							end
				end
				
			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			
		join_any
	endtask

*/
