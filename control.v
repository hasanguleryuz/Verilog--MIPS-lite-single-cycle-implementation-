module control(in,regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop2,isimmpart,jump);
input [5:0] in;
output regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop2,isimmpart,jump;
wire rformat,lw,sw,beq,cbranch;
assign rformat=~|in;
assign lw=in[5]&(~in[4])&(~in[3])&(~in[2])&in[1]&in[0];
assign sw=in[5]&(~in[4])&in[3]&(~in[2])&in[1]&in[0];
assign beq=~in[5]& (~in[4])&(~in[3])&in[2]&(~in[1])&(~in[0]);
assign cbranch=~in[5]&~in[4]&~in[3]&(in[2]|in[1]|in[0]);
assign isimmpart=in[3]&~(in[5]&in[4]&in[2]&in[1]&in[0]);//if thrid bit of the op-code 1, this op-code use immediate part. 
assign jump=~(in[5]|in[4]|in[3]|in[2]|in[0])&(in[1]);
assign regdest=rformat;
assign alusrc=lw|sw;
assign memtoreg=lw;
assign regwrite=rformat|lw;
assign memread=lw;
assign memwrite=sw;
assign branch=cbranch;
assign aluop1=rformat;
assign aluop2=beq;
endmodule
