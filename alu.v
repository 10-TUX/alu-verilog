`timescale 1ns /1ps
`include "alu_defines.vh"
module alu #(parameter WIDTH = 32) (
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [3:0] alu_control,
    output reg [WIDTH-1:0] result,
    output zero,
    output reg overflow,
    output reg carry,
    output reg negative
);
    reg [WIDTH:0] temp;

always @(*) begin
    carry =0;
    overflow = 0;
    result={WIDTH{1'b0}};
    negative = result[WIDTH-1];
    case (alu_control)
        `ALU_ADD: begin
            temp = A + B;    //ADD
            carry = temp[WIDTH];
            result = temp[WIDTH-1:0];
            overflow = (A[WIDTH-1] == B[WIDTH-1]) && (result[WIDTH-1] != A[WIDTH-1]);//overflow for ADD
        end
        `ALU_SUB: begin
             result = A - B; //SUB
             overflow = (A[WIDTH-1] != B[WIDTH-1]) && (result[WIDTH-1] != A[WIDTH-1]);//overflow for SUB
        end

        //LOGIC
        `ALU_AND: result = A & B; //AND
        `ALU_OR: result = A | B; //OR
        `ALU_XOR: result = A ^ B; //XOR
        `ALU_NOR: result = ~(A | B); //NOR
        `ALU_NOT: result = ~A; //NOT A
        `ALU_XNOR: result = ~(A ^ B); //XNOR

        //SHIFT
        `ALU_SLL: result = A << B[4:0]; //SLL
        `ALU_SRL: result = A >> B[4:0]; //SRL
        `ALU_SRA: result = $signed (A) >>> B[4:0]; //SRA
        
        //MISC
        `ALU_SLT: result = (A < B)? {{(WIDTH-1){1'b0}},1'b1}:{WIDTH{1'b0}}; //SLT
        `ALU_PASSA: result = A; // PASS A
        `ALU_PASSB: result = B; // PASS B
        default: result = {WIDTH{1'b0}}; 
    endcase
    negative = result[WIDTH-1];
end

assign zero = (result=={WIDTH{1'b0}});

endmodule
