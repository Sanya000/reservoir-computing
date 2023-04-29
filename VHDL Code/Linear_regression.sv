`timescale 1ns / 1ps


module Linear_regression(
    input training,
    input wire[15:0] seed,
    input wire [15:0]x_out_x0, x_out1, x_out2, x_out3, out_x4, out_x5, out_x6, out_x7, out_x8, out_x9,
                     x_out_x10, x_out11, x_out12, x_out13, out_x14, out_x15, out_x16, out_x17, out_x18, out_x19, //all neuron outputs, Cant pass arrays in verilog so have to do it like this
    input wire [15:0]y_target, //input of whole system if trying to recreate and learn input
    output wire [15:0]y_out // linear weighted sum of the neauron outputs and their respective weights
    );
    
reg [7:0]W_out [0:19]; // array of neuron weights

//initialize "random weights"


W_out[0] <= 8'b00010101;


endmodule
