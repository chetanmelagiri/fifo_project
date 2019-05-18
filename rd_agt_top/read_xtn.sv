
class read_xtn extends uvm_sequence_item;
	`uvm_object_utils(read_xtn)
	  
	     bit	[7:0] data_in;
	     logic 	write_enb;
	     logic 	read_enb;
	     bit 	[7:0] data_out;
	     logic	full;
	     logic 	empty;
	     logic	almost_empty;


		extern function new(string name = "read_xtn");
		extern function void do_print(uvm_printer printer);
endclass

//new
	function read_xtn::new(string name = "read_xtn");
		super.new(name);
	endfunction

//print
function void read_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
	printer.print_field("write_enb",	this.write_enb,		1,	UVM_DEC);
	printer.print_field("read_enb",		this.read_enb,		1,	UVM_DEC);
	printer.print_field("data_in",		this.data_in,		8,	UVM_HEX);
	printer.print_field("data_out",		this.data_out,		8,	UVM_HEX);
	printer.print_field("full",		this.full,		1,	UVM_DEC);
	printer.print_field("empty",		this.empty,		1,	UVM_DEC);
	printer.print_field("almost_empty",	this.almost_empty,	1,	UVM_DEC);
endfunction:do_print

    


		
