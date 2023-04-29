`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2022 22:03:04
// Design Name: 
// Module Name: comp_4bit
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


module comp_1bit(//comparator module for 1bit numbers which tells which is greater or if they are equal using gate logic
    input wire a,
    input wire b,
    output wire eq,
    output wire gt,
    output wire lt
    );
    
wire abar, bbar;

assign abar = ~a;
assign bbar = ~b;

assign lt = abar &b;
assign gt = bbar & a;

assign eq = ~(lt|gt);


endmodule