module top_module ( input a, input b, output out );
    mod_a mymod(
        .out(out),
        .in1(a),
        .in2(b)
    );
endmodule

module mod_a (input in1, input in2, output out);
endmodule