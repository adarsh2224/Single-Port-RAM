module memory(clk,rst,addr,wdata,rdata,wr_rd,valid,ready);
parameter WIDTH=16;
parameter DEPETH=1024;
parameter ADDR=10;

input clk,rst,wr_rd,valid;
input [ADDR-1:0]addr;
input [WIDTH-1:0]wdata;
output reg [WIDTH-1:0]rdata;
output reg ready;
reg [WIDTH-1:0] mem[DEPETH-1:0];
integer i;

always @(posedge clk) begin
	if (rst==1) begin
		for(i=0;i<DEPETH;i=i+1) begin
			mem[i]=0;
		end
		rdata=0;
		ready=0;
	end
	else begin
		if(valid==1) begin
			ready=1;
			if (wr_rd==1) begin
				mem[addr]=wdata;
			end
			else begin
				rdata=mem[addr];
			end
		end
		else
		ready=0;
	end
end
endmodule

