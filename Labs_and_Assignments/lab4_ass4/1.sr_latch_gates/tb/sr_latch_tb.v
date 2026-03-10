`timescale 1ns/1ps
module sr_latch_tb;
    reg s,r;
    wire q,qbar;
    integer i,j;
    
    sr_latch uut (.set(s), .reset(r), .q_out(q), .qbar(qbar));

    task initialise;
    begin 
        s=0;
        r=0;
    end
    endtask


    task stimulus;
    input ts;
    input tr;
    begin
        s=ts;
        r=tr;
        #10;
    end
    endtask

    initial
    begin
        $dumpfile("sr_latch.vcd");
        $dumpvars(0,sr_latch_tb);
        initialise;
        for (i=0; i<2; i=i+1)
        begin
            for (j=0; j<2; j=j+1)
            begin
                stimulus(i,j);
            end

        end

    end
    initial
    begin
    $monitor("Time=%0t s=%b r=%b q=%b qbar=%b", $time, s, r, q, qbar);
    #100 $finish;
    end

endmodule
