`timescale 1ns / 1ps

module P2B( //Stochastic pulse back to binary value converter module
    input wire clk, enable, p_input, //p_input is the pulse stream to convert to binary
    input wire [15:0] Nc, 
    output wire [15:0] b_output //16bit binary output 
    );
    
wire count_enable; //enable pin for counter
wire count_reset; // reset pin for counter
wire [15:0] m1, m2; //two 16bit internal connections
wire lt, gt, eq; //less than, greater than and equal boolean outputs for comparator

assign count_enable = p_input & enable; // enable signal for counter is the output of enable for module AND the pulse stream

up_counter_16 counter1(clk, count_reset, count_enable, m1); //one counter to count the number of high pulses in p_input

up_counter_16 counter2(clk, count_reset, enable, m2);//second counter to count up while module is enabled

comp_16bit check(Nc, m2, lt, gt, eq); //comparator module call to check if second counter has counted to Nx

assign count_reset = eq; //if second counter reaches Nc reset all counters 

register_16bits hold(count_reset, clk, m1, b_output); // if counters are reset a register passes on the accumulated number of high values in the stochastic pulse stream as the converted binary value
 
endmodule
