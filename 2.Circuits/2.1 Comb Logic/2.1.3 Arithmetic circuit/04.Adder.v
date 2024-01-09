module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    wire [3:0] cout;
    assign sum[4] = cout[4];
    Fadder adder1(
        .a(x[0]),
        .b(y[0]),
        .cin(),
        .cout(cout[0]),
        .sum(sum[0])
    )
    
    genvar i;
    generate
        for (i = 1; i < 4; i = i + 1) begin: Adder
            Fadder adderi(
                .a(x[i]),
                .b(y[i]),
                .cin(cout[i-1]),
                .cout(cout[i]),
                .sum(sum[i])
            )
        end
    endgenerate
endmodule

module Fadder( 
    input a, b, cin,
    output cout, sum );

    assign {cout, sum} = a + b + cin;

endmodule