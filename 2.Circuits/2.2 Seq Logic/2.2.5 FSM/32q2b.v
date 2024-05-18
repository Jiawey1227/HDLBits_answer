module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    localparam A  = 4'd0;
    localparam B  = 4'd1;
    localparam C1 = 4'd2;
    localparam C2 = 4'd3;
    localparam C3 = 4'd4;
    localparam D  = 4'd5;
    localparam E  = 4'd6;
    localparam F1 = 4'd7;
    localparam F2 = 4'd8;

    reg [3:0] state, next_state;

    always @(*) begin
        case(state)
            A: next_state = (!resetn)?A:B;
            B: next_state = C1; // set f to 1 for one cycle
            C1: next_state = x?C2:C1; // input 1
            C2: next_state = (~x)?C3:C2; // input 0
            C3: next_state = (x)?D:C1; // input 1, set g to 1
            D:  next_state = y?E:F1; // monitor y, if y=0 transfer to F1
            E:  next_state = E; // set y to 1 permanently
            F1: next_state = y?E:F2; // first cycle y=0, continue monitor
            F2: next_state = F2; // set y to 0 permanently
        endcase
    end

    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            A: begin f = 0; g = 0; end
            B: f = 1;
            C1: f = 0;
            D:  g = 1;
            E:  g = 1;
            F1: g = 1;
            F2: g = 0;
            default: begin f = 0; g = 0; end
        endcase
    end

endmodule