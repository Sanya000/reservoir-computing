`timescale 1ns / 1ps


module Linear_regression(
    input training, //pin on fpga that specifies weather the reservoir computer should be training the weights or not
    input wire [15:0] y_target, //in case of trying to learn and reproduce input y_target == u_t (input to the system)
    input wire [15:0] x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, // neuron outputs
    input wire [7:0] w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, // nueron weights
    output wire [7:0] w0_out, w1_out, w2_out, w3_out, w4_out, w5_out, w6_out, w7_out, w8_out, w9_out, w10_out, w11_out, w12_out, w13_out, w14_out, w15_out, w16_out, w17_out, w18_out, w19_out //updated neuron weights
    );
    
    //Minimize y = sum(x*w) by minimizing |y_target - y|^2
    
    
endmodule
