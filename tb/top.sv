module top;
    import test_pkg::*;
		import uvm_pkg::*;

		bit clock;  
		always 
			 begin
				#10 clock=~clock;     
  		 end
	 
   	fifo_if   in0(clock);
	  
	fifo  dut(
                .clock(clock),
                .resetn(in0.resetn),
                .write_enb(in0.write_enb),
                .read_enb(in0.read_enb),
                .full(in0.full),
                .almost_empty(in0.almost_empty),
                .empty(in0.empty),
                .data_in(in0.data_in), 
                .data_out(in0.data_out));
	

       	initial begin
					uvm_config_db #(virtual fifo_if)::set(null,"*","vif_0",in0);
        

	run_test("seq_1_test");
     end
 

   
endmodule


  
   
  
