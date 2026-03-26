module router_reg(  input clock,
                    input resetn,
                    input pkt_valid,
                    input [7:0] data_in,
                    input fifo_full,
                    input rst_int_reg,
                    input detect_addr,
                    input ld_state,
                    input laf_state,
                    input full_state,
                    input lfd_state,
                    output reg parity_done,
                    output reg low_pkt_valid,
                    output reg err,
                    output  reg [7:0] dout);
                    
//internal registers
reg [7:0] full_state_byte; 
reg [7:0] pkt_parity;
reg [7:0] first_byte;
reg [7:0] internal_parity;


// parity done logic
always @(posedge clock)
    begin
        if (~resetn)
            parity_done <= 1'b0;
        else if ((ld_state && !fifo_full && !pkt_valid) || (laf_state && !parity_done && low_pkt_valid)) // it will be asserted only when packet parity is recieved from source lan within the register block
            parity_done <=  1'b1;
        else if (detect_addr)
            parity_done <= 1'b0; //parity done is initialised when new address is detected
    end

//low_pkt_valid logic
always@(posedge clock)
    begin
        if (~resetn)
            low_pkt_valid <= 1'b0;
        else if(ld_state == 1 && pkt_valid == 0)
            low_pkt_valid <= 1'b1;
        else if (rst_int_reg)
            low_pkt_valid <= 1'b0;
    end

// register dout logic
always@(posedge clock)
    begin
        if (~resetn)
            begin
                dout <= 8'h00;
                first_byte <= 8'h00;
                full_state_byte <= 8'h00;            
            end
        else begin 
            if (detect_addr && pkt_valid == 1 && data_in [1:0] != 2'b11)
                first_byte <= data_in;
            else if (lfd_state)
                dout <= first_byte;
            else if (ld_state && !fifo_full) //payload bytes loading
                dout <= data_in; 
            else if(ld_state && fifo_full) // if the fifo is full the data can't be directed to d_out, we store it in full_state_byte internal reg
                full_state_byte <= data_in; //full_state_byte can be parity or can be payload data
            else if (laf_state) // load after full is high thenfifo_full =0 fifo is loadable 
                dout <= full_state_byte;
        end
    end

always@(posedge clock)
    begin
        if (~resetn)
            internal_parity <= 8'h00; // internal register
        else begin
            if (detect_addr)
                internal_parity <= 8'h00;   
            else if(lfd_state)
                begin
                    internal_parity <= internal_parity ^ first_byte;
                end
            else if (ld_state && pkt_valid) // XOR data even if FIFO is full, as it's stored in full_state_byte
                begin
                    internal_parity <= internal_parity ^ data_in; //this continues
                end
        end
    end

// packet parity logic - when to capture the parity coming from the source lan
always@(posedge clock)
    begin
        if (~resetn)
            pkt_parity <= 8'h00;
        else if (detect_addr)
            pkt_parity <= 8'h00;
        else if ((ld_state && !pkt_valid && !fifo_full) || (laf_state && low_pkt_valid && !parity_done)) // (end of current packet) (end of current packet ) and data in will be the parity packet
            pkt_parity <= data_in;
    end

// error logic
always@(posedge clock)
    begin
        if (~resetn)
            err <= 1'b0;
        else if (!parity_done)
            err <= 1'b0;
        else if (pkt_parity != internal_parity)
            err <= 1'b1;
        else 
            err <= 1'b0;
    end

endmodule