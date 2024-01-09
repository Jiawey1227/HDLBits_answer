module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] pulse_r1;

    always @(posedge clk) begin
        pulse_r1 <= in;
    end

    always @(posedge clk) begin
        if(reset) begin
            out = 32'd0;
        end
        else begin
            out <= ~in & pulse_r1 | out;
        end
    end
endmodule