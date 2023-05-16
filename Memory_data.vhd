library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory_data is
    port(clock, mem_rd, mem_wr: in std_logic; mem_add,mem_data: in std_logic_vector(15 downto 0);  mem_out: out std_logic_vector(15 downto 0) );
end entity;

architecture mem of Memory_data is
    
    type mem_array is array(0 to 45) of std_logic_vector(15 downto 0);
	 signal outp: std_logic_vector(15 downto 0):="0000000000000000";
    signal RdWr: mem_array:= (
            0=>"0000000001010000",    --80
            1=>"0000000101010010",    --338
            2=>"0000000101010001",    --337
            3=>"0000000001000101",    --69
            4=>"0000000000000111",    --7
            5=>"0000000000000110",    --6
            6=>"0000000000000011",    --3
            7=>"0000000000000110",    --6
            8=>"0000000000001000",    --8
            9=>"0000000000001111",    --15
            10=>"0000001100000101",   --773
            11=>"0000000000001101",   --13  
            12=>"0000000000001001",    --9  
            13=>"0000000000001011",    --11    
            14=>"0000000000000001",    --1
				15=>"0000000001010000",    --80
            16=>"0000000101010010",    --338
            17=>"0000000101010001",    --337
            18=>"0000000001000101",    --69
            19=>"0000000000000111",    --7
            20=>"0000000000000010",    --2
            21=>"0000000000000011",    --3
            22=>"0000000000000110",    --6
            23=>"0000000000001000",    --8
            24=>"0000000000001111",    --15
            25=>"0000000000000101",   --5
            26=>"0000000000001101",   --13  
            27=>"0000000000001001",    --9  
            28=>"0000000000001011",    --11    
            29=>"0000000000000001",    --1
            others=>(others=>'0')   
            );
begin
    mem_prc: process(clock, mem_add, mem_rd, mem_wr, RdWr,outp)
    
	 begin
			outp<="0000000000000000";
        if (clock'event and clock='0') then
            if(mem_wr='1') then
                RdWr(to_integer(unsigned(mem_add)))<=mem_data;
            end if;
        end if;
        if(mem_rd='1') then
            if(unsigned(mem_add)<=30) then
                outp<=RdWr(to_integer(unsigned(mem_add)));
            else
                outp<= (others=>'0');
				end if;
        end if;
        mem_out<=outp;
    end process;
end mem;