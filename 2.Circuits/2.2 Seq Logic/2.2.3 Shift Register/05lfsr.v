module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    lfsr my_lfsr(SW, KEY[0], KEY[1], LEDR);

endmodule

module lfsr(
    input [2:0] r,
    input clk,
    input L,
    output reg [2:0] Q,
);
    wire [2:0] D;
    assign D[0] = L?r[0]:Q[2];
    assign D[1] = L?r[1]:Q[0];
    assign D[2] = L?r[2]:(Q[1]^Q[2]);

    always @(posedge clk) begin
        Q <= D;
    end
    
endmodule