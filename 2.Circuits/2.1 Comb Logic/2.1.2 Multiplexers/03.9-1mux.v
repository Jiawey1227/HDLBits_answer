module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );

    reg [15:0] temp_out;
    assign out = temp_out;
    always @(*) begin
        case (sel)
            4'd0:begin
                temp_out = a;
            end
            4'd1:begin
                temp_out = b;
            end
            4'd2:begin
                temp_out = c;
            end
            4'd3:begin
                temp_out = d;
            end
            4'd4:begin
                temp_out = e;
            end
            4'd5:begin
                temp_out = f;
            end
            4'd6:begin
                temp_out = g;
            end
            4'd7:begin
                temp_out = h;
            end
            4'd8:begin
                temp_out = i;
            end
            default:begin
                temp_out = 16'b1111_1111_1111_1111;
            end
        endcase
    end

endmodule