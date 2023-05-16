library ieee;
use ieee.std_logic_1164.all;

entity PC_signalcontrol is 
		port(D1: in std_logic_vector(2 downto 0); En:in std_logic; Q: out std_logic_vector(2 downto 0));
	end entity PC_signalcontrol;

architecture behav of PC_signalcontrol is
	begin
	
		proc: process (En, D1)
			begin
			if(En='1') then
				Q <= D1; 
				
			else
				Q <= "100"; 
			end if;
	end process;
end behav;