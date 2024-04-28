module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    parameter IDLE = 0;
    parameter S0 = 1;
    parameter S1 = 2;
    parameter S2 = 3;
    parameter S3 = 4;
    parameter S4 = 5;
    parameter S5 = 6;
    parameter S6 = 7;
    parameter S7 = 8;
    parameter PARITY = 9;
    parameter STOP = 10;
    parameter ERROR = 11;
    parameter DONE = 12; 

    reg [3:0] state, next_state;
    reg odd;
    wire reset_parity;
    

    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            IDLE: next_state = in?IDLE:S0;
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = PARITY;
            PARITY: next_state = STOP;
            STOP: next_state = in?DONE:ERROR;
            DONE: next_state = in?IDLE:S0;
            ERROR: next_state = in?IDLE:ERROR;
        endcase
    end
    assign done = (state == DONE) && (odd == 0);

    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        case (state)
            S0: out_byte[0] <= in;
            S1: out_byte[1] <= in;
            S2: out_byte[2] <= in;
            S3: out_byte[3] <= in;
            S4: out_byte[4] <= in;
            S5: out_byte[5] <= in;
            S6: out_byte[6] <= in;
            S7: out_byte[7] <= in;
            default: out_byte <= out_byte;
        endcase
    end

    // New: Add parity checking.
    always @(*) begin
        if(state == IDLE || state == DONE) begin
            reset_parity = 1;
        end else begin
            reset_parity = 0;
        end
    end
    parity my_parity(
        .clk(clk),
        .reset(reset_parity),
        .in(in),
        .odd(odd)
    );

endmodule