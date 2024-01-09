module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire sel;
    wire [15:0] sum1, sum2;
    add16 myadd1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .cout(sel),
        .sum(sum[15:0])
    );
    add16 myadd2(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .cout(),
        .sum(sum1)
    );
    add16 myadd3(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .cout(),
        .sum(sum2)
    );

    always @(*) begin
        case(sel)
            1'b0:begin
                sum[31:16] = sum1;
            end
            1'b1:begin
                sum[31:16] = sum2;
            end
        endcase
    end
endmodule

module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
endmodule