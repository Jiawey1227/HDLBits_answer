module top_module (
    input [3:1] y,
    input w,
    output Y2);

    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
    reg [3:1] Next_state; 

    always @(*) begin
        case(y)
            A: Y = w? A:B;
            B: Y = w? D:C;
            C: Y = w? D:E;
            D: Y = w? A:F;
            E: Y = w? D:E;
            F: Y = w? D:C;
        endcase
    end

    assign Y2 = Next_state[2];

endmodule