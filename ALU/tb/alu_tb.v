`timescale 1ns/1ps
`default_nettype none

module alu_tb;

reg [7:0] a,b;
reg [3:0] command;
reg enable;
wire [15:0] d_out;

// variables for the iteration of the loops
integer m,n,o;
// a string command for storing the values
reg [32:0] string_command;

// parameter constants for displaying the string during the operations
parameter ADD = 4'b0000,  // Add two 8-bit numbers a and b
          SUB = 4'b0001,  // Subtract b from a
          MUL = 4'b0010,  // Multiply a and b
          DIV = 4'b0011,  // Divide b by a
          INC = 4'b0100,  // Increment a by 1
          DEC = 4'b0101,  // Decrement a by 1
          SHL = 4'b0110,  // Shift a left by 1 bit
          SHR = 4'b0111,  // Shift a right by 1 bit
          AND = 4'b1000,  // Logical AND of a and b
          OR = 4'b1001,   // Logical OR of a and b
          INV = 4'b1010,  // Logical inverse of a
          NAND = 4'b1011, // NAND of a and b
          NOR = 4'b1100,  // NOR of a and b
          XOR = 4'b1101,  // XOR of a and b
          XNOR = 4'b1110, // XNOR of a and b
          BUF = 4'b1111;  // Output of a


// alu instatiation
alu uut (.a_in(a),.b_in(b),.command_in(command),.oe(enable),.d_out(d_out));


// writing the tasks for tb

// initialisation task
task initialise;
    begin 
        a=8'b0;
        b=8'b0;
        enable=0;
        command=4'b0;
    end
endtask

// task for enableing the output
task en_output(input i); 
    begin
        enable = i;
    end
endtask

// task for giving the inputs
task inputs (input [7:0]j,k);
    begin
      a=j;
      b=k;
    end
endtask

//task for command input
task cmd (input [3:0]l);
    begin
      command = l;
    end
endtask

// task for giving the delay
task delay();
    begin
      #10;
    end
endtask

//process to display the output
initial 
  begin
    $monitor("Input oe=%b, a=%b, b=%b, command=%s , Output d_out=%b",enable, a,b, string_command, d_out);
    $dumpfile("alu_tb.vcd");
    $dumpvars(0,alu_tb);
  end


// process to hold the string values as per the commands.
always @(command)
begin
  case(command)
    ADD: string_command = "ADD";
    SUB: string_command = "SUB";
    MUL: string_command = "MUL";
    DIV: string_command = "DIV";
    INC: string_command = "INC";
    DEC: string_command = "DEC";
    SHL: string_command = "SHL";
    SHR: string_command = "SHR";
    AND: string_command = "AND";
    OR:  string_command = "OR";
    INV: string_command = "INV";
    NAND:string_command = "NAND";
    NOR: string_command = "NOR";
    XOR: string_command = "XOR";
    XNOR:string_command = "XNOR";
    BUF: string_command = "BUF";
  endcase
end

initial 
    begin 
        initialise;
        enable=1;
        for (m=0;m<16;m++)
            begin
                 for (n=0;n<16;n++)
                    begin
                      inputs (m,n);
                        for(o=0;0<16;o++)
                          begin
                            command =o;
                            delay;
                        end
                    end
            end
    
    en_output(0);
    inputs(8'd20,8'd10);
    cmd(ADD);
    delay;
    en_output(1);
    inputs(8'd25,8'd17);
    cmd(SUB);
    delay;
    $finish;
end
    

endmodule