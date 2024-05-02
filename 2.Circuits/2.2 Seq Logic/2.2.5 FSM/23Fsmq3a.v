module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A    = 9'b0000_0000_1, 
    parameter B0   = 9'b0000_0001_0, 
    parameter B1_0 = 9'b0000_0010_0, 
    parameter B1_1 = 9'b0000_0100_0, 
    parameter B2_0 = 9'b0000_1000_0, 
    parameter B2_1 = 9'b0001_0000_0, 
    parameter B2_2 = 9'b0010_0000_0, 
    parameter BS   = 9'b0100_0000_0, 
    parameter BF   = 9'b1000_0000_0;
    
    reg [8:0] state, next_state;

    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end

    always @(*) begin
        case (state)
            A: next_state = s?B0:A;
            B0: next_state = w?B1_1:B1_0;
            B1_1: next_state = w?B2_2:B2_1;
            B1_0: next_state = w?B2_1:B2_0;
            B2_2: next_state = w?BF:BS;
            B2_1: next_state = w?BS:BF;
            B2_0: next_state = BF;
            BF: next_state = w?B1_1:B1_0;
            BS: next_state = w?B1_1:B1_0;
        endcase
    end

    // assign z = (state == BS);
    always @(*) begin
        if(state == BS) z = 1;
        else z = 0;
    end
endmodule