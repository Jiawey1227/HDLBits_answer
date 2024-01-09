module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);

    always @(posedge clk ) begin
        casez ({E, L})
            2'b00: begin
                Q <= Q;
            end 
            2'bz1: begin
                Q <= R;
            end
            2'b10: begin
                Q <= w;
            end
            default: Q <= 1'b0;
        endcase
    end

endmodule
