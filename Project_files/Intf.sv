interface Intf (input reg clk);
	logic [31:0] data;
	logic [3:0] address;
	bit   rst,en,write;
	
	logic [31:0] data_out;
	logic valid_out;
	
	/*modport test (
		output address,data,rst,en,write,
		input data_out,clk
	);
	
	modport dut (
		input address,data,rst,en,write,clk,
		output data_out,valid_out
	);*/
endinterface