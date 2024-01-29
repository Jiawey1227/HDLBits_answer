module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    reg [7:0] Q;

    myregister shiftregister(clk, S, enable, Q);

    always @(*) begin
        case ({A, B, C})
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0;
        endcase
    end

endmodule

module mydff (
    input clk,
    input ena,
    input d,
    output q
);
    always @(posedge clk) begin
        if (ena) begin
            q <= d;
        end
    end
endmodule

module myregister (
    input clk,
    input S,
    input ena,
    output [7:0] Q
);

    mydff mydff1(clk, ena, S, Q[0]);
    mydff mydff2(clk, ena, Q[0], Q[1]);
    mydff mydff3(clk, ena, Q[1], Q[2]);
    mydff mydff4(clk, ena, Q[2], Q[3]);
    mydff mydff5(clk, ena, Q[3], Q[4]);
    mydff mydff6(clk, ena, Q[4], Q[5]);
    mydff mydff7(clk, ena, Q[5], Q[6]);
    mydff mydff8(clk, ena, Q[6], Q[7]);

endmodule