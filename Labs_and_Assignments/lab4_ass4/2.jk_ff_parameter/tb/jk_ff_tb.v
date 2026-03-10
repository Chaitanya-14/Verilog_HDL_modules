`timescale 1ns/1ps
module jk_ff_tb;
    reg clock,j,k;
    wire q,qb;
    integer p,r;

    jk_ff uut (.j(j),.k(k),.clock(clock),.q(q),.qb(qb));
    
    task initialise;
        begin
            j = 1'b0;
            k = 1'b0;
        end
    endtask

    task stimulus;
        input tj;
        input tk;
        begin
            j = tj;
            k = tk;
            @(posedge clock);
            #1;
        end
    endtask

    initial begin
        clock = 1'b0;
    end

    always #5 clock = ~clock;

    initial
    begin
        $dumpfile("jk_ff.vcd");
        $dumpvars(0,jk_ff_tb);
        $monitor("Time=%0t j=%b k=%b q=%b qb=%b",$time,j,k,q,qb);
        initialise;

        // Drive a known state first to avoid starting from X in hold mode.
        stimulus(1'b0, 1'b1);

        for (p=0;p<2;p=p+1)begin
            for (r=0;r<2;r=r+1)begin
                stimulus(p[0], r[0]);
        end
        end
    end

    initial
    #100 $finish;

endmodule





