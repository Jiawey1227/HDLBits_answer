module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [99:0] cout_wire;
    genvar i;
    generate
        bcd_fadd fadd1(
            .a(a[3:0]),
            .b(b[3:0]),
            .cin(cin),
            .cout(cout_wire[0]),
            .sum(sum[3:0])
        );
        for (i = 4; i <= 399; i = i + 4) begin: bcdadder
            bcd_fadd faddi(
                .a(a[i+3:i]),
                .b(b[i+3:i]),
                .cin(cout_wire[i/4 - 1]),
                .cout(cout_wire[i/4]),
                .sum(sum[i+3:i])
            );
        end
    endgenerate

    assign cout = cout_wire[99];

endmodule

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );

endmodule