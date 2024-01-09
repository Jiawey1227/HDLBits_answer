module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    assign s = a + b;
    // a = 3'b011 // 3
    // b = 3'b001 // 1
    // a + b = 3'b100 // -4 overflow

    // a = 3'b111 // -1
    // b = 3'b100 // -4
    // a + b = 3'b011 // 3 overflow

    // a = 3'b001 // 1
    // b = 3'b100 // -4 never overflow

    assign overflow = a[7] & b[7] & ~s[7] | ~a[7] & ~b[7] & s[7];
endmodule