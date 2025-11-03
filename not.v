module not(input [3:0] A, output [7:0] Y);
    assign Y = 4'b0000, ~A;
endmodule

