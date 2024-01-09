// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );

    always @(*) begin
        casez (in)
            4'bzzz1:begin
                pos = 2'd0;
            end 
            4'bzz10:begin
                pos = 2'd1;
            end
            4'bz100:begin
                pos = 2'd2;
            end
            4'b1000:begin
                pos = 2'd3;
            end
            default: pos = 2'd0; 
        endcase
    end

endmodule
