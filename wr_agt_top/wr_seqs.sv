class wbase_seq extends uvm_sequence #(write_xtn);
	`uvm_object_utils(wbase_seq)

	extern function new(string name="wbase_seq");
endclass

//new
	function wbase_seq::new(string name="wbase_seq");
		super.new(name);
	endfunction

//Hsize is 8_bit
//
class wr_seq_1 extends wbase_seq;
		`uvm_object_utils(wr_seq_1)
		
		extern function new(string name="wr_seq_1 ");
		extern task body;
endclass

	function wr_seq_1 ::new( string name="wr_seq_1 ");
		super.new(name);
	endfunction

	task wr_seq_1 ::body();
	
		repeat(10)
		begin
			req=write_xtn::type_id::create("req");
				begin
					start_item(req);
					assert(req.randomize() with { write_enb==1;read_enb==0;read_enb!=write_enb;});
			 		finish_item(req);
		 		end
	 	end
	 	
	 	repeat(8)
	 	begin
				begin
					start_item(req);
					assert(req.randomize() with { write_enb==0;read_enb==1;});
			 		finish_item(req);
		 		end
				

	 	end
	endtask





	 		
				
