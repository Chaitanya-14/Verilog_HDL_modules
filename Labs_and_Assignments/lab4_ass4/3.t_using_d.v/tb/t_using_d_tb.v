`timescale 1ns/1ps
module t_using_d_tb;
    reg t, clk, rst;
    wire q,qbar;

    t_using_d uut (.t(t), .clk(clk), .rst(rst), .q(q), .qbar(qbar));

    initial
    clk = 1'b0;
    always
    #5 clk = ~clk;

    task initialise;
        begin
            t = 1'b0;
            rst = 1'b0;
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

    task tin;
        input tmp;
        begin
            @(posedge clk);   
            t=tmp;
        end
    endtask

    initial 
    begin
        $dumpfile("t_using_d.vcd");
        $dumpvars(0,t_using_d_tb);
        $monitor("Time=%0t t=%b q=%b qbar=%b",$time,t,q,qbar);
        initialise;
        rst_dut;

        tin(1'b1);
        tin(1'b0);
        tin(1'b1);
        tin(1'b0);

    end

    initial 
    #100 $finish;

endmodule

