module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    parameter E = 3'd4;
    parameter F = 3'd5;

    reg [2:0] currunt_state, next_state;

    always @(posedge clk) begin
        if(reset) begin
            currunt_state <= A;
        end else begin
            currunt_state <= next_state;
        end
    end

    always @(*) begin
        case (currunt_state)
            A: next_state = w?A:B;
            B: next_state = w?D:C;
            C: next_state = w?D:E;
            D: next_state = w?A:F;
            E: next_state = w?D:E;
            F: next_state = w?D:C;
        endcase
    end

    assign z = (currunt_state == E || currunt_state == F);

endmodule