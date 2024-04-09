module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    parameter LEFT  = 1'b0;
    parameter RIGHT = 1'b1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        if (bump_left == 1 & bump_right == 0) begin
            next_state = RIGHT;
        end else if (bump_right == 1 & bump_left == 0 ) begin
            next_state = LEFT;
        end else if (bump_left == 1 & bump_right == 1) begin
            next_state = ~state;
        end else begin
            next_state = state;
        end
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left  = (state == LEFT);
    assign walk_right = ~walk_left;

endmodule
