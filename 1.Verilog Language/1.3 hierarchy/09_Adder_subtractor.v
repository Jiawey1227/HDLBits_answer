module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire cout;
    wire [31:0] xor_b;
    assign xor_b = b ^ {32{sub}};
    add16 myadd1(
        .a(a[15:0]),
        .b(xor_b[15:0]),
        .cin(sub),
        .cout(cout),
        .sum(sum[15:0])
    );
    add16 myadd2(
        .a(a[31:16]),
        .b(xor_b[31:16]),
        .cin(cout),
        .cout(),
        .sum(sum[31:16])
    )
endmodule

module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
endmodule