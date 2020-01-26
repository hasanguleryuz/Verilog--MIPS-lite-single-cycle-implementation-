
These instructions implemented.

R-format: jr, nor 
I-format: addi, andi, ori, bne, bgez, bgtz, blez, bltz 
J-format: j

1- R-type or I-type
My design decides whether instruction have R-type or I-type. This decision is made by a multiplexer. This multiplexer use RegDst. If the instruction is I-type, RegDst equal 0. If the instruction is R-type, RegDst equal 1. Result of multiplexer: If instruction is I-type, the array will go to the ALU control is 'instruct[29-26]'.  If instruction is R-type, the array will go to the ALU control is 'instruct[3-0]'.
2-Is immediate part?
 ADDI, ANDI, ORI use the immediate part that mean 'instruct[15-0]' during operations, but other instructions do not use immediate. They are use offset. This decision is made by a multiplexer. This multiplexer use a parameter. This parameter name is 'isimmpart'. If the instruction is ADDI, ORI or ANDI, 'isimmpart' is equal 1. Otherwise 'isimmpart'  is equal 0. 
3- Jump instruction
I added a new parameter in control part. This parameter name is 'Jump'. If a instruction is 'jump' instruction, Jump is equal 1. PC is equal shift lef2(instruction[25-0]) and PC+4[31-28] thanks to Jump instruction. If a instruction is a jump instruction, 'Jump' parameter is equal 1. Result of multiplexer: If 'Jump' parameter is equal 1,  PC is equal shift lef2(instruction[25-0]) and PC+4[31-28]. This operation is made by a multiplexer.
4- BGEZ or BLTZ
BGEZ instruction code and BLTZ instruction code same. The only difference between instructions is 'instruct[16]' . So I added a new parameter. This parameter name is 'islog'. This parameter is 'instruct[16]'. If 'islog' is equal 1 and instruction is BGEZ or BLTZ,  will do BGEZ operations. If 'islog' is equal 0, will do BLTZ operations.
5- JR instruction
'JR' instruction is jump to the address contained in register $s. 'JR' is R-type.  So opcode is '000000', RegDst is equal 1 and funct is '001000'. I added a parameter in processor. This parameter name is 'isjr'. isjr=regdest && (instruc[3]&~(instruc[0]|instruc[1]|instruc[2]|instruc[4]|instruc[5])). This decision is made by a multiplexer. This multiplexer use 'isjr'. If 'isjr' is equal 1. PC is equal that address contained in register $s.
