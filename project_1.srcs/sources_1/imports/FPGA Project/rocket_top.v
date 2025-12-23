module rocket_top (
    input  wire       clk,        // 12 MHz
    input  wire       btn_start,  // DIP 33, active-LOW when pressed
    input  wire       btn_abort,  // DIP 32, active-LOW when pressed
    output wire       led_launch, // DIP 34, external LED
    output wire [6:0] seg         // DIP 1..7, active-LOW segments
);
    wire tick_1hz;
    wire start_pulse;
    wire abort_pulse;
    wire [3:0] digit;
    wire led_int;

    // Clock divider
    clock_divider_1hz u_div (
        .clk      (clk),
        .tick_1hz (tick_1hz)
    );

    // Buttons are active-LOW -> invert before edge detection
    edge_detect u_ed_start (
        .clk       (clk),
        .btn_in    (~btn_start),   // goes 0->1 when button is pressed
        .btn_pulse (start_pulse)
    );

    edge_detect u_ed_abort (
        .clk       (clk),
        .btn_in    (~btn_abort),
        .btn_pulse (abort_pulse)
    );

    // FSM
    rocket_fsm u_fsm (
        .clk         (clk),
        .tick_1hz    (tick_1hz),
        .start_pulse (start_pulse),
        .abort_pulse (abort_pulse),
        .launch_led  (led_int),
        .count_digit (digit)
    );

    // 7-seg decoder
    seven_seg_decoder u_seg (
        .digit (digit),
        .seg   (seg)
    );

    // External LED, active-HIGH
    assign led_launch = led_int;
endmodule




//module rocket_top (
//    input  wire       clk,        // unused for this test
//    input  wire       btn_start,  // DIP 33, active-LOW (pressed = 0)
//    input  wire       btn_abort,  // DIP 32, active-LOW (pressed = 0)
//    output wire       led_launch, // JA1 (or DIP 34 if you kept that)
//    output wire [6:0] seg         // DIP 1..7, common-cathode, active-HIGH
//);
//    wire start_active = ~btn_start;  // 1 when pressed
//    wire abort_active = ~btn_abort;  // 1 when pressed

//    // Segments:
//    // seg[0] (a) lights when START is pressed
//    // seg[1] (b) lights when ABORT is pressed
//    assign seg[0] = start_active;
//    assign seg[1] = abort_active;
//    assign seg[6:2] = 5'b00000;      // others off

//    // LED follows START button
//    assign led_launch = start_active;
//endmodule

