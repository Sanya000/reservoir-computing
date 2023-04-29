`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2022 21:14:47
// Design Name: 
// Module Name: Memory
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


module Node( //two input node that does operations with stochastic bit streams and then converst back to binary for the rest of the computations
    input wire clk, Nc,
    input wire w1, //configuration parameters V's stochastic bit stream 
    input wire i1, //reservoir input stochastic bitstream
    input wire w2, //configuration parameters R's stochastic bit stream 
    input wire [15:0] rand, //pseudo_random number from LFSR
    input wire [15:0] i2, //output from another neuron
    output wire [15:0] x_i //output from this neuron
    );
    

wire x_anterior; // stochastic bitstream for i2

wire lt, gt, eq;
wire x1, x2;
wire y;
wire [15: 0] p2b_out;
wire [16: 0] shift_out;
wire [15: 0] node_o;



comp_16bit agtb(i2, rand, lt, gt, eq); //calling comparator for B2P for i2

assign x_anterior = gt ? 1'b1: //B2P operation for i2
                    lt ? 1'b0:
                    eq ? 1'b0:
                         1'b0;

assign x1 = ~(w1 ^ i1); //XNOR of w1 and i1 stochastic bitstreams (x1)
assign x2 = ~(w2 ^ x_anterior);//XNOR of w2 and x_anterior stochastic bitstreams (x1)

mux_2 add(clk, x1, x2, y); //Multiplexer of x1 and x2 with output y

P2B p2b_1(clk, 1'b1, y, Nc, p2b_out); //Stochastic bitstream back to binary conversion of y

assign shift_out = p2b_out << 1; //multiply the output of the P2B by 2 by shifting the bits

Activation_function sig(shift_out, node_o);//calling the activation function tahn to get the final output of the neuron

assign x_i = node_o;

endmodule
