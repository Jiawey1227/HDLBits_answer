module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT  = 6'b000_001; // state that lemming is walking left
    parameter RIGHT = 6'b000_010; // state that lemming is walking right
    parameter FALL_LEFT  = 6'b000_100; // state that lemming is falling but before he was walking left
    parameter FALL_RIGHT = 6'b001_000; // state that lemming is falling but before he was walking right
    parameter DIGGING_LEFT  = 6'b010_000;
    parameter DIGGING_RIGHT = 6'b100_000;

    reg [5:0] state, next_state;

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
                    if (dig == 1) begin
                        next_state = DIGGING_LEFT; // start digging
                    end else begin
                        if (bump_left == 1) begin
                            next_state = RIGHT;
                        end else begin
                            next_state = state;
                        end
                    end
                end else begin // there is no ground, lemming will fall
                        next_state = FALL_LEFT; 
                end
            end

            RIGHT: begin
                if (ground == 1) begin // there is a ground
                    if (dig == 1) begin
                        next_state = DIGGING_RIGHT;
                    end else begin
                        if (bump_right == 1) begin
                            next_state = LEFT;
                        end else begin
                            next_state = state;
                        end
                    end
                end else begin // there is no ground, lemming will fall
                    next_state = FALL_RIGHT; 
                end
            end

            DIGGING_LEFT: begin
                if (ground == 0) begin
                    next_state = FALL_LEFT;
                end else begin
                    next_state = state;
                end
            end

            DIGGING_RIGHT: begin
                if (ground == 0) begin
                    next_state = FALL_RIGHT;
                end else begin
                    next_state = state;
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
                digging = 0;
            end

            RIGHT: begin
                walk_left  = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end

            FALL_LEFT: begin
                walk_left  = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end

            FALL_RIGHT: begin
                walk_left  = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end

            DIGGING_RIGHT: begin
                walk_left  = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end

            DIGGING_LEFT: begin
                walk_left  = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
        endcase
    end

endmodule