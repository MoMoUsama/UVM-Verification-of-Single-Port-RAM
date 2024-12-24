class Env extends uvm_env;
    `uvm_component_utils(Env)
    Agent agent;
    Subscriber cov;
    Scoreboard scb;
    virtual Intf vif;
   function new (string name="Env", uvm_component parent =null);
        super.new(name,parent);
    endfunction
	
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual Intf)::get(this,"","vif",vif))
            `uvm_error("Env","Can't get vif from the config db")
        uvm_config_db#(virtual Intf)::set(this,"agent","vif",vif);
        agent=Agent::type_id::create("agent",this);
        scb=Scoreboard::type_id::create("scb",this);
        cov=Subscriber::type_id::create("cov",this);
        $display("Env : build_phase");
    endfunction
	
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Env :connect_phase");
        agent.agent_ap.connect(scb.scb_imp);
        agent.agent_ap.connect(cov.sub_imp);
    endfunction
	
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Ram_Env :run_phase");
    endtask
	
endclass:Env