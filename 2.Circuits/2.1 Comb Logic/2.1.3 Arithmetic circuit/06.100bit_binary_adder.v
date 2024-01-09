module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );

    wire [99:0] temp_cout;
    assign cout = temp_cout[99];
    Fadder adder1(a[0], b[0], cin, temp_cout[0], sum[0]);

    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin: adder100
            Fadder adderi(a[i], b[i], cout[i-1], cout[i], sum[i]);
        end
    endgenerate

endmodule

module Fadder( 
    input a, b, cin,
    output cout, sum );

    assign {cout, sum} = a + b + cin;

endmodule