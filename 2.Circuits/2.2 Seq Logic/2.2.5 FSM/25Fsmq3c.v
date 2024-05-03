module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    reg [2:0] next_state

    always @(*) begin
        case (y)
            3'b000: begin
                next_state = x?001:000;
                z = 0;
                Y0 = next_state[0];
            end
            3'b001: begin
                next_state = x?100:001;
                z = 0;
                Y0 = next_state[0];
            end
            3'b010: begin
                next_state = x?001:010;
                z = 0;
                Y0 = next_state[0];
            end
            3'b011: begin
                next_state = x?010:011;
                z = 1;
                Y0 = next_state[0];
            end
            3'b100: begin
                next_state = x?100:011;
                z = 1;
                Y0 = next_state[0];
            end
            default: next_state = y;
        endcase
    end
endmodule