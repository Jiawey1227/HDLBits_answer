module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter IDLE=4'b0000, S0=4'b0001, S1=4'b0010, S2=4'b0011, S3=4'b0100;
    parameter S4=4'b0101, S5=4'b0110, DISC=4'b1000, FLAG=4'b1001, ERR=4'b1010;

    reg [3:0] state, next_state;

    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            IDLE: next_state = in?S0:IDLE;
            S0:   next_state = in?S1:IDLE;
            S1:   next_state = in?S2:IDLE;
            S2:   next_state = in?S3:IDLE;
            S3:   next_state = in?S4:IDLE;
            S4:   next_state = in?S5:DISC;
            S5:   next_state = in?ERR:FLAG;
            DISC: next_state = in?S0:IDLE;
            FLAG: next_state = in?S0:IDLE;
            ERR:  next_state = in?ERR:IDLE;
            default: next_state = IDLE;
        endcase
    end

    always @(*) begin
        case (state)
            DISC: begin
                disc = 1;
                flag = 0;
                err  = 0;    
            end
            FLAG:begin
                disc = 0;
                flag = 1;
                err  = 0;  
            end
            ERR:begin
                disc = 0;
                flag = 0;
                err  = 1;  
            end
            default: begin
                disc = 0;
                flag = 0;
                err  = 0;  
            end
        endcase
    end


endmodule
