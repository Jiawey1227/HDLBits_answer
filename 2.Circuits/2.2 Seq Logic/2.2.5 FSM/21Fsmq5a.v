// To get a serial of 2's complementer
// 1. From lsb to msb, find the first "1"
// 2. The lsb to the first "1" stay the same
// 3. The other reverse
module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter S0 = 0, S1 = 1, S2 = 2;
    reg [1:0] state, next_state;


    assign z = (state == S1); // only in S1, output will be 1

    always @(*) begin
        case(state)
            S0: begin
                if(x == 0) begin // input is 0, output is still 0
                    next_state = S0;
                end else begin // input is 1, output will be 1, becuase it is the first 1
                    next_state = S1; 
                end
            end
            S1: begin
                if(x == 1) begin // input is 1, it's not the first 1, so output will be 0
                    next_state = S2;
                end else begin // input is 0, output is 1, so stays in S1
                    next_state = S1;
                end
            end
            S2: begin
                if(x == 1) begin // input is 1, output is 0, stays in S2
                    next_state = S2;
                end else begin // input is 0, output is 1, trans to S1
                    next_state = S1;
                end
            end
            default: begin
                next_state = state;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset) begin
            state = S0;
        end else begin
            state = next_state;
        end
    end 
endmodule
