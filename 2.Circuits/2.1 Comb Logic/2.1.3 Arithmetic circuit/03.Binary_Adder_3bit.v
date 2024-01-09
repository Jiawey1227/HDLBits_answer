module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

    Fadder fadder1(a[0], b[0], cin, cout[0], sum[0]);
    genvar i;
    generate
        for (i = 1; i < 3; i = i + 1) begin: adder3
            Fadder fadderi(a[i], b[i], cout[i-1], cout[i], sum[i]);
        end
    endgenerate

endmodule

module Fadder( 
    input a, b, cin,
    output cout, sum );

    assign {cout, sum} = a + b + cin;

endmodule