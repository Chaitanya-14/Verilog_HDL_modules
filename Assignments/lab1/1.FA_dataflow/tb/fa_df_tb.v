`timescale 1ns/1ps

module fa_df_tb;

reg a, b , c;
wire sum , carry;

fa_df uut (.a_in(a),.b_in(b),.c_in(c),.sum_out(sum),.c_out(carry));

integer i ;

task apply_test;
    input [2:0] test_vector;
    begin
        {a,b,c} = test_vector;
        #10;
    end
endtask

initial 
begin
    $monitor ("Time = %0t | a=%b | b=%b | c=%b | sum=%b | carry=%b ", $time,a,b,c,sum,carry);
    $dumpfile("fa_df.vcd");
    $dumpvars(0,fa_df_tb);

    for (i=0 ; i<8 ; i = i+1)
    begin
        apply_test(i);
    end

    #100 $finish;
end

endmodule
