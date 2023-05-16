library ieee;
use ieee.std_logic_1164.all;

entity pipeline5 is 
		port(En,clock,reset:in std_logic; D5: in std_logic_vector(55 downto 0); Q:out std_logic_vector(55 downto 0));
	end entity pipeline5;

architecture behav of pipeline5 is
	begin
    
	dff_reset_proc: process (clock,reset, En, D5)
		begin
            if(En='1') then
                if(reset='1')then 
                Q <= (others=>'0'); 
                elsif (clock'event and (clock='1')) then
                Q <= D5; 
                end if ;
      
            end if;
   end process;
end behav;