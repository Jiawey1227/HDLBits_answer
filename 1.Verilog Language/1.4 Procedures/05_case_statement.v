// synthesis verilog_input_version verilog_2001
module top_module ( 
    input [2:0] sel, 
    input [3:0] data0,
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    output reg [3:0] out   );//

    always@(*) begin  // This is a combinational circuit
        case(sel)
            3'd0:begin
                out = data0;
            end
            3'd1:begin
                out = data1;
            end
            3'd2:begin
                out = data2;
            end
            3'd3:begin
                out = data3;
            end
            3'd4:begin
                out = data4;
            end
            3'd5:begin
                out = data5;
            end
            default:begin
                out = 3'b000;
            end
        endcase
    end

endmodule