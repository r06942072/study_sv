//note, from sv for verificaiton, sample8.44
/*
    1. the "static" used in class config_db make the database global
    2. in module top, there are 3 db, int_db, real_db, Tiny_db

*/
class config_db #(type T = int);
    //associative array
    //  data_type array_identifier [index_type]
    static T db[string];  // key index is datatype string, and value is type T
	
    static function void set(input string name, input T value);
        db[name] = value;
    endfunction

    static function void get(input string name, ref T value);
        value = db[name];
    endfunction

    static function void print();
        $display("\nPrint the config db and its typename is %s:", $typename(T));
        foreach(db[i])
            $display("db[%s] = %0p", i, db[i]); //Deciphering Assignment Patterns: %p
    endfunction
endclass

class Tiny; //compliation unit
    int data;
endclass

module top; //design unit
    int i=42, j=43, k; //placeholder
    real pi = 3.14, rr;
    Tiny obj_tiny;

    initial begin
        $display("");
        $display("*");
        $display("1st print:");
        config_db#(int)::print();
        config_db#(real)::print();
        config_db#(Tiny)::print();
        $display("****************************************************************");
        
        config_db#(int)::set("i", i); //save a data into int_db
        config_db#(int)::set("j", j); //save a data into int_db
        config_db#(real)::set("pi", pi); //save a data into real_db

        obj_tiny = new();
        obj_tiny.data = 8;
        config_db#(Tiny)::set("obj_tiny", obj_tiny); //save a handle into Tiny_db
        config_db#(Tiny)::set("obj_null", null); //save a handle into Tiny_db

        $display("");
        $display("*");
        $display("2nd print:");
        config_db#(int)::print();
        config_db#(real)::print();
        config_db#(Tiny)::print();
        $display("****************************************************************");

        config_db#(int)::get("i", k);
        $display("fetch value of index i is %0d", k);
        config_db#(int)::get("j", k);
        $display("fetch value of index j is %0d", k);
		
        config_db#(int)::get("k", k);  
        $display("fetch value of index k is %0d", k);  //0, not exist index called k in the given db int_db
        config_db#(real)::get("not_exist", rr);  
        $display("fetch value of index not_exist is ", rr); //0, not exist index called not_exist in given db real_db
    end
endmodule
//////////////////////
/*
interface i1;
	bit sig;
endinterface

package p1;
	bit sig222;
endpackage

module m1;
	import p1.*;
	bit sig;
	assign sig=sig222;
endmodule

bit sig_cu;

class Tiny; //compliation unit
    int data;
endclass
*/