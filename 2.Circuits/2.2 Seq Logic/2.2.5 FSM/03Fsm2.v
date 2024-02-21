module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out);

    parameter OFF = 2'b01;
    parameter ON  = 2'b10;

    reg [1:0] present_state, next_state;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            present_state <= OFF;
        end
        else begin
            present_state <= next_state;
        end
    end

    always @(*) begin
        case (present_state)
            ON: begin
                if (k) begin
                    next_state = OFF;
                end
                else begin
                    next_state = ON;
                end
            end

            OFF: begin
                if (j) begin
                    next_state = ON;
                end
                else begin
                    next_state = OFF;
                end
            end
            default: begin
                next_state = present_state;
            end
        endcase
    end

    always @(*) begin
        case (present_state)
            ON:  out = 1;
            OFF: out = 0;
            default: out = 0;
        endcase
    end
        
    
endmodule