module top_module(
    input a,
    input b,
    input c,
    output out  ); 

    assign out = a | ~a & b | ~a & ~b & c;

endmodule