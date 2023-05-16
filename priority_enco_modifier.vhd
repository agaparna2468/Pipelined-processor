library ieee;
use ieee.std_logic_1164.all;

entity priority_enco_modifier is 
	port(A: in std_logic_vector(7 downto 0); 
        output: out std_logic_vector(7 downto 0));
end entity;


architecture bhv of priority_enco_modifier is

--signal i:integer;

begin
process(A)
variable reply:std_logic_vector(7 downto 0);
variable flag:std_logic:='0';
begin
		reply := A;
		flag:='0';
		L1: for i in 0 to 7 loop
				if(A(7-i)='1' and flag='0') then
					reply(7-i)	:='0';
					flag		:='1';
				end if;
		end loop L1;

		output<=reply;
end process; 
end bhv;