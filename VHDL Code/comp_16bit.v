`timescale 1ns / 1ps

module comp_16bit( //16bit comparator using 4 4bit comparators that gives 3 boolean values to tell if the numbers are equal or which one is greater
    input wire [15:0] a, b,
    output wire lt1, gt1, eq1
    );
    
parameter eq = 1'b1;
parameter lt = 1'b0;
parameter gt = 1'b0;

wire t11, t12, t13, t21, t22, t23, t31, t32, t33;

comp_4bit c1(a[3:0], b[3:0], lt, gt, eq, t11, t12, t13);
comp_4bit c2(a[7:4], b[7:4], t11, t12, t13, t21, t22, t23);
comp_4bit c3(a[11:8], b[11:8], t21, t22, t23, t31, t32, t33);
comp_4bit c4(a[15:12], b[15:12], t31, t32, t33, lt1, gt1, eq1);

endmodule
