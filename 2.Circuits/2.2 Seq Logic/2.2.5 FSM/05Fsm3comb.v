module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        case (state)
            A: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                if (in) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
        endcase
    end

    // Output logic:  out = f(state) for a Moore state machine
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 0;
            C: out = 0;
            D: out = 1;
        endcase
    end

endmodule