`timescale 1ns/1ps
module f_minimized (
	input wire A,B,C,
	output wire F
);
	xor #15 u_xor(F, A, C);
	
endmodule
