module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

    reg d[3:1];

    mydff mydff1(clk, resetn, in, d[1]);
    mydff mydff2(clk, resetn, d[1], d[2]);
    mydff mydff3(clk, resetn, d[2], d[3]);
    mydff mydff4(clk, resetn, d[3], out);

endmodule

module mydff (
    input clk,
    input resetn,
    input d,
    output q
);
    always @(posedge clk) begin
        if (!resetn) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
endmodule
