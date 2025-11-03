module add (
    input  [3:0] A, B,
    output [3:0] SUM,
    output CARRY
);
    assign {CARRY, SUM} = A + B;

endmodule
