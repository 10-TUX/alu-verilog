module alu_tb;

    reg [31:0] A;
    reg [31:0] B;
    reg [3:0] alu_control;

    wire [31:0] result;
    wire zero;

    alu dut (.A(A), .B(B), .alu_control(alu_control), .result(result), .zero(zero));

    initial begin
        A = 15;
        B = 20;
        alu_control = 4'b0000;

        #10;

        $display("A = %d, B = %d , Result = %d , Zero = %b",A,B,result,zero);
        $finish;
    end

endmodule