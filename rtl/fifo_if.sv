interface fifo_if(input bit clock);
	logic resetn;
	logic write_enb;
	logic read_enb;
	logic [7:0] data_in;
	
	logic [7:0] data_out;
	logic full;
	logic empty;
	logic almost_empty;

clocking wdr_cb@(posedge clock);
	default input #1 output #1;
	output resetn;
	output write_enb;
	output read_enb;
	output data_in;
	input full;
	input empty;
	input almost_empty;
	
endclocking

clocking rdr_cb@(posedge clock);
	default input #1 output #1;
	
	output write_enb;
	output read_enb;
	output data_in;
	input full;
	input empty;
	input almost_empty;


	endclocking

clocking wmon_cb@(posedge clock);
	default input #1 output #1;
	input resetn;
	input write_enb;
	input read_enb;
	input data_in;
	
endclocking

clocking rmon_cb@(posedge clock);
	default input #1 output #1;
	
	input write_enb;
	input read_enb;
	input data_in;
	input data_out;
	input full;
	input empty;
	input almost_empty;
endclocking

modport WDR_MP(clocking wdr_cb);
modport RDR_MP(clocking rdr_cb);
modport WMON_MP(clocking wmon_cb);
modport RMON_MP(clocking rmon_cb);

endinterface
