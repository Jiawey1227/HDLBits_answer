module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter WAIT = 0;
    parameter START = 1
    parameter S0 = 1;
    parameter S1 = 2;
    parameter S2 = 3;
    parameter S3 = 4;
    parameter S4 = 5;
    parameter S5 = 6;
    parameter S6 = 7;
    parameter S7 = 8;
    parameter STOP = 9
    parameter ERROR = 10;
    parameter DONE1 = 11;
    parameter DONE2 = 13;

    reg [3:0] state, next_state;

    always @(posedge clk) begin
        if(reset) begin
            state <= WAIT;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            WAIT: next_state = in?WAIT:START;
            START: next_state = S0;
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S8;
            S8: next_state = in?STOP:ERROR;
            STOP: next_state = in?DONE1:DONE2;
            DONE1: next_state = in?WAIT:START;
            DONE2: next_state = S0;
        endcase
    end
    assign done = (state == DONE);



endmodule