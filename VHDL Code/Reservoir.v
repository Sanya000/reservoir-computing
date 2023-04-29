`timescale 1ns / 1ps


module Reservoir(
    input wire [15:0] u_t, //input to reservoir
    input clk, Nc, //clk and evaluation parameter
    input wire [15:0] R, V, seed, // r and v are configuration parameters for connections inside the reservoir and seed is the seed for the LFSR
    output wire [15:0] y_out0, y_out1, y_out2, y_out3, y_out4, y_out5, y_out6, y_out7, y_out8, y_out9, // output of the neurons
                       y_out10, y_out11, y_out12, y_out13, y_out14, y_out15, y_out16, y_out17, y_out18, y_out19
    );
    
parameter N = 20;//number of neurons

wire i1, ri, vi;//these are the stochastic bitstreams from u_t, R and V respectively
wire [15:0] out_x[0:N-1];//array of the neuron outputs
wire [15:0] rand; // pseudo random output from LFSR
wire rand_done;// status on LFSR


LFSR lfsr_1(clk, 1'b1, seed, rand, rand_done); //calling the LFSR module to create a pseudo-random 16 bit number

B2P input_b2p(u_t, clk, i1); //Binary to pulse stochastic conversion of input to reservoir to be used inside neurons
B2P r_b2p(R, clk, ri); //Binary to pulse stochastic conversion of R to reservoir to be used inside neurons 
B2P v_b2p(V, clk, vi);//Binary to pulse stochastic conversion of V to reservoir to be used inside neurons

Node n0(clk, Nc, vi, i1, ri, rand, out_x[19], out_x[0]); //initialization of first node in the cyclic reservoir
genvar i;
generate//assigning each neurons connections in the cyclic reservoir
    for( i = 1; i < N; i = i + 2) //assigning NOT V to every second neuron
        begin
            Node ni(clk, Nc, vi, i1, ri, rand, out_x[i-1], out_x[i]);
        end
    for( i = 2; i <N; i = i + 2)
        begin
            Node ni(clk, Nc, ~vi, i1, ri, rand, out_x[i-1], out_x[i]);
        end
endgenerate



//assigning all neuron outputs to ouput of reservoir module
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];
assign y_out0 = out_x[0];



endmodule
