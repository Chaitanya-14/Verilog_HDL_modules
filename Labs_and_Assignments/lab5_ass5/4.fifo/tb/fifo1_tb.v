`timescale 1ns/1ps
module fifo1_tb;
    reg clk,rst,write_en,read_en;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire full,empty;

    integer i;

    fifo1 uut (.clk(clk),
                .rst(rst),
                .read_en(read_en),
                .write_en(write_en),
                .data_in(data_in),
                .data_out(data_out),
                .full(full),
                .empty(empty));

    initial
    clk = 1'b0;
    always #5 clk = ~clk;

    task initialise;
        begin
            rst = 1'b1;
            write_en= 1'b0;
            read_en=1'b0;
            data_in=8'h00;
        end
    endtask

    task rst_dut;
        begin
            rst = 1'b1;
            #2
            rst = 1'b0;
            #12
            rst = 1'b1;
        end
    endtask

    task read_data;
        begin
            @(posedge clk);
            read_en = 1'b1;
            write_en = 1'b0;
            @(posedge clk); //DUT samples here
            #1;
            read_en=1'b0;
        end
    endtask

    task write_data;
        input [7:0] tdata;
        begin
            @(posedge clk);
            write_en = 1'b1;
            read_en=1'b0;
            data_in = tdata;
            @(posedge clk); //DUT samples here
            #1;
            write_en = 1'b0;
            data_in = 8'h00;
        end
    endtask

    initial
        begin
            $dumpfile("fifo1.vcd");
            $dumpvars(0,fifo1_tb);
            $monitor("Time=%0t | clk=%b rst=%b write_en=%b read_en=%b data_in=%h data_out=%h full=%b empty=%b", 
                     $time, clk, rst, write_en, read_en, data_in, data_out, full, empty);
            initialise;
            rst_dut;
            // read empty data
            read_data;

            // fill fifo completely
            for (i=0;i<16;i=i+1)
                begin
                    write_data(i[7:0]);
                end
            
            write_data(8'hAA);

            // reading all entries
            for(i=0;i<16;i=i+1)
                begin
                    read_data();
                end
            
            //try read when empty

            read_data();

            
            
            #20 $finish;

        end

endmodule



