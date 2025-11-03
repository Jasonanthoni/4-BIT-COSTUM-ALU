module avg (
    input  [3:0] A,   // input A
    input  [3:0] B,   // input B
    output [7:0] Y    // output average
);
    // add A and B 
    wire [4:0] full_sum = {1'b0, A} + {1'b0, B}; 
    // divide sum by 2 (right shift by 1)
    wire [4:0] average_5bit = full_sum >> 1;
    assign Y = {3'b000, average_5bit}; 

endmodule



