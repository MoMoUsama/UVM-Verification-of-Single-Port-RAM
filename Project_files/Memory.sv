module Memory(interface intf_inst);
reg [31:0] mem [0:15] ;

always@(posedge intf_inst.clk or negedge intf_inst.rst)
begin
	if(!intf_inst.rst)
	begin
		intf_inst.valid_out<='d0;
		intf_inst.data_out<= 'd0;
		foreach(mem[i])
			mem[i]<= 'd0;
	end
	
	else if (intf_inst.en && intf_inst.write) begin
		mem[intf_inst.address]<= intf_inst.data;
		intf_inst.valid_out<= 1'b0;
	end
	
	else if(intf_inst.en) begin
		intf_inst.data_out<=mem[intf_inst.address];
		intf_inst.valid_out<= 1'b1;
	end
end
endmodule