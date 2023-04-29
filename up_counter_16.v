`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2022 23:03:22
// Design Name: 
// Module Name: up_counter_16
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


module up_counter_16(
    input wire clk, reset, enable,
    output [15:0] counter
    );
    
reg [15:0] counter_up;

always@(posedge clk)
    begin
        if(reset)
            counter_up <= 16'b0000000000000000;
        if(enable)
            counter_up <= counter_up + 16'b0000000000000001;
    end

assign counter = counter_up;

endmodule
