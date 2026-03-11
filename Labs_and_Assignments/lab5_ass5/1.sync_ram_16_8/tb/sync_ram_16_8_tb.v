`timescale 1ns/1ps
module sync_ram_16_8_tb;
    reg clk,rst,wr_en,rd_en;
    reg [3:0] wr_addr, rd_addr;
    reg [7:0] data_in;
    wire [7:0] data_out;
    integer l;

    sync_ram_16_8 dut (.clk(clk),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),.wr_addr(wr_addr),.rd_addr(rd_addr),.data_in(data_in),.data_out(data_out));

    initial
    clk = 1'b0;
    always #5 clk = ~clk;

    task initialise;
        begin
            rst = 1'b0;
            wr_en = 1'b0;
            rd_en = 1'b0;
            wr_addr = 4'b0000;
            rd_addr = 4'b0000;
            data_in = 8'b00000000;
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

    task write;
        begin
            rd_en = 1'b0;
            wr_en = 1'b1;
        end
    endtask

    task read;
        begin
            rd_en = 1'b1;
            wr_en = 1'b0;
        end
    endtask

    task write_data;
        input [3:0] t_wr_addr;
        input [7:0] t_data;
        begin
            wr_addr = t_wr_addr;
            data_in = t_data;
            @(posedge clk);
            #1;
            
        end
    endtask

    task read_data;
        input [3:0] t_rd_addr;
        begin
            rd_addr = t_rd_addr;
            @(posedge clk);
            #1;
            
        end
    endtask

    task delay;
        begin
            #10;
        end
    endtask


    initial
        begin
            $dumpfile("sync_ram_16_8_tb.vcd");
            $dumpvars(0, sync_ram_16_8_tb);
            $monitor("Time=%0t | clk=%b rst=%b wr_en=%b rd_en=%b | wr_addr=%h rd_addr=%h | data_in=%h data_out=%h", 
                     $time, clk, rst, wr_en, rd_en, wr_addr, rd_addr, data_in, data_out);
            initialise;
            rst_dut;
            delay;
            write;
            for (l=0;l<16;l=l+1)
                begin
                    write_data(l,l);
                end
            delay;
            read;
            for (l=0;l<16;l=l+1)
                begin
                    read_data(l);
                end
            
            $finish;
            
        end

endmodule