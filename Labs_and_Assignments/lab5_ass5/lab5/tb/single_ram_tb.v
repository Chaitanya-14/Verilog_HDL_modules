`timescale 1ns/1ps
module single_ram_tb;
    reg wr,rd;
    reg [3:0] addr;
    wire [7:0] data;
    reg [7:0] tdata;
    integer l;

    single_ram uut (.wr_en(wr),.rd_en(rd),.addr(addr),.data(data));

    // data acts as input port when wr_en is 1.
    assign data = (wr && !rd) ? tdata : 8'bzz;

    task initialise;
        begin
            wr=1'b0;
            rd=1'b0;
            addr= 4'b0000;
            tdata=8'b00000000;
        end
    endtask

    task write;
        begin
            wr = 1'b1;
            rd = 1'b0;
            #1;
        end
    endtask

    task read;
        begin
            wr = 1'b0;
            rd = 1'b1;
            #1;
        end
    endtask

    task apply_data;
        input [3:0] t_addr;
        input [7:0] temp_data;
        begin
            tdata = temp_data;
            addr = t_addr;
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
            $dumpfile("single_ram_tb.vcd");
            $dumpvars(0, single_ram_tb);
            $monitor("Time=%0t | wr=%b | rd=%b | addr=%h | data=%h | tdata=%h", $time, wr, rd, addr, data, tdata);
            initialise;
            delay;
            write;
            for (l=0;l<16;l=l+1)
                begin
                    apply_data(l,l);
                    delay;
                end
            read;
            for (l=0;l<16;l=l+1)
                begin
                    apply_data(l,l);
                    delay;
                end
            $finish;
        end

endmodule   




