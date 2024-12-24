class Monitor extends uvm_monitor;
    `uvm_component_utils(Monitor)
	
    uvm_analysis_port#(Transaction) mon_ap;
    Transaction item;
    virtual Intf vif;
	
    function new (string name="Monitor", uvm_component parent =null);
        super.new(name,parent);
    endfunction
	
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("Monitor : build_phase");
        if(!uvm_config_db#(virtual Intf)::get(this,"","vif",vif))
            `uvm_error("Ram_Monitor","Can't get vif from the config db")
        item=Transaction::type_id::create("item");
        mon_ap=new("mon_ap",this);

    endfunction
	
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Monitor :connect_phase");
    endfunction
	
    task run_phase(uvm_phase phase);
        forever begin
			$display("Monitor :run_phase");
			repeat (2)
				@(posedge vif.clk);
			@(negedge vif.clk);
			item.data_out  <= vif.data_out;
			item.valid_out <= vif.valid_out;
			item.data      <= vif.data;
			item.address   <= vif.address;
			item.en        <= vif.en;
			item.rst       <= vif.rst;
			item.write     <= vif.write;
			#1step;
			mon_ap.write(item); // -> agent -> scoreboard -> subscriber
			item.print_tr("Monitor");
        end
    endtask
endclass:Monitor
