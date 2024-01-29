module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 

    always @(posedge clk) begin
        if (load) begin // synchronous load
            q <= data;
        end
        else if (ena) begin
            case (amount)
                2'b00: q <= {q[62:0], 1'b0};  // arithmetic left shift 1 bit
                2'b01: q <= {q[55:0], 8'h00}; // arithmetic left shift 8 bits
                2'b10: q <= {q[63], q[63:1]};      // arithmetic right shift 1 bts
                2'b11: q <= {{8{q[63]}}, q[63:8]}; // arithmetic right shift 8 bits
                default: q <= q;
            endcase
        end
    end

endmodule