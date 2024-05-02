module top_module(
    input clk,
    input reset,
    input x,
    output z
);

    reg [2:0] Present_state, Next_state;

    always @(posedge clk) begin
        if(reset) Present_state <= 3'b000;
        else Present_state <= Next_state;
    end

    always @(*) begin
        case (Present_state)
            3'b000: Next_state = x?3'b001:3'b000;
            3'b001: Next_state = x?3'b100:3'b001;
            3'b010: Next_state = x?3'b001:3'b010;
            3'b011: Next_state = x?3'b010:3'b001;
            3'b100: Next_state = x?3'b100:3'b011;
            default: Next_state = Present_state;
        endcase
    end

    assign z = (Present_state == 3'b011 || Present_state == 3'b100);

endmodule