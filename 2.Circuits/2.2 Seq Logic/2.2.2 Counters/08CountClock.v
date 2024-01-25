module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    always @(posedge clk) begin
        if (reset) begin
            pm = 1'b0;
            hh = 8'h12;
            mm = 8'h00;
            ss = 8'h00;
        end
        else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h12) begin
                        hh <= 8'h01;
                    end
                    else begin
                        if (hh[3:0] == 4'h9) hh <= hh + 8'h7;
                        else hh <= hh + 1'h1;
                        pm <= (hh == 8'h11) ^ (pm);
                    end
                end
                else begin
                    if (mm[3:0] == 4'h9) mm <= mm + 8'h7;
                    else mm <= mm + 1'h1;
                end
            end
            else begin
                if (ss[3:0] == 4'h9) ss <= ss + 8'h7;
                else ss <= ss + 1'h1;
            end
        end
    end

endmodule