module fifo(clock, resetn,write_enb,read_enb,full,empty,data_in, data_out);
	parameter WIDTH=8;
	parameter DEPTH=16;
	parameter PT_WIDTH=$clog2(DEPTH) ;
	input clock,resetn, write_enb, read_enb;
	input [(WIDTH-1):0]data_in;
	output  full, empty;
	output reg [(WIDTH-1):0]data_out;
	integer i;
	
	reg [PT_WIDTH:0]wr_ptr,rd_ptr;

	reg [(WIDTH-1):0]mem[(DEPTH-1):0];

	//Full is asserted high when all the locations are written and no more
	//place to write.
	//Empty is asserted high when all the locations are empty.
	assign full = ({~wr_ptr[PT_WIDTH], wr_ptr[(PT_WIDTH-1):0]}==rd_ptr[(PT_WIDTH)-1:0]) ? 1:0;
	assign empty = (wr_ptr==rd_ptr) ? 1:0;

	always@(posedge clock)begin
		if(~resetn)begin
			for(i=0; i<DEPTH; i=i+1)begin
				mem[i]<=0;
			end
		end
		else if (write_enb && ~full)begin
			mem[wr_ptr[(PT_WIDTH-1):0]] <= data_in;
		end
        	else if(full)begin
            	$display("ERROR:FIFO IS FULL; CAN'T WRITE");
        	end
	end

	//	address generator
	always@(posedge clock)begin
		if(~resetn )begin
			wr_ptr<=0;
			rd_ptr<=0;
		end
		else begin
			if(write_enb && ~full)begin
				wr_ptr <= wr_ptr+1;
			end	

			if(read_enb && ~empty )begin
				 rd_ptr <= rd_ptr+1;
			end
		end
	end
	
    //Read logic
    //Data is read when read_enb is asserted high and empty is asserted low.
	always@(posedge clock)begin	
		if(~resetn)begin
			data_out <= DEPTH'b0;
		end					
		else if (read_enb && ~empty)begin
			data_out <= mem[rd_ptr[(PT_WIDTH-1):0]];
		end
		else if(empty) begin
            		$display("ERROR:FIFO IS EMPTY; NOTHING TO READ");
			data_out<= 'hz;
		end
	end
			


endmodule
