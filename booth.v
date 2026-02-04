
module xorgate2 (input wire input0, input1, output wire o);
  assign o = input0 ^ input1;
endmodule


module fulladder ( input wire input0, input1, carryin, output wire sumout, carryout);
    assign sumout = input0 ^ input1 ^ carryin;
    assign carryout = (input0 & input1) | (input1 & carryin) | (carryin & input0);
endmodule

module eightbit_addsub(
    input wire carryin,
    input wire [7:0] input0,input1,
    output wire [7:0] sumout);

	wire carryout;
	wire [7:0] temporary;
	wire [7:0] i_p_int; 	
    xorgate2 x0 (input1[0], carryin, i_p_int[0]);
    xorgate2 x1 (input1[1], carryin, i_p_int[1]);
    xorgate2 x2 (input1[2], carryin, i_p_int[2]);
    xorgate2 x3 (input1[3], carryin, i_p_int[3]);
    xorgate2 x4 (input1[4], carryin, i_p_int[4]);
    xorgate2 x5 (input1[5], carryin, i_p_int[5]);
    xorgate2 x6 (input1[6], carryin, i_p_int[6]);
    xorgate2 x7 (input1[7], carryin, i_p_int[7]);
    
	fulladder fulladder1(input0[0], i_p_int[0], carryin,     sumout[0], temporary[0]);
	fulladder fulladder2(input0[1], i_p_int[1], temporary[0], sumout[1], temporary[1]);
	fulladder fulladder3(input0[2], i_p_int[2], temporary[1], sumout[2], temporary[2]);
	fulladder fulladder4(input0[3], i_p_int[3], temporary[2], sumout[3], temporary[3]);
	fulladder fulladder5(input0[4], i_p_int[4], temporary[3], sumout[4], temporary[4]);
	fulladder fulladder6(input0[5], i_p_int[5], temporary[4], sumout[5], temporary[5]);
	fulladder fulladder7(input0[6], i_p_int[6], temporary[5], sumout[6], temporary[6]);
	fulladder fulladder8(input0[7], i_p_int[7], temporary[6], sumout[7], carryout);
	
endmodule


module booth_substep(
    input wire signed [7:0] accum,    
    input wire signed [7:0] P,     
    input wire signed p0,       
    input wire signed [7:0] m1,  
    output reg signed [7:0] accum_q,   
    output reg signed [7:0] next_P,
    output reg p0_next);
    
	wire [7:0] AS_temp;  
	
	eightbit_addsub myadd(P[0], accum, m1, AS_temp);
	
		always @(*) begin	
		if(P[0] == p0) begin
            p0_next = P[0];
            next_P = P>>1;
            next_P[7] = accum[0];
      
            accum_q = accum>>1;
           
			if (accum[7] == 1)
                accum_q[7] = 1;
		end

		else begin        
            p0_next = P[0];
            next_P = P>>1;
            next_P[7] = AS_temp[0];
        
            accum_q = AS_temp>>1;
           
			if (AS_temp[7] == 1)
                accum_q[7] = 1;
		end			
end	
endmodule 

 
module booth(
    input signed[7:0] m2, m1,
    output signed [15:0] result_pro);

	wire signed [7:0] P[0:6];  
	wire signed [7:0] accum[0:7]; 
	wire signed[7:0] p0;
	wire pout;
	
	assign accum[0] = 8'b00000000;   
	
	booth_substep step1(accum[0], m2, 1'b0, m1, accum[1],        P[0],         p0[1]);
	booth_substep step2(accum[1], P[0],      p0[1], m1, accum[2],        P[1],         p0[2]);
	booth_substep step3(accum[2], P[1],      p0[2], m1, accum[3],        P[2],         p0[3]);
	booth_substep step4(accum[3], P[2],      p0[3], m1, accum[4],        P[3],         p0[4]);
	booth_substep step5(accum[4], P[3],      p0[4], m1, accum[5],        P[4],         p0[5]);
	booth_substep step6(accum[5], P[4],      p0[5], m1, accum[6],        P[5],         p0[6]);
	booth_substep step7(accum[6], P[5],      p0[6], m1, accum[7],        P[6],         p0[7]);
	booth_substep step8(accum[7], P[6],      p0[7], m1, result_pro[15:8], result_pro[7:0], pout);
	
	 
endmodule

