`include "mem.v"
module tb;
parameter WIDTH=16;
parameter DEPETH=1024;
parameter ADDR=10;

reg clk,rst,wr_rd,valid;
reg [ADDR-1:0]addr;
reg [WIDTH-1:0]wdata;
wire [WIDTH-1:0]rdata;
wire ready;
integer i;
memory gt(clk,rst,addr,wdata,rdata,wr_rd,valid,ready);

initial begin
clk=0;
forever #5 clk=~clk;
end

initial begin
	rst=1;
	repeat (2) @(posedge clk);
	rst=0;
	for(i=0;i<DEPETH;i=i+1) begin //write
		@(posedge clk);
		addr=i;
		wdata=$random;
		wr_rd=1;
		valid=1;
		wait(ready==1);
	end
		@(posedge clk);
		valid=0;
		addr=0;
		wr_rd=0;

	for (i=0;i<DEPETH;i=i+1) begin  //read
			@(posedge clk);
			addr=i;
		//wdata=0;
			wr_rd=0;
			valid=1;
		wait(ready==1);
	end
	addr=0;
	valid=0;
	$finish;
end
endmodule

