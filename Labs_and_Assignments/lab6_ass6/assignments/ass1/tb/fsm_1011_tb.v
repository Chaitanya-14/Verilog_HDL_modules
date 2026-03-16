`timescale 1ns/1ps
module fsm_1011_tb;
    reg clk,rst,seq_in;
    wire d_out;
    integer i;
    
    fsm_1011 uut (.clk(clk),.rst(rst),.seq_in(seq_in),.d_out(d_out));

    parameter CYCLE = 10;

    task delay;
        input integer i;
        begin
            #i;
        end
    endtask
    
    initial 
    clk = 1'b0;
    always #(CYCLE/2) clk = ~clk;

    task initialize;
        begin
            seq_in = 1'b0;
        end
    endtask

    task rst_dut;
        begin
            rst = 1'b1;
            delay(10);
            rst = 1'b0;
        end
    endtask

    task stimulus;
        input t;
            begin
                seq_in = t;
            end
    endtask

    initial
        begin
            $dumpfile("fsm_1011.vcd");
            $dumpvars(0,fsm_1011_tb);
            $monitor("Time = %0t rst=%b seq_in =%b state=%b next output = %b", $time, rst,seq_in,uut.present_state,d_out);
        end

        always (uut.present_state , d_out)
            begin
                if (uu.present_state = 2'b11 && d_out == 1)
                    $display ("correct output at state %b", uut.present_state );
            end


    initial
        begin
            initialize;
            rst_dut;
            stimulus(1);
            stimulus(0);
            stimulus(1);
            stimulus(1);
            stimulus(0);
            stimulus(1);
            rst_dut;
            stimulus(1);
            stimulus(0);
            stimulus(1);
            stimulus(1);
            stimulus(0);
            stimulus(1);
            stimulus(1);
            stimulus(1);
            delay(10);    
            $finish;

        end

endmodule
