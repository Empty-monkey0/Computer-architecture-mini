`timescale 1ns/1ps

module tb;
  // One knob: inter-arrival time between input vectors (ns)
  real INTERVAL_NS = 15.1;

  // DUT selection: UNCOMMENT ONE 
  // canonical:
  reg A,B,C; wire Fdut; f_canonical dut(.A(A),.B(B),.C(C),.F(Fdut));

  // minimized:
  //reg A,B,C; wire Fdut; f_minimized dut(.A(A),.B(B),.C(C),.F(Fdut));

  // Golden model for F = A ^ C
  function automatic bit golden(input bit a, input bit c);
    golden = a ^ c;
  endfunction

  // The 10 assignment vectors, interpreted as {A,B,C}
  reg [2:0] V [0:9];
  integer i;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb);

    V[0]=3'b010; V[1]=3'b111; V[2]=3'b001; V[3]=3'b100; V[4]=3'b011;
    V[5]=3'b000; V[6]=3'b110; V[7]=3'b101; V[8]=3'b011; V[9]=3'b010;

    A=0; B=0; C=0; #(INTERVAL_NS);
    $display("Driving 10 vectors with INTERVAL = %0.1f ns", INTERVAL_NS);

    for (i=0; i<10; i=i+1) begin
      {A,B,C} = V[i];
      #(INTERVAL_NS); // inter-arrival gap

      if (Fdut !== golden(A,C)) begin
        $display("[%0t] MISMATCH vec%0d A=%0b B=%0b C=%0b  F=%0b gold=%0b",
                 $time, i, A,B,C, Fdut, golden(A,C));
      end else begin
        $display("[%0t] OK       vec%0d A=%0b B=%0b C=%0b  F=%0b",
                 $time, i, A,B,C, Fdut);
      end
    end
    $finish;
  end
endmodule


