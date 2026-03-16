module seq_det_tb;
	
   reg  din,clock,reset;
   wire dout;
		
   
   parameter CYCLE = 10;
		
   
   seq_det SQD(.seq_in(din),
	       .clock(clock),
	       .reset(reset),
	       .det_o(dout));

   
   initial
      begin
         clock = 1'b0;
         forever # (CYCLE/2) clock = ~ clock;
      end


   task initialize;
      begin
         din = 1'b0;
      end
   endtask

   //Delay task
   task delay(input integer i);
      begin
	 #i;
      end
   endtask



   task RESET;
      begin 
         reset = 1'b1;
         delay(10);
         reset = 1'b0;
      end
   endtask

   
   task stimulus;
      input t;
      begin
         @(negedge clock);
         din = t;
         #1;
      end
   endtask

						 

   initial 
      begin
      $dumpfile("seq_det_tb.vcd");
      $dumpvars(0,seq_det_tb);
      $monitor("Reset=%b, state=%b, Din=%b, Output Dout=%b",
	       reset,SQD.present_state,din,dout);
      end

								
   /*Process to display a string after the sequence is detected and dout is asserted.
   SQD.state is used here as a path hierarchy where SQD is the instance name acting
   like a handle to access the internal register "state" */
   always@(SQD.present_state or dout)
      begin
	 if(SQD.present_state==2'b11 && dout==1)
	    $display("Correct output at state %b", SQD.present_state);
      end
			
		
   initial
      begin
         initialize;
         RESET;
         stimulus(0);
         stimulus(1);
         stimulus(0);
         stimulus(1);
         stimulus(0);
         stimulus(1);
         stimulus(1);
         RESET;
         stimulus(1);
         stimulus(0);
         stimulus(1);
         stimulus(1);
         delay(10);    
         $finish;
      end
			
   		
endmodule     
