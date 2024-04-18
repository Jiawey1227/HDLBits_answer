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

    parameter LEFT  = 7'b0000_001; // state that lemming is walking left
    parameter RIGHT = 7'b0000_010; // state that lemming is walking right
    parameter FALL_LEFT  = 7'b0000_100; // state that lemming is falling but before he was walking left
    parameter FALL_RIGHT = 7'b0001_000; // state that lemming is falling but before he was walking right
    parameter DIGGING_LEFT  = 7'b0010_000;
    parameter DIGGING_RIGHT = 7'b0100_000;
    parameter SPLATTER = 7'b1000_000;

    reg [6:0] state, next_state;
    reg [4:0] counter;
    reg flag;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            counter <= 0;
        end else begin
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                if (counter == 19) flag <= 1; 
                else counter <= counter + 1;
            end else begin
                counter <= 0;
                flag <= 0;
            end
        end
    end

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
                    if (flag) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = LEFT
                    end
                end else begin
                    next_state = state;
                end
            end

            FALL_RIGHT: begin
                if (ground == 1) begin
                    if (flag) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = RIGHT;
                    end
                end else begin
                    next_state = state;
                end
            end

            SPLATTER: begin
                next_state = state;
            end
        endcase
    end

    always @(*) begin
        case (state)
            SPLATTER: begin
                walk_left  = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end

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