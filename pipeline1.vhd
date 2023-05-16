library ieee;
use ieee.std_logic_1164.all;

entity pipeline1 is 
		port(En,clock,reset:in std_logic; D2: in std_logic_vector(31 downto 0); Q:out std_logic_vector(31 downto 0));
	end entity pipeline1;

architecture behav of pipeline1 is
	begin
    
	dff_reset_proc: process (clock,reset, En, D2)
		begin
            if(En='1') then
                if(reset='1')then 
                Q <= (others=>'0'); 
                elsif (clock'event and (clock='1')) then
                Q <= D2; 
                end if ;
      
            end if;
   end process;
end behav;