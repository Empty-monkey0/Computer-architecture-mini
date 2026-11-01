`timescale 1ns/1ps
// F = A'B'C + A'BC + AB'C' + AB' C (min terms 1,3,4,6) //
module f_canonical (
	input wire A, B, C,
	output wire F);
	
 	// Not: #5, AND,OR #10  NAND,NOR #12, XOR,XNOR: #15 BUF: #4
 
 	wire nA, nB, nC;
 	not #5 u_invA(nA, A);
 	not #5 u_invB(nB,B);
 	not #5 u_invC(nC, C);
 	
 	wire m1, m3, m4, m6;
 	
 	// m1 = A' B' C
 	and #10 u_m1(m1, nA, nB, C);
 	
 	// m3 = A' B C
 	and #10 u_m3(m3, nA, B, C);
 	
 	//m4 = A B' C'
 	and #10 u_m4(m4, A, nB, nC);
 	
 	//m6 = A B C'
 	and #10 u_m6(m6, A, B, nC);
 	
 	or #10 u_or(F,m1,m3,m4,m6);
 endmodule
 	
