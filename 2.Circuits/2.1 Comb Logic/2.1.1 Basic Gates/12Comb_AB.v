module modA ( input x, input y, output z );
    assign z = ~(x ^ y);
endmodule

module modB (input x, input y, output z);
    assign z = (x ^ y) & x;
endmodule

module top_module (
    input x,
    input y,
    output z
);
    wire [1:0] a;
    wire [1:0] b;
    assign z = (b[0] | a[0]) ^ (a[1] & b[1]);
    genvar i;
    generate
        for (i = 0; i < 2; i = i + 1) begin: topmod
            modA A(
                .x(x),
                .y(y),
                .z(a[i])
            );
            modB B(
                .x(x),
                .y(y),
                .z(b[i])
            );
        end
    endgenerate
endmodule