
class write_xtn extends uvm_sequence_item;
	`uvm_object_utils(write_xtn)
	
    rand bit	[7:0] data_in;
	rand logic 	write_enb;
	rand logic 	read_enb;
	     bit 	[7:0] data_out;
	     logic	full;
	     logic 	empty;
	     logic	almost_empty;
		
        /*
		constraint a{ haddr inside {	[32'h8000_0000:32'h8C00_0000] } ;}
		constraint b{	if (hsize==2'b00) {length<=1024};
								
									if (hsize==2'b01) {length<=512};					
								
									if (hsize==2'b10) {length<=256};} */

		extern function new(string name = "write_xtn");
		extern function void do_print(uvm_printer printer);
	
		
endclass

//new
	function write_xtn::new(string name="write_xtn");
		super.new(name);
	endfunction



//print

	function void write_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
	printer.print_field("write_enb",	this.write_enb,		1,	UVM_DEC);
	printer.print_field("read_enb",		this.read_enb,		1,	UVM_DEC);
	printer.print_field("data_in",		this.data_in,		8,	UVM_HEX);
	printer.print_field("data_out",		this.data_out,		8,	UVM_HEX);
	printer.print_field("full",		this.full,		1,	UVM_DEC);
	printer.print_field("empty",		this.empty,		1,	UVM_DEC);
	printer.print_field("almost_empty",	this.almost_empty,	1,	UVM_DEC);
endfunction:do_print

   
    

  

