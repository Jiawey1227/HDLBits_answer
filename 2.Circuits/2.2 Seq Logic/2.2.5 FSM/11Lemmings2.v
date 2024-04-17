module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah );

    parameter LEFT  = 4'b0001; // state that lemming is walking left
    parameter RIGHT = 4'b0010; // state that lemming is walking right
    parameter FALL_LEFT  = 4'b0100; // state that lemming is falling but before he was walking left
    parameter FALL_RIGHT = 4'b1000; // state that lemming is falling but before he was walking right

    reg [3:0] state, next_state;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin 
            state <= next_state;
        end
    end

   always @(*) begin
        // State transition logic
        case (state)
            LEFT: begin
                if (ground == 1) begin // there is a ground
                    if (bump_left == 1) begin
                        next_state = RIGHT;
                    end else begin
                        next_state = state;
                    end
                end else begin // there is no ground, lemming will fall
                    next_state = FALL_LEFT; 
                end
            end

            RIGHT: begin
                if (ground == 1) begin // there is a ground
                    if (bump_right == 1) begin
                        next_state = LEFT;
                    end else begin
                        next_state = state;
                    end
                end else begin // there is no ground, lemming will fall
                    next_state = FALL_RIGHT; 
                end
            end

            FALL_LEFT: begin
                if (ground == 1) begin
                    next_state = LEFT;
                end else begin
                    next_state = state;
                end
            end

            FALL_RIGHT: begin
                if (ground == 1) begin
                    next_state = RIGHT;
                end else begin
                    next_state = state;
                end
            end
        endcase
    end

    always @(*) begin
        case (state)
            LEFT: begin
                walk_left  = 1;
                walk_right = 0;
                aaah = 0;
            end

            RIGHT: begin
                walk_left  = 0;
                walk_right = 1;
                aaah = 0;
            end

            FALL_LEFT: begin
                walk_left  = 0;
                walk_right = 0;
                aaah = 1;
            end

            FALL_RIGHT: begin
                walk_left  = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule