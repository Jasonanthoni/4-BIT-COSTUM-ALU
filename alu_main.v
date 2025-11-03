//=====================================================
// 4-bit Modular ALU Top-Level Module
// Author: Mango Milkshake
//=====================================================
module alu_top (
    input  [3:0] A,          // 4-bit input A
    input  [3:0] B,          // 4-bit input B
    input  [2:0] opcode,     // 3-bit Opcode
    output reg [7:0] result, // 8-bit output
    output reg carry_out     // Carryout
);

    wire [4:0] add_out;  
    wire [4:0] sub_out;
    wire [7:0] mul_out;
    wire [7:0] div_out;
    wire [3:0] nand_out;
    wire [3:0] not_out;
    wire [7:0] cmp_out;
    wire [7:0] avg_out;

    add_module U1 (.A(A), .B(B), .SUM(add_out[3:0]), .COUT(add_out[4]));
    sub_module U2 (.A(A), .B(B), .DIFF(sub_out[3:0]), .COUT(sub_out[4]));
    mul_module U3 (.A(A), .B(B), .PROD(mul_out));
    div_module U4 (.A(A), .B(B), .QUO(div_out));
    nand_module U5 (.A(A), .B(B), .Y(nand_out));
    not_module U6 (.A(A), .Y(not_out));
    cmp_module U7 (.A(A), .B(B), .Y(cmp_out));
    avg_module U8 (.A(A), .B(B), .Y(avg_out));

   
    always @(*) begin
        case (opcode)
            3'b000: begin // ADD
                result    = {4'b0000, add_out[3:0]};
                carry_out = add_out[4];
            end
            3'b001: begin // SUB
                result    = {4'b0000, sub_out[3:0]};
                carry_out = sub_out[4];
            end
            3'b010: begin // MUL
                result    = mul_out;
                carry_out = 1'b0;
            end
            3'b011: begin // DIV
                result    = div_out;
                carry_out = 1'b0;
            end
            3'b100: begin // NAND
                result    = {4'b0000, nand_out};
                carry_out = 1'b0;
            end
            3'b101: begin // NOT (A only)
                result    = {4'b0000, not_out};
                carry_out = 1'b0;
            end
            3'b110: begin // CMP (1 if A > B else 0)
                result    = cmp_out;
                carry_out = 1'b0;
            end
            3'b111: begin // AVG ((A + B) / 2)
                result    = avg_out;
                carry_out = 1'b0;
            end
            default: begin
                result    = 8'b00000000;
                carry_out = 1'b0;
            end
        endcase
    end

endmodule
