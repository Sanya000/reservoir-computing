`timescale 1ns / 1ps

module mux_2( //multiplexer using a binary 1 or 0 clock and 2 inputs
    input clk,
    input wire x1, x2,
    output reg y
);
    
always@(*)
    y = ((x1 & (~clk)) | (x2 & clk));
    
endmodule
