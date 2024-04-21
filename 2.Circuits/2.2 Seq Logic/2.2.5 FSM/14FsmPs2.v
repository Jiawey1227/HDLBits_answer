module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter READY  = 2'b00;
    parameter START0 = 2'b01;
    parameter START1 = 2'b10;
    parameter DONE   = 2'b11;

    wire [1:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            READY: next_state = in[3]?START0:READY;

            START0: next_state = START1;
            
            START1: next_state = DONE;

            DONE: next_state = in[3]?START0:READY;

        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset) begin
            state <= READY;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign done = (state == DONE);

endmodule