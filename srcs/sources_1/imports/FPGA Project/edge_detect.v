// This had an issue of The count down starting on the initial power-up.
// I hypothesize 

//module edge_detect (
//    input  wire clk,
//    input  wire btn_in,      // synchronous, active-high
//    output reg  btn_pulse    // 1-clock pulse on rising edge
//);
//    reg sync_0 = 1'b0;
//    reg sync_1 = 1'b0;

//    always @(posedge clk) begin
//        sync_0    <= btn_in;
//        sync_1    <= sync_0;
//        btn_pulse <= sync_0 & ~sync_1;
//    end
//endmodule

module edge_detect (
    input  wire clk,
    input  wire btn_in,      
    output reg  btn_pulse    // 1-clock pulse on rising edge
);
    // Synchronizer registers - initialized to idle state (btn_in = 0 when idle)
    reg sync_0 = 1'b0;
    reg sync_1 = 1'b0;

    // Warmup counter to ignore garbage at startup
    reg [15:0] warmup = 16'd0;

    // Armed becomes 1 only after warmup has fully saturated
    wire armed = &warmup;   // when all bits are 1 → armed = 1

    always @(posedge clk) begin
        // Warmup increments until all bits are 1
        if (!armed)
            warmup <= warmup + 16'd1;

        // Standard two-stage synchronizer
        sync_0 <= btn_in;
        sync_1 <= sync_0;

        // Only generate edge pulse once warmup has completed
        btn_pulse <= armed && (sync_0 & ~sync_1);
    end
endmodule
