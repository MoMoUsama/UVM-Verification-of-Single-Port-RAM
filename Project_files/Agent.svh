class Agent extends uvm_agent;
    `uvm_component_utils(Agent)
	
    Sequencer sqr;
    Driver drv;
    Monitor mon;
    uvm_analysis_port#(Transaction) agent_ap;
    virtual Intf vif;
	
    function new (string name="Agent", uvm_component parent =null);
        super.new(name,parent);
    endfunction
	
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
		
        if(!uvm_config_db#(virtual Intf)::get(this,"","vif",vif))
            `uvm_error("Agent","Can't get vif from the config db")
        uvm_config_db#(virtual Intf)::set(this,"drv","vif",vif);
        uvm_config_db#(virtual Intf)::set(this,"mon","vif",vif);
        sqr=Sequencer::type_id::create("sqr",this);
        drv=Driver::type_id::create("drv",this);
        mon=Monitor::type_id::create("mon",this);
        agent_ap=new("agent_ap",this);
        $display("Agent : build_phase");
    endfunction
	
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Agent :connect_phase");
        drv.seq_item_port.connect(sqr.seq_item_export); 
        mon.mon_ap.connect(this.agent_ap); 
    endfunction
	
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Agent :run_phase");
    endtask
endclass:Agent