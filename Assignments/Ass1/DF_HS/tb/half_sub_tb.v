`timescale 1ns/1ps

module half_sub_tb ;
    reg a , b;
    wire d ,bo;
    
    half_sub uut (.a(a),.b(b),.diff(d),.borr(bo));

    task initialise;
        begin
            a = 1'b0;
            b= 1'b0;
        end
    endtask

    task simulus;
        input i;
        input j;
        begin
            a = i;
            j = j;
            #5;
        end
    endtask

    initial
        begin
            initialise;
            $dumpfile("half_sub.vcd");
            $dumpvars(0, half_sub_tb);
            $monitor("Time=%0t | a=%b b=%b | diff=%b borrow=%b", $time, a, b, d, bo);

            simulus(1'b0, 1'b0);
            simulus(1'b0, 1'b1);
            simulus(1'b1, 1'b0);
            simulus(1'b1, 1'b1);

            $finish;
        
        end


endmodule