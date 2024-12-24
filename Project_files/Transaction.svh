class Transaction extends uvm_sequence_item;
    `uvm_object_utils(Transaction)
	
	rand  bit        write;
	rand  bit        en;
	rand  bit		 rst;
	bit              valid_out;
	rand  bit [31:0] data;
	randc bit [3:0]  address;
	bit       [31:0] data_out;
	
	// while the reset is low these conditions must be also true (assertion)
    constraint reset_c{
        if(!rst){
			valid_out == 1'b0;
			data_out == 32'b0;
        }
    }
	
	//define the distribution of values for Data_in over specified ranges.
    constraint data_c{
        data dist {[0:200]:/40 ,[201:400]:/40,[401:600]:/40,[601:800]:/40,[801:1000]:/40,[1000:$]:/40};
    }
	
	//ensures write and read equally executed
    constraint Write_en_c{
        write dist{0:=50,1:=50};
    }
	
    constraint en_c{
        en dist{0:=10,1:=90};
    }
	
	//the address range 
    constraint addr_c{
        address <16;
    }
	
     task print_tr(input string class_name);
        $display("%0s :%0t inputs:Resetn=%0d Enable=%0d write=%0d Address=%0d Data_in=%0d",class_name,$time,rst,en,write,address,data);
        if(class_name !="Driver" && class_name !="Sequencer")
            $display("%0s :%0t outputs:Data_out=%0d Valid_out=%0d",class_name,$time,data_out,valid_out);

    endtask
	
    function new (string name="Transaction");
        super.new(name);
    endfunction
	
endclass:Transaction

