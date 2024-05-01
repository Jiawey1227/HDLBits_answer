module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter S0 = 0; // first state, until find the first 1, output is same as input
    parameter S1 = 1; // second state, output reverse
    reg state, next_state;

    always @(*) begin
        case(state)
            S0: z = x?1:0;
            S1: z = x?0:1;
            default: z = 0;
        endcase
    end

    always @(*) begin
        case(state)
            S0: next_state = x?S1:S0;
            S1: next_state = state;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset) state <= S0;
        else state <= next_state;
    end
endmodule