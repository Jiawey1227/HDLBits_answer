module top_module ( 
    input a, 
    input b, 
    input c,
    input d,
    output out1,
    output out2
);
    mod_a mymod(out1, out2, a, b, c, d);
endmodule

module mod_a ( output, output, input, input, input, input );

endmodule