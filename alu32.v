module alu32(sum,a,b,zout,gin);//ALU operation according to the ALU control line values
output [31:0] sum;
input [31:0] a,b; 
input [3:0] gin;//ALU control line
reg [31:0] sum;
reg [31:0] less;
output zout;
reg zout;
always @(a or b or gin)
begin
	case(gin)
	4'b0000: sum=a+b; 		//ALU control line=0000, ADD
	4'b0010: sum=a+1+(~b);		//ALU control line=0010, SUB
	4'b0001: begin less=a+1+(~b);	//ALU control line=0001, set on less than
			if (less[31]) sum=1;	
			else sum=0;
		  end
	4'b1000: sum=a & b;		//ALU control line=1000, AND
	4'b0100: sum=a|b;		//ALU control line=0100, OR
	4'b1001: sum=~(a|b);     	//ALU control line=1001, NOR
	4'b1010: begin 			//ALU control line=1010, BNE
			if(a!=b) sum=0;
			else sum=1;
		 end
	4'b1011: begin 			//ALU control line=1011, BGEZ	
			if(a>=0) sum=0;
			else sum=1;
		 end
	4'b1100: begin			//ALU control line=1100, BGTZ
			if(a>0) sum=0;
			else sum=1;
		 end
        4'b1101: begin			//ALU control line=1101, BLEZ
			if(a<=0) sum=0;
			else sum=1;
		 end
	4'b1110: begin 			//ALU control line=1110, BLTZ
			if(a<0) sum=0;
			else sum=1;
		 end
	default: sum=31'bx;	
	endcase
zout=~(|sum);
end
endmodule
