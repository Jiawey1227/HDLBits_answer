module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] a, b, c;
    my_dff8 d1(
        .clk(clk),
        .d(d),
        .q(a)
    );
    my_dff8 d2(
        .clk(clk),
        .d(a),
        .q(b)
    );
    my_dff8 d3(
        .clk(clk),
        .d(b),
        .q(c)
    );
    always @(*) begin
        case(sel)
            2'b00:begin
                q = d;
            end
            2'b01:begin
                q = a;
            end
            2'b10:begin
                q = b;
            end
            2'b11:begin
                q = c;
            end
        endcase
    end
endmodule

module my_dff8 ( input clk, input [7:0] d, output [7:0] q );
endmodule
