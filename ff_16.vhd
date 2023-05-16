library ieee;
use ieee.std_logic_1164.all;

entity ff_16 is 
		port(En,clock,reset:in std_logic; D1: in std_logic_vector(15 downto 0); Q:out std_logic_vector(15 downto 0));
	end entity ff_16;

architecture behav of ff_16 is
	begin
    
	dff_reset_proc: process (clock,reset, En, D1)
		begin
            if(En='1') then
                if(reset='1')then 
                Q <= "0000000000000000"; 
                elsif (clock'event and (clock='1')) then
                Q <= D1; 
                end if ;
      
            end if;
   end process;
end behav;