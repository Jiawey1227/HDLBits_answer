module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    parameter A = 2'd0;
    parameter B = 2'd1;
    parameter C = 2'd2;
    parameter D = 2'd3;

    reg [1:0] next_state, currunt_state;

    always @(posedge clk) begin
        if(!resetn) begin
            currunt_state <= A;
        end else begin
            currunt_state <= next_state;
        end
    end

    always @(*) begin
        case (currunt_state)
            A: begin
                if(r[1] == 1) begin
                    next_state = B;
                end else begin
                    if(r[2] == 1) begin
                        next_state = C;
                    end else begin
                        if(r[3] == 1) begin
                            next_state = D;
                        end else begin
                            next_state = A;
                        end
                    end
                end
            end

            B: next_state = r[1]?B:A;
            C: next_state = r[2]?C:A;
            D: next_state = r[3]?D:A;
        endcase
    end

    assign g[1] = (currunt_state == B);
    assign g[2] = (currunt_state == C);
    assign g[3] = (currunt_state == D);

endmodule
