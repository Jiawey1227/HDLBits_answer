module top_module( 
    input [254:0] in,
    output [7:0] out );
    reg [7:0] temp_out;
    
    integer i;
    always @(*) begin
        for (i = 0; i <= 254; i = i + 1) begin
            if (in[i]) begin
                temp_out = temp_out + 1;
            end
            else begin
                temp_out = temp_out;
            end
        end
    end
    assign out = temp_out;
endmodule