module clock_divider_1hz (
    input  wire clk,       // 12 MHz input clock
    output reg  tick_1hz   // 1-cycle pulse every 1 second
);
    localparam MAX_COUNT = 24'd11999999;   // 12,000,000 - 1
    reg [23:0] counter = 24'd0;

    always @(posedge clk) begin
        if (counter == MAX_COUNT) begin
            counter  <= 24'd0;
            tick_1hz <= 1'b1;
        end else begin
            counter  <= counter + 1'b1;
            tick_1hz <= 1'b0;
        end
    end
endmodule
