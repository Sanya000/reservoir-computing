`timescale 1ns / 1ps


module register_16bits( //simple 16bit register that holds a value until enable is high where it passes the input to the output effectively holding the input iuntil enable is set to high
    input wire enable,
    input wire clk,
    input wire [15:0] D,
    output reg [15:0] Q
    );

always@(posedge clk)
    begin
        if(enable)
            Q = D;
    end
endmodule
