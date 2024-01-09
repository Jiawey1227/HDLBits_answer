module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] pulse_r1, pulse_r2;

    always @(posedge clk) begin
        pulse_r1 <= in;
        pulse_r2 <= pulse_r1;
    end

    assign anyedge = pulse_r1 ^ pulse_r2;

endmodule