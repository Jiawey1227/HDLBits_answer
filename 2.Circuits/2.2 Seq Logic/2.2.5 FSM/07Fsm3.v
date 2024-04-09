module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    parameter A = 4'b0001;
    parameter B = 4'b0010; 
    parameter C = 4'b0100;
    parameter D = 4'b1000;
    reg [3:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in == 1) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end            
            B: begin
                if (in == 1) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                if (in == 1) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                if (in == 1) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset == 1) begin
            state <= A; 
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    // always @(*) begin
    //     case (state)
    //         A: out = 0;            
    //         B: out = 0;
    //         C: out = 0;
    //         D: out = 1;            
    //     endcase
    // end
    assign out = (state == D);

endmodule