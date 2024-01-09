module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire carry;
    add16 add1(.a(a[15:0]), .b(b[15:0]), .sum(sum[15:0]), .cin(1'b0), .cout(carry));
    add16 add2(.a(a[31:16]), .b(b[31:16]), .sum(sum[31:16]), .cin(carry), .cout());

endmodule

module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );

endmodule