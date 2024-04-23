module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter s0=0, s1=1, s2=2, s3=3;
    wire[1:0] state, next;
    
    // State transition logic (combinational)
    always@(*)begin
        case(state)
            s0: next = in[3]? s1:s0;
            s1: next = s2;
            s2: next = s3;
            s3: next = in[3]? s1:s0;
        endcase
    end

    // State flip-flops (sequential)
    always@(posedge clk)begin
        if(reset)
            state <= s0;
        else
            state <= next;
    end
 
    // Output logic
    assign done = (state == s3);

    // New: Datapath to store incoming bytes.
    always@(posedge clk)begin
        case(state)
            s0: out_bytes[23:16] <= in;
            s1: out_bytes[15:8] <= in;
            s2: out_bytes[7:0] <= in;
            s3: out_bytes[23:16] <= in;
        endcase
    end

endmodule