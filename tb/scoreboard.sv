class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	uvm_tlm_analysis_fifo #(read_xtn) rfifo[];
	uvm_tlm_analysis_fifo #(write_xtn) wfifo[];
	env_config e_cfg;
	bit [7:0] rk;
	bit [7:0] wk;
	write_xtn wr_data;
	read_xtn rd_data;
	logic [7:0] wq[$];
	logic [7:0] rq[$];
/*	
	read_xtn read_cov_data;
	write_xtn write_cov_data;

	
	
	


	covergroup fcov1;
		option.per_instance=1;
         
        HSIZE : coverpoint write_cov_data.hsize{
					 		bins low = {'b00};
                     bins mid = {'b10};
                     bins high = {'b11};

								}

		      	     	     
     
        HADDRESS : coverpoint write_cov_data.haddr {
									 bins mid1 = {['h80000000:'h87ffffff]};
		   							 bins mid2 = {['h88000000:'h85ffffff]};
		   							 bins mid3 = {['h84000000:'h8c000000]};
        							 }
			 HWDATA : coverpoint write_cov_data.hwdata {
									 bins mid1 = {['h80000000:'h83ffffff]};
		   							 bins mid2 = {['h84000000:'h87ffffff]};
		   							 bins mid3 = {['h88000000:'h8bffffff]};
		   							 bins mid4 = {['h8c000000:'h8fffffff]};
										 
        							 }

				HWRITE:coverpoint write_cov_data.hwrite;
				HTRANS:coverpoint write_cov_data.htrans
									{      
				  						bins low = {'b00};
                     bins mid = {'b10};
                     bins high = {'b11};

								}

   endgroup

   covergroup fcov2;

	 							option.per_instance=1;
         
          PADDR : coverpoint read_cov_data.paddr {
									   bins mid1 = {['h80000000:'h87ffffff]};
		   							 bins mid2 = {['h88000000:'h85ffffff]};
		   							 bins mid3 = {['h84000000:'h8c000000]};
        							 }
			 PRDATA : coverpoint read_cov_data.prdata {
									   bins mid1 = {['h80000000:'h83ffffff]};
		   							 bins mid2 = {['h84000000:'h87ffffff]};
		   							 bins mid3 = {['h88000000:'h8bffffff]};
		   							 bins mid4 = {['h8c000000:'h8fffffff]};
										 
        							 }
					 PWDATA : coverpoint read_cov_data.pwdata {
									 bins mid1 = {['h80000000:'h83ffffff]};
		   							 bins mid2 = {['h84000000:'h87ffffff]};
		   							 bins mid3 = {['h88000000:'h8bffffff]};
		   							 bins mid4 = {['h8c000000:'h8fffffff]};
										 
        							 }

				PWRITE:coverpoint read_cov_data.pwrite;
			

	 endgroup

*/
	extern function new ( string name, uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task write_mem(write_xtn wr_data);
	extern function void check_data(read_xtn rd_data);
	
endclass

//new
	function scoreboard::new(string name, uvm_component parent);
		super.new(name, parent);
		 //fcov1=new;
		 //fcov2=new;
	endfunction

//build	
	function void scoreboard::build_phase(uvm_phase phase);
		if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
		`uvm_fatal("CONFIG_ENV","Cannot get() env_config from uvm_config_db. have you set?")
		if(e_cfg.has_wagent)
				wfifo=new[e_cfg.no_of_wagent];
						
				foreach(wfifo[i])
					wfifo[i]=new($sformatf("wfifo[%0d]",i),this);
					
		if(e_cfg.has_ragent)
				rfifo=new[e_cfg.no_of_ragent];

				foreach(rfifo[i])
					rfifo[i]=new($sformatf("rfifo[%0d]",i),this);
						
				wr_data=new("wr_data");
				rd_data=new("rd_data");

endfunction

//run
	task scoreboard::run_phase(uvm_phase phase);
		fork
			forever
				begin
				
				wfifo[0].get(wr_data);
  				`uvm_info("WRITE SB","writing data" , UVM_LOW)
					write_mem(wr_data);
					
				end


			forever 
				begin
			
				rfifo[0].get(rd_data);
				//$display("read_data=%p",rd_data);
      				  check_data(rd_data);
  				`uvm_info("READ SB","reading data" , UVM_LOW)

				end
				
		join_any
		endtask

//write_mem
task scoreboard::write_mem(write_xtn wr_data);
	begin
		$display("wr_enb=%d",wr_data.write_enb);
		if(wr_data.write_enb)
			begin
				wq.push_back(wr_data.data_in);
			end
		$display("queue data=%p",wq);

	end
endtask


//Check phase
function void scoreboard::check_data(read_xtn rd_data);


	//read_cov_data = rd_data;
   	//fcov2.sample();
		
	// write_cov_data = wr_data;;
    	//fcov1.sample();
	$display("Scoreboard read_enb=%d",rd_data.read_enb);
	
	if(rd_data.read_enb && ~rd_data.empty)
		begin 
		rq.push_back(rd_data.data_out);
		$display("read=%p",rq);
		end
		
		if(rq.size!=0)
			begin	
				wk=wq.pop_front();
				rk=rq.pop_front();
				
				if(wk==rk)
					begin
						`uvm_info("SB_DATA_MATCH HSIZE=0","DATA Matching",UVM_NONE)
						$display("data_in=%h,data_out=%h, data matching for this data",wk,rk);
					end		
				else
					begin
						`uvm_info("SB_REPORT_WRITE","DATA Mismatching",UVM_NONE)
						$display("data_in=%h,data_out=%h, data not matching for this data",wk,rk);
					end
			end
								
			


					
endfunction
