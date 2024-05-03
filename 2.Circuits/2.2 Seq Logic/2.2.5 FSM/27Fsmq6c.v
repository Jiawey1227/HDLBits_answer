module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    parameter A = 1;
    parameter B = 2;
    parameter C = 3;
    parameter D = 4;
    parameter E = 5;
    parameter F = 6;

    wire [6:1] NEXT_Y;

    assign NEXT_Y[A] = (y[A] & w) | (y[D] & w);  
    assign NEXT_Y[B] = y[A] & (~w);
    assign NEXT_Y[C] = (y[B] & (~w)) | (y[F] & (~w));
    assign NEXT_Y[D] = (y[B] & w) | (y[C] & w) | (y[E] & w) | (y[F] & w);
    assign NEXT_Y[E] = (y[C] & (~w)) | (y[E] & (~w));
    assign NEXT_Y[F] = y[D] & (~w);

    assign Y2 = NEXT_Y[2];
    assign Y4 = NEXT_Y[4];

endmodule