module add (
    input  [3:0] A,    // input A
    input  [3:0] B,    // input B
    output [3:0] SUM,  // output sum
    output COUT        // output carry
);
    assign {COUT, SUM} = A + B;     // add A and B

endmodule
