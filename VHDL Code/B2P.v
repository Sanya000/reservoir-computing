module B2P( //Binary to pulse stochastic converter using a comparator and random number
    input wire [15:0] binary_in,
    input wire clk,
    output wire pulsed_out
);

wire [15:0] lfsr_out;
wire lfsr_status;
wire lt, gt, eq;

LFSR random_n(clk, 1, {16{1'b0}} , lfsr_out, lfsr_status); // calling the LFSR module to get our pseudo-random number
comp_16bit comp(binary_in, lfsr_out, lt, gt, eq); //calling the comparator module to compare the input number and the LFSR's output

assign pulsed_out = gt ? 1'b1://if the binary input is greater than the pseudo-random number then the output is 1, otherwise 0
                    lt ? 1'b0:
                    eq ? 1'b0:
                         1'b0;

endmodule
