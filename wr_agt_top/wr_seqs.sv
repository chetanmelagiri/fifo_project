class wbase_seq extends uvm_sequence #(write_xtn);
	`uvm_object_utils(wbase_seq);

	extern function new(string name="wbase_seq");

endclass

//new function
function wbase_seq ::new(string name="wbase_seq");
	super.new(name);
endfunction

