module seq_det(seq_in,
	       clock,
	       reset,
	       det_o);
								 
   //states as parameter "IDLE","STATE1","STATE2","STATE3"
		parameter IDLE = 2'b00;
		parameter STATE1 = 2'b01;
		parameter STATE2 = 2'b10;
		parameter STATE3 = 2'b11;

   // ports direction
		input seq_in,clock,reset;
		output det_o;

   //Internal registers
   reg [1:0]present_state,next_state;

   // sequential logic for present state with active high asychronous reset
   always @ (posedge clock)
		begin
			if (reset)
				present_state <= IDLE;
			else
				present_state <= next_state;
		end

		
   always@(present_state,seq_in)
      begin
	 case(present_state)
	    IDLE   : 
                      if(seq_in==1) 
		         next_state=STATE1;
	              else
	                 next_state=IDLE;
	    STATE1 : 
                      if(seq_in==0)
	                 next_state=STATE2;
	              else
	                 next_state=STATE1;
	    STATE2 :
                      if(seq_in==1)
	                 next_state=STATE3;
	              else 
	                 next_state=IDLE;
	    STATE3 : 
                      if(seq_in==1)
	                 next_state=STATE1;
	              else 
	                 next_state=STATE2;
	    default: 
                      next_state=IDLE;
	 endcase
      end

   //logic for Moore output det_o
   
	assign det_o = (present_state == STATE3);
endmodule