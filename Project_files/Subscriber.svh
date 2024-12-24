class Subscriber extends uvm_subscriber#(Transaction);
    `uvm_component_utils(Subscriber)
    Transaction item;
    uvm_analysis_imp#(Transaction,Subscriber) sub_imp;
    covergroup cg;
	
        reset: coverpoint item.rst{
            bins low={0};
            bins high={1};
            bins lowtohigh = (0=>1);
			bins hightolow = (1=>0);
        }
		
        enable: coverpoint item.en{
            bins low={0};
            bins high={1};
            bins lowtohigh= (0=>1);
			bins hightolow = (1=>0);
            
        }
        Write_en: coverpoint item.write{
            bins read={0};
            bins write={1};
	        bins lowtohigh= (0=>1);
			bins hightolow = (1=>0);
        }
        Data_in: coverpoint item.data{
            bins data0={[0:200]};
            bins data1={[201:400]};
            bins data2={[401:600]};
            bins data3={[601:800]};
            bins data4={[801:1000]};
            bins data5={[1000:$]};
        }
		
        Address: coverpoint item.address{
            bins address[]={[0:15]};
        }
		
        Data_out: coverpoint item.data_out{
          bins dataout0={[0:200]};
          bins dataout1={[201:400]};
          bins dataout2={[401:600]};
          bins dataout3={[601:800]};
          bins dataout4={[801:1000]};
          bins dataout5={[1000:$]};
        }
		
        Valid_out: coverpoint item.valid_out;
        cross1: cross Address,Data_in;  //cover combination of  each bin in Data_in with each bin in Address (16*6=96 bins) (the max bins is 64)
           
    endgroup
	
    function new (string name="Subscriber", uvm_component parent =null);
        super.new(name,parent);
        cg=new(); //not created in the build_phase
    endfunction
	
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("Ram_Subscriber : build_phase");
        sub_imp=new("sub_imp",this);
    endfunction
	
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Ram_Subscriber :connect_phase");
    endfunction
	
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Ram_Subscriber :run_phase");
    endtask
	
    virtual function void write(Transaction t);
        item=t;
        cg.sample(); //sample when a new transaction arrives
    endfunction
	
    function void report_phase (uvm_phase phase);
    `uvm_info("Subscriber", $sformatf("coverage =%0d", cg.get_coverage), UVM_NONE);
    endfunction
	
endclass:Subscriber

