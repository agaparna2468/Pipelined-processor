library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_enco is 
	port(inst: in std_logic_vector(7 downto 0); 
        output: out std_logic_vector(2 downto 0));
end entity;


architecture bhv of priority_enco is

begin
process(inst)
variable count: integer:= 0;

variable flag: std_logic:= '0';
begin
		count:= 0;

		flag:='0';
		L1: for i in 0 to 7 loop
				
				if(inst(7-i)='1' and flag='0') then
					 count := 7-i;
					 flag := '1';
				end if;
				end loop L1;
		case count is
                when 7=>
                        output<="000";
                when 6=>
                        output<="001";  
                when 5=>
                        output<="010";
                when 4=>
                        output<="011";
                when 3=>
                        output<="100";
                when 2 =>
                        output<="101";
                when 1=>
                        output<="110";
                when 0=>
                        output<="111";
					 when	others=>
								output<="101";
                end case;
		
end process;
end bhv;