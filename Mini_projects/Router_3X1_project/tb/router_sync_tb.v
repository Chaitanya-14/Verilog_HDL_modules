`timescale 1ns/1ps
module router_sync_tb;

    // Global variables
    reg clock, resetn,detect_addr,write_enb_reg,read_enb_0,read_enb_1,read_enb_2,empty_0,empty_1,empty_2,full_0,full_1,full_2;
    reg [1:0] data_in;
    wire [2:0] write_enb;
    wire fifo_full,valid_out_0,valid_out_1,valid_out_2,soft_reset_0,soft_reset_1,soft_reset_2;

    parameter CYCLE = 10;

    router_sync uut (.clock(clock),
                    .resetn(resetn),
                    .detect_addr(detect_addr),
                    .data_in(data_in),
                    .write_enb_reg(write_enb_reg),
                    .read_enb_0(read_enb_0),
                    .read_enb_1(read_enb_1),
                    .read_enb_2(read_enb_2),
                    .empty_0(empty_0),
                    .empty_1(empty_1),
                    .empty_2(empty_2),
                    .full_0(full_0),
                    .full_1(full_1),
                    .full_2(full_2),
                    .write_enb(write_enb),
                    .fifo_full(fifo_full),
                    .valid_out_0(valid_out_0),
                    .valid_out_1(valid_out_1),
                    .valid_out_2(valid_out_2),
                    .soft_reset_0(soft_reset_0),
                    .soft_reset_1(soft_reset_1),
                    .soft_reset_2(soft_reset_2));  // explicit port declaration

    // clock generation
    initial
        begin
            clock = 1'b0;
        end
    always #(CYCLE/2) clock = ~clock;


    //initialisation task
    task initialise;
        begin
            data_in = 2'b00;
            detect_addr = 0;
            write_enb_reg = 0;
            read_enb_0 = 0;
            read_enb_1 = 0;
            read_enb_2 = 0;
            full_0 = 0;
            full_1 = 0;
            full_2 = 0;
            empty_0 = 1;
            empty_1 = 1;
            empty_2 = 1;
        end
    endtask

    // reset task
    task rst_dut;
        begin
            @(negedge clock);
                resetn = 1'b0;
            @(negedge clock);
                resetn = 1'b1;
                #1;
        end
    endtask

    // writing task
    task write;
         begin
            @(negedge clock);
                write_enb_reg = 1'b1;
            @(negedge clock);
                write_enb_reg = 1'b0;
         end
    endtask

    // address task - to load the address to the dut
    task addr;
        input [1:0] taddr;
        begin
            @(negedge clock);
            detect_addr = 1'b1;
            data_in = taddr;
            #1;
            @(negedge clock);
            detect_addr = 1'b0;
        end
    endtask

    //inputs for the time out
    task inputs;
        begin
            @(negedge clock);
                full_1  = 1'b1;
                empty_1 = 1'b0;
                read_enb_1  = 1'b0;
        end 
    endtask


    // main block
    initial
        begin
            $dumpfile ("router_sync.vcd");
            $dumpvars (0,router_sync_tb);
            $monitor ("Values of the write enable = %b , fifo_full = %b, valid_out_0 = %b , valid_out_1 = %b, valid_out_2 = %b , soft_reset_0 = %b ,soft_reset_1 = %b ,soft_reset_2 = %b",write_enb,fifo_full,
            valid_out_0,valid_out_1,valid_out_2,soft_reset_0,soft_reset_1,soft_reset_2);
            initialise;
            rst_dut;
            addr(2'd1);
            write;
            inputs;
            #400 $finish;
        end



endmodule

