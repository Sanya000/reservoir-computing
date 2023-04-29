`timescale 1ns / 1ps

module Activation_function(//3piecewise linear approximation of the tanh function
    input wire [16:0] x,
	output wire [15:0] f
);


assign f = func_tanh(x);

function [15: 0] func_tanh(input [16:0] x_in_func);
	begin
		if( $signed(x_in_func) > $signed({1'b0, 16'h7FFF}))begin
			func_tanh = 16'h7FFF;
		end else if( $signed(x_in_func) < $signed({1'b1, 16'h8000}))begin
			func_tanh = $signed(16'h8000);
		end else begin
			func_tanh = $signed({x_in_func[16], x_in_func[14:0]});
		end
	end
endfunction

endmodule
