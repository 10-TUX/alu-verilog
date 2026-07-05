module alu (
    input [31:0] A,
    input [31:0] B,
    input [3:0] alu_control,
    output reg [31:0] result,
    output zero
);

always @(*) begin
    case (alu_control)
        4'b0000: result=A+B;
        default: result = 32'b0; 
    endcase
end

assign zero = (result==32'b0);

endmodule
