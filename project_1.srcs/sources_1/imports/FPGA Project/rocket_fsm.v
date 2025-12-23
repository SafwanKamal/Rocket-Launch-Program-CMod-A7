module rocket_fsm (
    input  wire       clk,
    input  wire       tick_1hz,
    input  wire       start_pulse,
    input  wire       abort_pulse,
    output reg        launch_led,
    output reg [3:0]  count_digit
);
    localparam CT_INIT   = 2'd0;
    localparam CT_COUNT  = 2'd1;
    localparam CT_LAUNCH = 2'd2;

    reg [1:0] state = CT_INIT;
    reg [3:0] count = 4'd9;

    always @(posedge clk) begin
        case (state)
            CT_INIT: begin
                launch_led <= 1'b0;
                count      <= 4'd9;
                if (start_pulse)
                    state <= CT_COUNT;
            end

            CT_COUNT: begin
                launch_led <= 1'b0;
                if (abort_pulse) begin
                    state <= CT_INIT;
                    count <= 4'd9;
                end else if (tick_1hz) begin
                    if (count != 4'd0)
                        count <= count - 1'b1;
                    else
                        state <= CT_LAUNCH;
                end
            end

            CT_LAUNCH: begin
                launch_led <= 1'b1;
                if (abort_pulse) begin
                    state      <= CT_INIT;
                    count      <= 4'd9;
                    launch_led <= 1'b0;
                end
            end

            default: begin
                state      <= CT_INIT;
                count      <= 4'd9;
                launch_led <= 1'b0;
            end
        endcase
    end

    always @* begin
        count_digit = (state == CT_LAUNCH) ? 4'd0 : count;
    end
endmodule
