`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2022 01:21:57
// Design Name: 
// Module Name: mux_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_2( //multiplexer using a binary 1 or 0 clock and 2 inputs
    input clk,
    input wire x1, x2,
    output reg y
);
    
always@(*)
    y = ((x1 & (~clk)) | (x2 & clk));
    
endmodule
