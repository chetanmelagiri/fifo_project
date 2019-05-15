class vbase_seq extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(vbase_seq)

	wr_sequencer wr_seqrh[];
	rd_sequencer rd_seqrh[];

	virtual_sequencer vseqrh;

	wr_seq_1 wr_seq_1h;
	wr_seq_2 wr_seq_2h;
	wr_seq_3 wr_seq_3h;
	wr_seq_4 wr_seq_4h;
	wr_seq_5 wr_seq_5h;
	wr_seq_6 wr_seq_6h;
	wr_seq_7 wr_seq_7h;
	wr_seq_8 wr_seq_8h;
	wr_seq_9 wr_seq_9h;
	wr_seq_10 wr_seq_10h;
	wr_seq_11 wr_seq_11h;
	wr_seq_12 wr_seq_12h;
	wr_seq_13 wr_seq_13h;
	wr_seq_14 wr_seq_14h;
	wr_seq_15 wr_seq_15h;
	wr_seq_16 wr_seq_16h;
	wr_seq_17 wr_seq_17h;
	wr_seq_18 wr_seq_18h;
	wr_seq_19 wr_seq_19h;
	wr_seq_20 wr_seq_20h;
	wr_seq_21 wr_seq_21h;
	wr_seq_22 wr_seq_22h;
	wr_seq_23 wr_seq_23h;
	wr_seq_24 wr_seq_24h;
	wr_seq_25 wr_seq_25h;
	wr_seq_26 wr_seq_26h;
	wr_seq_27 wr_seq_27h;
	wr_seq_28 wr_seq_28h;
	wr_seq_29 wr_seq_29h;
	wr_seq_30 wr_seq_30h;
	wr_seq_31 wr_seq_31h;
	wr_seq_32 wr_seq_32h;
	wr_seq_33 wr_seq_33h;
	wr_seq_34 wr_seq_34h;
	wr_seq_35 wr_seq_35h;
	wr_seq_36 wr_seq_36h;
	wr_seq_37 wr_seq_37h;
	wr_seq_38 wr_seq_38h;
	wr_seq_39 wr_seq_39h;
	wr_seq_40 wr_seq_40h;
	wr_seq_41 wr_seq_41h;
	wr_seq_42 wr_seq_42h;
	wr_seq_43 wr_seq_43h;
	wr_seq_44 wr_seq_44h;
	wr_seq_45 wr_seq_45h;
	wr_seq_46 wr_seq_46h;
	wr_seq_47 wr_seq_47h;
	wr_seq_48 wr_seq_48h;


	
	

	rd_seq_1 rd_seq_1h;
/*	rd_seq_2 rd_seq_2h;
	rd_seq_3 rd_seq_3h;
	rd_seq_4 rd_seq_4h;
	rd_seq_5 rd_seq_5h;
	rd_seq_6 rd_seq_6h;
	rd_seq_7 rd_seq_7h;
	rd_seq_8 rd_seq_8h;
//	rd_seq_9 rd_seq_9h; */
	
	


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
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
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
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			
		join_any
	endtask

//------------------------------------------------> SEQ_2

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

//------------------------------------------------> SEQ_10

class vseq_10 extends vbase_seq;
		`uvm_object_utils(vseq_10)
			
			extern function new(string name="vseq_10");
			extern task body();
endclass


	function vseq_10::new(string name="vseq_10");
		super.new(name);
	endfunction


	task vseq_10::body();
		super.body();
		wr_seq_10h=wr_seq_10::type_id::create("wr_seq_10h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_10h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_11

class vseq_11 extends vbase_seq;
		`uvm_object_utils(vseq_11)
			
			extern function new(string name="vseq_11");
			extern task body();
endclass


	function vseq_11::new(string name="vseq_11");
		super.new(name);
	endfunction


	task vseq_11::body();
		super.body();
		wr_seq_11h=wr_seq_11::type_id::create("wr_seq_11h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_11h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_12

class vseq_12 extends vbase_seq;
		`uvm_object_utils(vseq_12)
			
			extern function new(string name="vseq_12");
			extern task body();
endclass


	function vseq_12::new(string name="vseq_12");
		super.new(name);
	endfunction


	task vseq_12::body();
		super.body();
		wr_seq_12h=wr_seq_12::type_id::create("wr_seq_12h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_12h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_13

class vseq_13 extends vbase_seq;
		`uvm_object_utils(vseq_13)
			
			extern function new(string name="vseq_13");
			extern task body();
endclass


	function vseq_13::new(string name="vseq_13");
		super.new(name);
	endfunction


	task vseq_13::body();
		super.body();
		wr_seq_13h=wr_seq_13::type_id::create("wr_seq_13h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_13h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_14

class vseq_14 extends vbase_seq;
		`uvm_object_utils(vseq_14)
			
			extern function new(string name="vseq_14");
			extern task body();
endclass


	function vseq_14::new(string name="vseq_14");
		super.new(name);
	endfunction


	task vseq_14::body();
		super.body();
		wr_seq_14h=wr_seq_14::type_id::create("wr_seq_14h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_14h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_15

class vseq_15 extends vbase_seq;
		`uvm_object_utils(vseq_15)
			
			extern function new(string name="vseq_15");
			extern task body();
endclass


	function vseq_15::new(string name="vseq_15");
		super.new(name);
	endfunction


	task vseq_15::body();
		super.body();
		wr_seq_15h=wr_seq_15::type_id::create("wr_seq_15h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_15h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_16

class vseq_16 extends vbase_seq;
		`uvm_object_utils(vseq_16)
			
			extern function new(string name="vseq_16");
			extern task body();
endclass


	function vseq_16::new(string name="vseq_16");
		super.new(name);
	endfunction


	task vseq_16::body();
		super.body();
		wr_seq_16h=wr_seq_16::type_id::create("wr_seq_16h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_16h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_17

class vseq_17 extends vbase_seq;
		`uvm_object_utils(vseq_17)
			
			extern function new(string name="vseq_17");
			extern task body();
endclass


	function vseq_17::new(string name="vseq_17");
		super.new(name);
	endfunction


	task vseq_17::body();
		super.body();
		wr_seq_17h=wr_seq_17::type_id::create("wr_seq_17h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_17h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_18

class vseq_18 extends vbase_seq;
		`uvm_object_utils(vseq_18)
			
			extern function new(string name="vseq_18");
			extern task body();
endclass


	function vseq_18::new(string name="vseq_18");
		super.new(name);
	endfunction


	task vseq_18::body();
		super.body();
		wr_seq_18h=wr_seq_18::type_id::create("wr_seq_18h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_18h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_19

class vseq_19 extends vbase_seq;
		`uvm_object_utils(vseq_19)
			
			extern function new(string name="vseq_19");
			extern task body();
endclass


	function vseq_19::new(string name="vseq_19");
		super.new(name);
	endfunction


	task vseq_19::body();
		super.body();
		wr_seq_19h=wr_seq_19::type_id::create("wr_seq_19h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_19h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_20

class vseq_20 extends vbase_seq;
		`uvm_object_utils(vseq_20)
			
			extern function new(string name="vseq_20");
			extern task body();
endclass


	function vseq_20::new(string name="vseq_20");
		super.new(name);
	endfunction


	task vseq_20::body();
		super.body();
		wr_seq_20h=wr_seq_20::type_id::create("wr_seq_20h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_20h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_21

class vseq_21 extends vbase_seq;
		`uvm_object_utils(vseq_21)
			
			extern function new(string name="vseq_21");
			extern task body();
endclass


	function vseq_21::new(string name="vseq_21");
		super.new(name);
	endfunction


	task vseq_21::body();
		super.body();
		wr_seq_21h=wr_seq_21::type_id::create("wr_seq_21h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_21h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_22

class vseq_22 extends vbase_seq;
		`uvm_object_utils(vseq_22)
			
			extern function new(string name="vseq_22");
			extern task body();
endclass


	function vseq_22::new(string name="vseq_22");
		super.new(name);
	endfunction


	task vseq_22::body();
		super.body();
		wr_seq_22h=wr_seq_22::type_id::create("wr_seq_22h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_22h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_23

class vseq_23 extends vbase_seq;
		`uvm_object_utils(vseq_23)
			
			extern function new(string name="vseq_23");
			extern task body();
endclass


	function vseq_23::new(string name="vseq_23");
		super.new(name);
	endfunction


	task vseq_23::body();
		super.body();
		wr_seq_23h=wr_seq_23::type_id::create("wr_seq_23h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_23h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_24

class vseq_24 extends vbase_seq;
		`uvm_object_utils(vseq_24)
			
			extern function new(string name="vseq_24");
			extern task body();
endclass


	function vseq_24::new(string name="vseq_24");
		super.new(name);
	endfunction


	task vseq_24::body();
		super.body();
		wr_seq_24h=wr_seq_24::type_id::create("wr_seq_24h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_24h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_25

class vseq_25 extends vbase_seq;
		`uvm_object_utils(vseq_25)
			
			extern function new(string name="vseq_25");
			extern task body();
endclass


	function vseq_25::new(string name="vseq_25");
		super.new(name);
	endfunction


	task vseq_25::body();
		super.body();
		wr_seq_25h=wr_seq_25::type_id::create("wr_seq_25h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_25h.start(wr_seqrh[i]);
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


//------------------------------------------------> SEQ_26

class vseq_26 extends vbase_seq;
		`uvm_object_utils(vseq_26)
			
			extern function new(string name="vseq_26");
			extern task body();
endclass


	function vseq_26::new(string name="vseq_26");
		super.new(name);
	endfunction


	task vseq_26::body();
		super.body();
		wr_seq_26h=wr_seq_26::type_id::create("wr_seq_26h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_26h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_27

class vseq_27 extends vbase_seq;
		`uvm_object_utils(vseq_27)
			
			extern function new(string name="vseq_27");
			extern task body();
endclass


	function vseq_27::new(string name="vseq_27");
		super.new(name);
	endfunction


	task vseq_27::body();
		super.body();
		wr_seq_27h=wr_seq_27::type_id::create("wr_seq_27h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_27h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_28

class vseq_28 extends vbase_seq;
		`uvm_object_utils(vseq_28)
			
			extern function new(string name="vseq_28");
			extern task body();
endclass


	function vseq_28::new(string name="vseq_28");
		super.new(name);
	endfunction


	task vseq_28::body();
		super.body();
		wr_seq_28h=wr_seq_28::type_id::create("wr_seq_28h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
		begin
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_28h.start(wr_seqrh[i]);
							end
				end
			end	
			begin
			if(e_cfg.has_ragent)
				begin
					for(int i=0; i<e_cfg.no_of_ragent; i++)
							begin
								rd_seq_1h.start(rd_seqrh[i]);
							end
				end
			end
		join_any
	endtask

//------------------------------------------------> SEQ_29

class vseq_29 extends vbase_seq;
		`uvm_object_utils(vseq_29)
			
			extern function new(string name="vseq_29");
			extern task body();
endclass


	function vseq_29::new(string name="vseq_29");
		super.new(name);
	endfunction


	task vseq_29::body();
		super.body();
		wr_seq_29h=wr_seq_29::type_id::create("wr_seq_29h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_29h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_30

class vseq_30 extends vbase_seq;
		`uvm_object_utils(vseq_30)
			
			extern function new(string name="vseq_30");
			extern task body();
endclass


	function vseq_30::new(string name="vseq_30");
		super.new(name);
	endfunction


	task vseq_30::body();
		super.body();
		wr_seq_30h=wr_seq_30::type_id::create("wr_seq_30h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_30h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_31

class vseq_31 extends vbase_seq;
		`uvm_object_utils(vseq_31)
			
			extern function new(string name="vseq_31");
			extern task body();
endclass


	function vseq_31::new(string name="vseq_31");
		super.new(name);
	endfunction


	task vseq_31::body();
		super.body();
		wr_seq_31h=wr_seq_31::type_id::create("wr_seq_31h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_31h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_32

class vseq_32 extends vbase_seq;
		`uvm_object_utils(vseq_32)
			
			extern function new(string name="vseq_32");
			extern task body();
endclass


	function vseq_32::new(string name="vseq_32");
		super.new(name);
	endfunction


	task vseq_32::body();
		super.body();
		wr_seq_32h=wr_seq_32::type_id::create("wr_seq_32h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_32h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_33

class vseq_33 extends vbase_seq;
		`uvm_object_utils(vseq_33)
			
			extern function new(string name="vseq_33");
			extern task body();
endclass


	function vseq_33::new(string name="vseq_33");
		super.new(name);
	endfunction


	task vseq_33::body();
		super.body();
		wr_seq_33h=wr_seq_33::type_id::create("wr_seq_33h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_33h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_34

class vseq_34 extends vbase_seq;
		`uvm_object_utils(vseq_34)
			
			extern function new(string name="vseq_34");
			extern task body();
endclass


	function vseq_34::new(string name="vseq_34");
		super.new(name);
	endfunction


	task vseq_34::body();
		super.body();
		wr_seq_34h=wr_seq_34::type_id::create("wr_seq_34h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_34h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_35

class vseq_35 extends vbase_seq;
		`uvm_object_utils(vseq_35)
			
			extern function new(string name="vseq_35");
			extern task body();
endclass


	function vseq_35::new(string name="vseq_35");
		super.new(name);
	endfunction


	task vseq_35::body();
		super.body();
		wr_seq_35h=wr_seq_35::type_id::create("wr_seq_35h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_35h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_36

class vseq_36 extends vbase_seq;
		`uvm_object_utils(vseq_36)
			
			extern function new(string name="vseq_36");
			extern task body();
endclass


	function vseq_36::new(string name="vseq_36");
		super.new(name);
	endfunction


	task vseq_36::body();
		super.body();
		wr_seq_36h=wr_seq_36::type_id::create("wr_seq_36h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_36h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_37

class vseq_37 extends vbase_seq;
		`uvm_object_utils(vseq_37)
			
			extern function new(string name="vseq_37");
			extern task body();
endclass


	function vseq_37::new(string name="vseq_37");
		super.new(name);
	endfunction


	task vseq_37::body();
		super.body();
		wr_seq_37h=wr_seq_37::type_id::create("wr_seq_37h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_37h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_38

class vseq_38 extends vbase_seq;
		`uvm_object_utils(vseq_38)
			
			extern function new(string name="vseq_38");
			extern task body();
endclass


	function vseq_38::new(string name="vseq_38");
		super.new(name);
	endfunction


	task vseq_38::body();
		super.body();
		wr_seq_38h=wr_seq_38::type_id::create("wr_seq_38h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_38h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_39

class vseq_39 extends vbase_seq;
		`uvm_object_utils(vseq_39)
			
			extern function new(string name="vseq_39");
			extern task body();
endclass


	function vseq_39::new(string name="vseq_39");
		super.new(name);
	endfunction


	task vseq_39::body();
		super.body();
		wr_seq_39h=wr_seq_39::type_id::create("wr_seq_39h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_39h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_40

class vseq_40 extends vbase_seq;
		`uvm_object_utils(vseq_40)
			
			extern function new(string name="vseq_40");
			extern task body();
endclass


	function vseq_40::new(string name="vseq_40");
		super.new(name);
	endfunction


	task vseq_40::body();
		super.body();
		wr_seq_40h=wr_seq_40::type_id::create("wr_seq_40h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_40h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_41

class vseq_41 extends vbase_seq;
		`uvm_object_utils(vseq_41)
			
			extern function new(string name="vseq_41");
			extern task body();
endclass


	function vseq_41::new(string name="vseq_41");
		super.new(name);
	endfunction


	task vseq_41::body();
		super.body();
		wr_seq_41h=wr_seq_41::type_id::create("wr_seq_41h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_41h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_42

class vseq_42 extends vbase_seq;
		`uvm_object_utils(vseq_42)
			
			extern function new(string name="vseq_42");
			extern task body();
endclass


	function vseq_42::new(string name="vseq_42");
		super.new(name);
	endfunction


	task vseq_42::body();
		super.body();
		wr_seq_42h=wr_seq_42::type_id::create("wr_seq_42h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_42h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_43

class vseq_43 extends vbase_seq;
		`uvm_object_utils(vseq_43)
			
			extern function new(string name="vseq_43");
			extern task body();
endclass


	function vseq_43::new(string name="vseq_43");
		super.new(name);
	endfunction


	task vseq_43::body();
		super.body();
		wr_seq_43h=wr_seq_43::type_id::create("wr_seq_43h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_43h.start(wr_seqrh[i]);
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


//------------------------------------------------> SEQ_44

class vseq_44 extends vbase_seq;
		`uvm_object_utils(vseq_44)
			
			extern function new(string name="vseq_44");
			extern task body();
endclass


	function vseq_44::new(string name="vseq_44");
		super.new(name);
	endfunction


	task vseq_44::body();
		super.body();
		wr_seq_44h=wr_seq_44::type_id::create("wr_seq_44h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_44h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_45

class vseq_45 extends vbase_seq;
		`uvm_object_utils(vseq_45)
			
			extern function new(string name="vseq_45");
			extern task body();
endclass


	function vseq_45::new(string name="vseq_45");
		super.new(name);
	endfunction


	task vseq_45::body();
		super.body();
		wr_seq_45h=wr_seq_45::type_id::create("wr_seq_45h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_45h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_46

class vseq_46 extends vbase_seq;
		`uvm_object_utils(vseq_46)
			
			extern function new(string name="vseq_46");
			extern task body();
endclass


	function vseq_46::new(string name="vseq_46");
		super.new(name);
	endfunction


	task vseq_46::body();
		super.body();
		wr_seq_46h=wr_seq_46::type_id::create("wr_seq_46h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_46h.start(wr_seqrh[i]);
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

//------------------------------------------------> SEQ_47

class vseq_47 extends vbase_seq;
		`uvm_object_utils(vseq_47)
			
			extern function new(string name="vseq_47");
			extern task body();
endclass


	function vseq_47::new(string name="vseq_47");
		super.new(name);
	endfunction


	task vseq_47::body();
		super.body();
		wr_seq_47h=wr_seq_47::type_id::create("wr_seq_47h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_47h.start(wr_seqrh[i]);
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


//------------------------------------------------> SEQ_48

class vseq_48 extends vbase_seq;
		`uvm_object_utils(vseq_48)
			
			extern function new(string name="vseq_48");
			extern task body();
endclass


	function vseq_48::new(string name="vseq_48");
		super.new(name);
	endfunction


	task vseq_48::body();
		super.body();
		wr_seq_48h=wr_seq_48::type_id::create("wr_seq_48h");
		rd_seq_1h=rd_seq_1::type_id::create("rd_seq_1h");
		
		fork
			if(e_cfg.has_wagent)
				begin
					for(int i=0; i<e_cfg.no_of_wagent; i++)
							begin
								wr_seq_48h.start(wr_seqrh[i]);
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


