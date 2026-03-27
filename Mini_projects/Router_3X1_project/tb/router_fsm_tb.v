`timescale 1ns/1ps
module router_fsm_tb;
    // global variables
    reg clock,resetn,pkt_valid,fifo_full,parity_done,low_pkt_valid;
    reg fifo_empty_0,fifo_empty_1,fifo_empty_2,soft_reset_1,soft_reset_2,soft_reset_0;
    reg [1:0] data_in;
    wire detect_addr,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg,lfd_state,busy;

    parameter CYCLE = 10;

    router_fsm  uut (.clock(clock),
                    .resetn(resetn),
                    .pkt_valid(pkt_valid),
                    .data_in(data_in),
                    .parity_done(parity_done),
                    .fifo_full(fifo_full),
                    .soft_reset_0(soft_reset_0),
                    .soft_reset_1(soft_reset_1),
                    .soft_reset_2(soft_reset_2),
                    .low_pkt_valid(low_pkt_valid),
                    .fifo_empty_0(fifo_empty_0),
                    .fifo_empty_1(fifo_empty_1),
                    .fifo_empty_2(fifo_empty_2),
                    .busy(busy),
                    .detect_addr(detect_addr),
                    .ld_state(ld_state),
                    .laf_state(laf_state),
                    .full_state(full_state),
                    .write_enb_reg(write_enb_reg),
                    .rst_int_reg(rst_int_reg),
                    .lfd_state(lfd_state));

    // clock generation
    initial
    clock = 1'b0;
    always # (CYCLE/2) clock = ~ clock;

    // initialisation task
    task initialise;
        begin
            {data_in,pkt_valid,parity_done,fifo_full,low_pkt_valid} = 0;
            {fifo_empty_0,fifo_empty_1,fifo_empty_2,soft_reset_0,soft_reset_1,soft_reset_2} = 0;
        end
    endtask

    //reset task
    task rst_dut;
        begin
            @(negedge clock);
                resetn = 1'b0;
            @(negedge clock);
                resetn = 1'b1;
        end
    endtask

    // scenario 1: DA - LFD - LD - LP - CPE - DA
    task s1;
        begin
            @(negedge clock);
                pkt_valid = 1;
                data_in = 0;
                fifo_empty_0 = 1;
                // state changes to LFD
            @(negedge clock);
            //Unconditionally state changes to LD
            @(negedge clock);
                fifo_full = 0;
                pkt_valid = 0;
            // condition for which it goes to LP    
            @(negedge clock);
            // unconditionally goes to CPE
            @(negedge clock);
                fifo_full = 0;                                   
        end
    endtask

    // scenario 2: DA - LFD - LD - LP - CPE - FFS - LAF - DA
    task s2;
        begin
            @(negedge clock);
                pkt_valid = 1;
                data_in = 0;
                fifo_empty_0 = 1;
            @(negedge clock);
            @(negedge clock);
                fifo_full = 0;
                pkt_valid = 0;
            @(negedge clock);
            @(negedge clock);
                fifo_full = 1;
            @(negedge clock);
                fifo_full = 0;
            @(negedge clock);
                parity_done = 1;
            @(negedge clock);
                parity_done = 0;            
        end 
    endtask

    // scenario 3: DA - LFD - LD - FFS - LAF - LP - CPE - DA
    task s3;
        begin
            @(negedge clock);
                pkt_valid = 1;
                data_in = 0;
                fifo_empty_0 = 1;
            @(negedge clock);
            @(negedge clock);
                fifo_full = 1;
            @(negedge clock);
                fifo_full = 0;
            @(negedge clock);
                fifo_full = 1;
            @(negedge clock);
            @(negedge clock);
                fifo_full=0;          
        end
    endtask

    // scenario 4: DA - LFD - LD - FFS - LAF - LD - LP - CPE - DA
    task s4;
        begin
            @(negedge clock);
                pkt_valid = 1;
                data_in = 0;
                fifo_empty_0 = 1;
            @(negedge clock);
            @(negedge clock);
                fifo_full = 1;
            @(negedge clock);
                fifo_full = 0;
                low_pkt_valid = 0;
                parity_done = 0;
            @(negedge clock);
                fifo_full = 0;
                pkt_valid = 0;
            @(negedge clock);
            @(negedge clock);
                fifo_full = 0;
        end
    endtask

// stimulus block
    initial
        begin
            $dumpfile("router_fsm.vcd");
            $dumpvars(0,router_fsm_tb);
            $monitor("Time=%0t | pkt_valid=%b data_in=%b | fifo_empty[0:2]=%b%b%b fifo_full=%b | detect_addr=%b lfd_state=%b ld_state=%b laf_state=%b full_state=%b write_enb=%b busy=%b rst_int=%b",
                     $time, pkt_valid, data_in, fifo_empty_0, fifo_empty_1, fifo_empty_2, fifo_full, detect_addr, lfd_state, ld_state, laf_state, full_state, write_enb_reg, busy, rst_int_reg);
        end
    
    initial
        begin
            initialise;
            rst_dut;
            s1;
            
            initialise;
            rst_dut;
            s2;
            
            initialise;
            rst_dut;
            s3;
            
            initialise;
            rst_dut;
            s4;
            
            #(CYCLE*10);
            $finish;
        end

endmodule