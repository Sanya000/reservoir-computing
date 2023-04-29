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


module Reservoir_computer(
    input clk, data_sel, reset, training, //data_sel is a switch on the fpga that dictates if the reservoir is using pre loaded data from bRAM(1) or from some real world connection(0), training is another switch that tells the system if its training or it should output
    input wire [15:0] data, //input to system from real world that is used if data_sel == 0
    output reg [15:0] y_out //experimental output of whole system that is a linear combination of the neuron outputs and their trained weights
    );

parameter r = 16'b0101010101010101; //configuration parameter that is responsile for intra-neuronal connections
parameter v = 16'b1010101010101010; //configuration parameter that is responsible for input to neuron connections
parameter seed = 16'b1101101101101101; //seed for the LFSR
parameter Nc = 16'b1111111111111111; //2^16 


wire [15:0] douta;// input for system from ROM module
reg [15:0] data_in;// input for the reservoir
reg eq, gt, lt; //boolean outputs from 16bit comparator(eq = equal, gt = greater than and lt = less than)
reg [12:0] address = 13'b0000000000000;//address of the ROM data we want to use
reg [15:0] eval_counter = 16'b0000000000000000;//counter to implement the evaluation time where the system gets fed a new output every (T_eval = Nc * clk) so that stochastic circuitry can update in time
wire [7:0]W_out0, W_out1, W_out2, W_out3, W_out4, W_out5, W_out6, W_out7, W_out8, W_out9, W_out10, W_out11, W_out12, W_out13, W_out14, W_out15, W_out16, W_out17, W_out18, W_out19;//array of final weights
wire [15:0] y_out0, y_out1, y_out2, y_out3, y_out4, y_out5, y_out6, y_out7, y_out8, y_out9, // output of the neurons
                       y_out10, y_out11, y_out12, y_out13, y_out14, y_out15, y_out16, y_out17, y_out18, y_out19;

//assign "random" values to weights
assign W_out0 = 8'b01010101;
assign W_out1 = 8'b01011101;
assign W_out2 = 8'b01010100;
assign W_out3 = 8'b01010001;
assign W_out4 = 8'b00000101;
assign W_out5 = 8'b00011101;
assign W_out6 = 8'b10110001;
assign W_out7 = 8'b01010101;
assign W_out8 = 8'b10001111;
assign W_out9 = 8'b00101000;
assign W_out10 = 8'b11001011;
assign W_out11 = 8'b11111011;
assign W_out12 = 8'b01001110;
assign W_out13 = 8'b00011100;
assign W_out14 = 8'b10010100;
assign W_out15 = 8'b11000001;
assign W_out16 = 8'b00101100;
assign W_out17 = 8'b01010110;
assign W_out18 = 8'b00111000;
assign W_out19 = 8'b10111011;


blk_mem_gen_0 mem(clk, data_sel, address, douta); //calling the ROM module to output the data at chosen address if data_sel == 1

Reservoir r_sc(data_in, clk, Nc, r, v, seed, y_out0, y_out1, y_out2, y_out3, y_out4, y_out5, y_out6, y_out7, y_out8, y_out9, y_out10, y_out11, y_out12, y_out13, y_out14, y_out15, y_out16, y_out17, y_out18, y_out19); //calling the Reservoir module and giving it the input to the system, seed, and configuration parameters to get the output for the system

comp_16bit feed(Nc, eval_counter, lt, gt, eq);//calling the comparator module to check if the counter has reached Nc


Linear_regression train(training, data, y_out0, y_out1, y_out2, y_out3, y_out4, y_out5, y_out6, y_out7, y_out8, y_out9, y_out10, y_out11, y_out12, y_out13, y_out14, y_out15, y_out16, y_out17, y_out18, y_out19,
                                        W_out0, W_out1, W_out2, W_out3, W_out4, W_out5, W_out6, W_out7, W_out8, W_out9, W_out10, W_out11, W_out12, W_out13, W_out14, W_out15, W_out16, W_out17, W_out18, W_out19,
                                        W_out0, W_out1, W_out2, W_out3, W_out4, W_out5, W_out6, W_out7, W_out8, W_out9, W_out10, W_out11, W_out12, W_out13, W_out14, W_out15, W_out16, W_out17, W_out18, W_out19);
                                         

always@(posedge clk)
    begin
        if(reset)
            begin
            address <= 13'b0000000000000; // reset the address if reset is pressed which is another physical switch on the fpga
            end
        if(data_sel) 
            begin
            eval_counter <= eval_counter + 16'b0000000000000001;//if we want to read data from ROM every clk cycle we increment the eval_counter by 1
            if(eq) //when the eval counter is at Nc we feed the reservoir the data from the ROM, increment the adress so next data gets fed next cycle and reset the eval_counter
                begin
                address <= address + 13'b0000000000001; 
                data_in <= douta; 
                eval_counter <= 16'b0000000000000000;
                end  
            end   
        if(!data_sel) //when we want to read data from the outside 
            begin
            data_in <= data;
            end
        if(!training)//if system isnt training output == sum of x_i*w_i
            begin
                y_out <= y_out0*W_out0 + y_out1*W_out1 + y_out2*W_out2 + y_out3*W_out3 + y_out4*W_out4 + y_out5*W_out5 + y_out6*W_out6 + y_out7*W_out7 + y_out8*W_out8 + y_out9*W_out9 + y_out10*W_out10 + y_out11*W_out11 + y_out12*W_out12 + y_out13*W_out13 + y_out14*W_out14 + y_out15*W_out15 + y_out16*W_out16 + y_out17*W_out17 + y_out18*W_out18 + y_out19*W_out19;  
            end      
            
    end
         
         
         
         
endmodule
