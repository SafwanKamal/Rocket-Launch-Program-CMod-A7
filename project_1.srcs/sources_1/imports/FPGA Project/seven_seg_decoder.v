// seven_seg_decoder.v
// Common-cathode 7-seg, active-HIGH segments


// seg[6:0] = {g,f,e,d,c,b,a}; 1 = ON, 0 = OFF
// This reversed strong caused me a good amount of time
// Also, my work on vivado was not being saved for some reason. !!!!!!!!!!!

module seven_seg_decoder (
    input  wire [3:0] digit,  // 0..9
    output reg  [6:0] seg
);


// Non-reversed one, does not work

//    always @* begin
//        case (digit)
//            4'd0: seg = 7'b1111110; // 0
//            4'd1: seg = 7'b0110000; // 1
//            4'd2: seg = 7'b1101101; // 2
//            4'd3: seg = 7'b1111001; // 3
//            4'd4: seg = 7'b0110011; // 4
//            4'd5: seg = 7'b1011011; // 5
//            4'd6: seg = 7'b1011111; // 6
//            4'd7: seg = 7'b1110000; // 7
//            4'd8: seg = 7'b1111111; // 8
//            4'd9: seg = 7'b1111011; // 9
//            default: seg = 7'b0000000; // all off
//        endcase
//    end
    
    
// Testing the sequence/mapping of the segments to the bits   
    
//     always @* begin
//        case (digit)
//            4'd0: seg = 7'b0000001; // 0
//            4'd1: seg = 7'b0000011; // 1
//            4'd2: seg = 7'b0000101; // 2
//            4'd3: seg = 7'b0001001; // 3
//            4'd4: seg = 7'b0010001; // 4
//            4'd5: seg = 7'b0100001; // 5
//            4'd6: seg = 7'b1000001; // 6
//            4'd7: seg = 7'b0100001; // 7
//            4'd8: seg = 7'b0010001; // 8
//            4'd9: seg = 7'b0001001; // 9
//            default: seg = 7'b0000000; // all off
//        endcase
//    end


// Reversed Strings. Works
    always @* begin
        case (digit)
            4'd0: seg = 7'b0111111; // abcdef on, g off
            4'd1: seg = 7'b0000110; // bc
            4'd2: seg = 7'b1011011; // abdeg
            4'd3: seg = 7'b1001111; // abcdg
            4'd4: seg = 7'b1100110; // bcfg
            4'd5: seg = 7'b1101101; // acdfg
            4'd6: seg = 7'b1111101; // acdefg
            4'd7: seg = 7'b0000111; // abc
            4'd8: seg = 7'b1111111; // all on
            4'd9: seg = 7'b1101111; // abcdfg
            default: seg = 7'b0000000; // all off
        endcase
    end
endmodule

