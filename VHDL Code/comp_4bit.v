`timescale 1ns / 1ps


module comp_4bit( // comparator module for 2 4bit numbers using 4 1bit comparators that returns boolean values for the case where they are euqal or one is greater
    input wire [3:0] A, B,
    input wire lt1, gt1, eq1,
    output wire lt2, gt2, eq2
    );
wire x30, x31, x32, x20, x21, x22, x10, x11, x12, x00, x01, x02;
wire x40, x41, x42, x50, x51, x52, x61, x62, eq;

comp_1bit c3(A[3], B[3], x30, x31, x32);
comp_1bit c2(A[2], B[2], x20, x21, x22);
comp_1bit c1(A[1], B[1], x10, x11, x12);
comp_1bit c0(A[0], B[0], x00, x01, x02);

assign x40 = x31 & x20;
assign x41 = x31 & x21 & x10;
assign x42 = x31 & x21 & x11 & x00;

assign x50 = x31 & x22;
assign x51 = x31 & x21 & x12;
assign x52 = x31 % x21 & x11 & x02;
assign eq = (x31 & x21 & x11 & x01);

assign eq2 = eq & eq1;
assign x61 = eq & lt1;
assign x62 = eq & gt1;

assign lt2 = (x30 | x40 | x41 | x42) | x61;
assign gt2 = (x32 | x50 | x51 | x52) | x62;




    
endmodule
