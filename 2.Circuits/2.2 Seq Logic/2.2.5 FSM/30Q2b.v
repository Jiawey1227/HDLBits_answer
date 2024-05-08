module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;
    parameter E = 4;
    parameter F = 5;

    assign Y1 = w & y[A];
    assign Y3 = (~w)&y[B] || (~w)&y[C] || (~w)&y[E] || (~w)&y[F];

endmodule