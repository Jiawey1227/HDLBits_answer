// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
	parameter A=1'b0, B=1'b1;
    reg present_state, next_state;

    // always @(posedge clk) begin
    //     if (reset) begin  
    //         // Fill in reset logic
    //         present_state = B;
    //         out <= 1'b1;
    //     end 
    //     else begin
    //         case (present_state)
    //             // Fill in state transition logic
    //             A: next_state = in? A:B;
    //         	B: next_state = in? B:A;
    //         endcase

    //         // State flip-flops
    //         present_state = next_state;   

    //         case (present_state)
    //             // Fill in output logic
    //             B: out <= 1'b1;
    //             A: out <= 1'b0;
    //         endcase
    //     end
    // end

    // use 3-stage FSM
    always @(posedge clk) begin
        if (reset) begin
            present_state <= B;
        end
        else begin
            present_state <= next_state;
        end
    end

    always @(*) begin
        case (present_state)
            A: begin
                if (in) begin
                    next_state = A;
                end
                else begin 
                    next_state = B;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                end
                else begin
                    next_state = A
                end
            end
            default: next_state = present_state;
        endcase
    end

    assign out = (state == B);
endmodule