class rbase_seq extends uvm_sequence #(read_xtn);
	`uvm_object_utils(rbase_seq)

	extern function new(string name="rbase_seq");
endclass

//new
	function rbase_seq::new(string name="rbase_seq");
		super.new(name);
	endfunction

//s_1
class rd_seq_1 extends rbase_seq;
		`uvm_object_utils(rd_seq_1)

		extern function new(string name="rd_seq_1");
		extern task body;
endclass

	function rd_seq_1::new( string name="rd_seq_1");
		super.new(name);
	endfunction

	task rd_seq_1::body();
		begin
			req=read_xtn::type_id::create("req");
			repeat(4)
			begin
				start_item(req);
				assert(req.randomize()  );
		 		finish_item(req);
		 end
	 end
	endtask
			

