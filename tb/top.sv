module top;
    import test_pkg::*;
	import uvm_pkg::*;
    bit clock;

    always 
    begin
    	#10 clock=~clock;     
    end
	 
   	fifo_if   in0(clock);
	
    initial begin
    	uvm_config_db #(virtual bridge_if)::set(null,"*","vif_0",in0);
        

	run_test();
     end
 

   
endmodule


  
   
  
