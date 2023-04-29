`timescale 1ns / 1ps

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
