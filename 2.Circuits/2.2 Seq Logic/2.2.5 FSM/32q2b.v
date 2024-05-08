module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    always @(*) begin
        case(state)
            A: next_state = (!resetn)?A:B;
            B: next_state = C1; // do nothing
            C1: next_state = x?C2:; // input 1
            C2: next_state = (~x)?C3:; // input 0
            C3: next_state = (x)?D // input 1
        endcase
    end

    assign f = (state == B);

endmodule