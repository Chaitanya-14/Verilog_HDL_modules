`timescale 1ns/1ps
module sync_fifo_tb;
    reg clk,rst;
    reg write_en,read_en;
    reg [15:0] data_in;
    wire [15:0] data_out;
    wire full,empty,almost_full,almost_empty;
    integer i;

    sync_fifo uut (.clk(clk),
                    .rst(rst),
                    .write_en(write_en),
                    .read_en(read_en),
                    .data_in(data_in),
                    .data_out(data_out),
                    .full(full),
                    .empty(empty),
                    .almost_full(almost_full),
                    .almost_empty(almost_empty));

    initial
    clk = 1'b0;
    always #5 clk = ~clk;

    task initialise;
        begin
            rst = 1'b0;
            write_en = 1'b0;
            read_en = 1'b0;
            data_in = 16'h0000;
        end
    endtask

    task rst_dut;
        begin
            @(negedge clk);
            rst = 1'b1;
            @(negedge clk);
            rst = 1'b0;
        end
    endtask

    task write_data;
        input [15:0] tdata;
        begin
            @(posedge clk);
            write_en=1'b1;
            read_en=1'b0;
            data_in = tdata;
            @(posedge clk);
            #1;
            write_en= 1'b0;
            data_in = 16'h0000;
        end
    endtask

    task read_data;
        begin
            @(posedge clk);
            read_en = 1'b1;
            write_en = 1'b0;
            @(posedge clk);
            #1;
            read_en= 1'b0;
        end 
    endtask

    task check_flags;
        input exp_full, exp_empty, exp_af, exp_ae;
        begin
            #1;
            if (full !== exp_full)         
            $error("FULL mismatch at T=%0t", $time);
            if (empty !== exp_empty)       
            $error("EMPTY mismatch at T=%0t", $time);
            if (almost_full !== exp_af)    
            $error("ALMOST_FULL mismatch at T=%0t", $time);
            if (almost_empty !== exp_ae)   
            $error("ALMOST_EMPTY mismatch at T=%0t", $time);
        end
    endtask


    initial
        begin
            $dumpfile("sync_fifo_tb.vcd");
            $dumpvars(0, sync_fifo_tb);
            $monitor("Time=%0t | rst=%b | write_en=%b | read_en=%b | data_in=%h | data_out=%h | full=%b | empty=%b | almost_full=%b | almost_empty=%b", 
                     $time, rst, write_en, read_en, data_in, data_out, full, empty, almost_full, almost_empty);
            initialise;
            $display("Initialised")
            rst_dut;
            $display("DUT has been reset");

            // After reset: count=0
            check_flags(1'b0, 1'b1, 1'b0, 1'b1);

            // Fill to count=30 -> almost_full
            for (i=0; i<30; i=i+1) write_data(i[15:0]);
            check_flags(1'b0, 1'b0, 1'b1, 1'b0);

            // Fill to count=32 -> full + almost_full
            write_data(16'h5555);
            write_data(16'h6666);
            check_flags(1'b1, 1'b0, 1'b1, 1'b0);

            // Drain to count=2 -> almost_empty
            for (i=0; i<30; i=i+1) read_data();
            check_flags(1'b0, 1'b0, 1'b0, 1'b1);

            // Drain to empty
            read_data();
            read_data();
            check_flags(1'b0, 1'b1, 1'b0, 1'b1);
            #50 $finish;
        end
endmodule