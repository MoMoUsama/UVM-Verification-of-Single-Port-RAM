/*
 manage the sequences 
 using the built-int method start(uvm_sequencer) 
*/
class Test extends uvm_test;
    `uvm_component_utils(Test)
	
    Env env;
    Sequence base_seq;
    Reset_Sequence rst_seq;
    Read_Sequence read_seq;
    Write_Sequence write_seq;
    virtual Intf vif;
	
    function new (string name="Test", uvm_component parent =null);
        super.new(name,parent);
    endfunction
	
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual Intf)::get(this,"","vif",vif))
            `uvm_error("Test","Can't get vif from the config db")
        uvm_config_db#(virtual Intf)::set(this,"env","vif",vif);
        env=Env::type_id::create("env",this);
        base_seq=Sequence::type_id::create("base_seq");
        base_seq.num_transactions=200;
		
        rst_seq=Reset_Sequence::type_id::create("rst_seq");
        rst_seq.num_transactions=100;
		
        read_seq=Read_Sequence::type_id::create("read_seq");
        read_seq.num_transactions=100;
		
        write_seq=Write_Sequence::type_id::create("write_seq");
        write_seq.num_transactions=100;
		
        $display("Test : build_phase");
    endfunction
	
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Test :connect_phase");
    endfunction
	
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Test :run_phase");
        phase.raise_objection(this);
        rst_seq.start(env.agent.sqr);
        #100;
        read_seq.start(env.agent.sqr);
        #100;
        write_seq.start(env.agent.sqr);
        #100;
        read_seq.start(env.agent.sqr);
        #100;
        base_seq.start(env.agent.sqr);
        #100;
        phase.drop_objection(this);
    endtask
endclass:Test