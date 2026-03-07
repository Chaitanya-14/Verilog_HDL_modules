`timescale 1ns/1ps

module rp_adder_tb;
    reg [3:0] a_in,b_in;
    reg c_in;
    wire [3:0] sum_out;
    wire [3:0] c_out;
    integer i,j,k;

    rp_adder uut1 (.a(a_in),.b(b_in),.cin(c_in),.sum(sum_out),.cout(c_out));

    task apply_stimulus;
        input [3:0] ta;
        input [3:0] tb;
        input tcin;
        begin
            a_in = ta;
            b_in = tb;
            c_in = tcin;
            #10;
            $display("T=%0t a=%b b=%b c=%b sum=%b cout=%b",$time,a_in,b_in,c_in,sum_out,c_out);
        end
    endtask

    initial 
    begin
        $dumpfile("rp_adder.vcd");
        $dumpvars(0,rp_adder_tb);

        // Test all combinations 16 X 16 X 2 = 512 cases
        for (i=0;i<16;i=i+1)
        begin
            for(j=0;j<16;j=j+1)
            begin
                for (k=0;k<2;k=k+1)
                begin
                    apply_stimulus(i[3:0],j[3:0],k[0]);
                end
            end
        end

    $finish;
        
    end
endmodule