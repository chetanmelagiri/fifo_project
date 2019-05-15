class rbase_seq extends uvm_sequence #(read_xtn);
	`uvm_object_utils(rbase_seq);

	extern function new(string name="rbase_seq");

endclass

//new function
function rbase_seq ::new(string name="rbase_seq");
	super.new(name);
endfunction

