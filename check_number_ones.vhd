library ieee;
use ieee.std_logic_1164.all;

entity check_number_ones is 
	port(
		instruc: in std_logic_vector(15 downto 0); 
        output: out std_logic_vector(3 downto 0));
end entity;

architecture bhv of check_number_ones is


begin 

process(instruc)
variable count: integer:= 0;
begin
		
		count:=0;
		L1: for i in 0 to 7 loop
			if(instruc(i)='1') then 
					count:=count+1;
			else  count:=count;
			end if;
		end loop L1;
		case count is
                when 0=>
                        output<="0000";
                when 1=>
                        output<="0001";  
                when 2=>
                        output<="0010";
                when 3=>
                        output<="0011";
                when 4=>
                        output<="0100";
                when 5 =>
                        output<="0101";
                when 6=>
                        output<="0110";
                when 7=>
                        output<="0111"; 
                when others=>
                        output<="1000";
                end case;
end process;	
 
end bhv;