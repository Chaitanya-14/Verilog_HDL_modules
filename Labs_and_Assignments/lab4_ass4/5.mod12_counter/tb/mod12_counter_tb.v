`timescale 1ns/ps
module mod12_counter;
    reg clk,rst,load_en,count_en;
    reg [3:0] data_in;
    wire data_out;

    mod12_counter uut (.clk(clk) ,.rst(rst), .load_en(load_en), .count_en(count_en), .data_in(data_in) ,.data_out(data_out));

    initial
    begin
