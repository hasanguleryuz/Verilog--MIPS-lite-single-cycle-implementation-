module alucont(aluop1,aluop0,f3,f2,f1,f0,gout, islog);//Figure 4.12 
input aluop1,aluop0,f3,f2,f1,f0,islog;
output [3:0] gout;
reg [3:0] gout;
always @(aluop1 or aluop0 or f3 or f2 or f1 or f0 or islog)
begin
if(~(aluop1|aluop0))gout=4'b0000;
if(aluop0)gout=4'b0010;
if(aluop1)//R-type
begin
	if (~(f3|f2|f1|f0))gout=4'b0000; 	//function code=0000,ALU control=0000 (add)
	if (f1&f3)gout=4'b0001;			//function code=1x1x,ALU control=0001 (set on less than)
	if (f1&~(f3))gout=4'b0010;		//function code=0x10,ALU control=0010 (sub)
	if (f2&f0)gout=4'b0100;			//function code=x1x1,ALU control=0100 (or)
	if (f2&~(f0))gout=4'b1000;		//function code=x1x0,ALU control=1000 (and)
	if (f3&~(f2|f1|f0))gout=4'b1001;        //function code=1000,Alu control=1001 (nor)
end
if(~(aluop1|aluop0))//I-type
begin
	
	if(f3 & ~(f2|f1|f0))gout=4'b0000;                   //function of addi code=1000,control=0000(addi)
	if(f3&f2 & ~(f1|f0))gout=4'b1000;                   //function of andi code=1100,control=1000(andi)
        if(f3&f2&f0 &~f1)gout=4'b0100;                      //function of ori code=1101,control=0100(ori)
	if(f2&f0& ~(f3|f1))gout=4'b1010;                    //function of bne code=0101,control=1010			        
	if(f0&islog&~(f3|f2|f1))gout=4'b1011;		            //function of bgez code=0001,control=1011	
	if(f2&f1&f0&~f3)gout=4'b1100;                       //function of bgtz code=0111,control=1100
	if(f2&f1&~(f3|f0))gout=4'b1101;		            //function of blez code=0110,control=1101
        if(f0&~islog&~(f3|f2|f1))gout=4'b1110;		            //function of bltz code=0001,,control=1110		     
end	
end
endmodule
