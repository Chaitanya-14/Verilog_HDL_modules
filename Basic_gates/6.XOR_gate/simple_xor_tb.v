`timescale 1ns / 1ns //time unit and time precision
// time unit defines the unit of time for delays
// time precision defines smallest time step that can be represented

 module simple_xor_tb; // no ports for the testbench

        reg a,b; // inputs to the design (reg bc we drive them)
        wire f;  // output from the design (wire bc we observe it)

        simple_xor uut (.a(a), .b(b), .f(f)); // instantiate the design (uut = unit under test)

        initial 
        begin
            // required for GTK wave / Wave trace
            $dumpfile("simplexor.vcd"); // name of the vcd file
            $dumpvars(0, simple_xor_tb);  // dump all vars in testbench

            // monitor changes in terminal
            $monitor("Time= %0t | a=%b | b=%b | f=%b", $time,a,b,f);

            a=0; b=0; #10; //0|0  0
            a=0; b=1; #10; //0|1  1
            a=1; b=0; #10; //1|0  1
            a=1; b=1; #10; //1|1  1
            $finish; // end simulation

        end
 endmodule