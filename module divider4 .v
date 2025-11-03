module divider4 (
    input  [3:0] A, B,      
    output reg [3:0] QUOTIENT,
    output reg [3:0] REMAINDER
);
    always @(*) begin
        if (B != 0) begin
            QUOTIENT  = A / B;
            REMAINDER = A % B;
        end else begin
            QUOTIENT  = 4'b0000;
            REMAINDER = 4'b0000; 
        end
    end
endmodule