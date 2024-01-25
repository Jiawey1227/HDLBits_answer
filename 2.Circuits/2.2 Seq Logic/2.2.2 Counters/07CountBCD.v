module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[7:4] == 4'd9 && ena[1]);
    assign ena[3] = (q[11:8] == 4'd9 && ena[2]);

	counter counter0(clk, reset, 1'b1, q[3:0]);
    counter counter1(clk, reset, ena[1], q[7:4]);
    counter counter2(clk, reset, ena[2], q[11:8]);
    counter counter3(clk, reset, ena[3], q[15:12]);


endmodule

module counter (
    input clk,
    input reset,
    input en,        
    output [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else if (en) begin
            if (q == 4'd9) begin
                q <= 0;
            end
            else begin
                q <= q + 4'd1;
            end
        end
    end

endmodule
