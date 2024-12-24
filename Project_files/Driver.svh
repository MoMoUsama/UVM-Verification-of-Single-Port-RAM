class Driver extends uvm_driver#(Transaction);
    `uvm_component_utils(Driver)
	
    Transaction item;
    virtual Intf vif; //virtual interface handle

    function new (string name="Driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction
	
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
		
        $display("Ram_Driver : build_phase");
        if(!uvm_config_db#(virtual Intf)::get(this,"","vif",vif))
            `uvm_error("Driver","Can't get vif from the config db")
        item=Transaction::type_id::create("item");

    endfunction
	
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Driver :connect_phase");
    endfunction
	
    task drive_item(input Transaction tr);
        @(posedge vif.clk);
		vif.en   	 <= tr.en;
		vif.data 	 <= tr.data;
		vif.write	 <= tr.write;
		vif.rst  	 <= tr.rst;
		vif.address  <= tr.address;
        @(posedge vif.clk);
    endtask:drive_item
	
    task run_phase(uvm_phase phase);
        forever begin
        $display("Ram_Driver :run_phase");
        seq_item_port.get_next_item(item); //handshaking then recieve from sequencer
        drive_item(item);
        seq_item_port.item_done();
        end
    endtask
	
endclass:Driver
