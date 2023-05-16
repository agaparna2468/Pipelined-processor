library ieee;
use ieee.std_logic_1164.all;

entity ff_1 is 
		port(D1, En,clock,reset:in std_logic; Q:out std_logic);
	end entity ff_1;

architecture behav of ff_1 is
	begin
	
		dff_reset_proc: process (clock,reset,En, D1)
			begin
			if(En='1') then
				if(reset='1')then 
				Q <= '0'; 
				elsif (clock'event and (clock='1')) then
				Q <= D1; 
				end if ;
			end if;
	end process;
end behav;