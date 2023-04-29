`timescale 1ns / 1ps

module LFSR( //LFSR module to create a pseudo-random 16bit number given a seed
    input wire clk,
    input wire enable,
    input [15:0] seed,
    output [15:0] lfsr_16bits,
    output lfsr_done
    );
    
reg [16:0] r_LFSR = 0;
reg r_XNOR;
    
always@(posedge clk)
    begin
        if(enable == 1'b1)
            begin
                r_LFSR <= seed;
            end
    end

always@(*)
    begin
        case(16)
            3: begin
                r_XNOR = r_LFSR[3] ^~ r_LFSR[2];
            end
            4: begin
                r_XNOR = r_LFSR[4] ^~ r_LFSR[3];
            end
            5: begin
                r_XNOR = r_LFSR[5] ^~ r_LFSR[3];
            end
            6: begin
                r_XNOR = r_LFSR[6] ^~ r_LFSR[5];
            end
            7: begin
                r_XNOR = r_LFSR[7] ^~ r_LFSR[6];
            end
            8: begin
                r_XNOR = r_LFSR[8] ^~ r_LFSR[6] ^~ r_LFSR[5] ^~ r_LFSR[4];
            end
            9: begin
                r_XNOR = r_LFSR[9] ^~ r_LFSR[5];
            end
            10: begin
                r_XNOR = r_LFSR[10] ^~ r_LFSR[7];
            end
            11: begin
                r_XNOR = r_LFSR[11] ^~ r_LFSR[9];
            end
            12: begin
                r_XNOR = r_LFSR[12] ^~ r_LFSR[6] ^~ r_LFSR[4] ^~ r_LFSR[1];
            end
            13: begin
                r_XNOR = r_LFSR[13] ^~ r_LFSR[4] ^~ r_LFSR[3] ^~ r_LFSR[1];
            end
            14: begin
                r_XNOR = r_LFSR[14] ^~ r_LFSR[5] ^~ r_LFSR[3] ^~ r_LFSR[1];
            end
            15: begin
                r_XNOR = r_LFSR[15] ^~ r_LFSR[14];
            end
            16: begin
                r_XNOR = r_LFSR[16] ^~ r_LFSR[15] ^~ r_LFSR[13] ^~ r_LFSR[4];
            end
            17: begin
                r_XNOR = r_LFSR[17] ^~ r_LFSR[14];
            end
            18: begin
                r_XNOR = r_LFSR[18] ^~ r_LFSR[11];
            end
            19: begin
                r_XNOR = r_LFSR[19] ^~ r_LFSR[6] ^~ r_LFSR[2] ^~ r_LFSR[1];
            end
            20: begin
                r_XNOR = r_LFSR[20] ^~ r_LFSR[17];
            end
            21: begin
                r_XNOR = r_LFSR[21] ^~ r_LFSR[19];
            end
            22: begin
                r_XNOR = r_LFSR[22] ^~ r_LFSR[21];
            end
            23: begin
                r_XNOR = r_LFSR[23] ^~ r_LFSR[18];
            end
            24: begin
                r_XNOR = r_LFSR[24] ^~ r_LFSR[23] ^~ r_LFSR[22] ^~ r_LFSR[17];
            end
            25: begin
                r_XNOR = r_LFSR[25] ^~ r_LFSR[22];
            end
            26: begin
                r_XNOR = r_LFSR[26] ^~ r_LFSR[6] ^~ r_LFSR[2] ^~ r_LFSR[1];
            end
            27: begin
                r_XNOR = r_LFSR[27] ^~ r_LFSR[5] ^~ r_LFSR[2] ^~ r_LFSR[1];
            end
            28: begin
                r_XNOR = r_LFSR[28] ^~ r_LFSR[25];
            end
                29: begin
                r_XNOR = r_LFSR[29] ^~ r_LFSR[27];
            end
            30: begin
                r_XNOR = r_LFSR[30] ^~ r_LFSR[6] ^~ r_LFSR[4] ^~ r_LFSR[1];
            end
            31: begin
                r_XNOR = r_LFSR[31] ^~ r_LFSR[28];
            end
            32: begin
                r_XNOR = r_LFSR[32] ^~ r_LFSR[22] ^~ r_LFSR[2] ^~ r_LFSR[1]; 
            end
            
        endcase
    end

assign lfsr_16bits = r_LFSR[16:1];

assign lfsr_done = (r_LFSR[16:1] == seed) ? 1'b1 : 1'b0;
       
endmodule
