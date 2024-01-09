module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );

endmodule

module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [3:0] temp_cout;
    assign cout = temp_cout[3];

    bcd_fadd adder1(a[3:0], b[3:0], cin, temp_cout[0], sum[3:0]);

    genvar i;
    generate
        for(i = 0; i < 16; i = i + 4) begin: bcdadder
            bcd_fadd adderi(
                .a(a[i+3:i]),
                .b(b[i+3:i]),
                .cin(temp_cout[i/4 - 1]),
                .cout(temp_cout[i/4]),
                .sum(sum[i+3:i])
            )
        end
    endgenerate

endmodule