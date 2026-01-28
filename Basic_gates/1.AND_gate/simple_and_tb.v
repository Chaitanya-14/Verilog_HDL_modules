`timescale 1ns  / 1ns

module simple_and_tb; //no ports for a testbench
    //1. Declare signals to connect to your design
    // use reg for inputs (things you change)
    // and wire for outputs (things you observe)
    reg a;
    reg b;
    wire f;

    // 2. Instantiate your design (plug the chip in)
    // format: module_name instance_name ( /port(signal), ...):
    // This matches your "module simple_and" definition
    simple_and uut ( .a(a), .b(b), .f(f) );

    // 3. Testing logic

    initial begin
        // Required for GTK wave /Wave trace

        $dumpfile("simpleand.vcd");
        $dumpvars(0, simple_and_tb);

        // Monitor changes in terminal
        $monitor("Time=%0t | a=%b b=%b | f = %b", $time, a ,b ,f);
        // 5. Apply the inputs (Trth Table)

        a = 0; b = 0; #10; // wait 10 time units //0&0  0
        a = 0; b = 1; #10; //0&1  0
        a = 1; b = 0; #10; //1&0  0
        a = 1; b = 1; #10; //1&1  1

        $finish; // end simulation
    end
endmodule

