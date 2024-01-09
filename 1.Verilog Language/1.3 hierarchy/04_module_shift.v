module top_module ( input clk, input d, output q );
    wire a, b;

    my_dff dff1 (
        .clk(clk),
        .d(d),
        .q(a)
    );
    my_dff dff2 (
        .clk(clk),
        .d(a),
        .q(b)
    )
    my_dff dff3 (
        .clk(clk),
        .d(b),
        .q(q)
    )
endmodule

module my_dff ( input clk, input d, output q );
endmodule