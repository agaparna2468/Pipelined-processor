library ieee;
use ieee.std_logic_1164.all;

entity pipeline3 is 
		port(En,clock,reset:in std_logic; D3: in std_logic_vector(77 downto 0); Q:out std_logic_vector(77 downto 0));
	end entity pipeline3;

architecture behav of pipeline3 is
	begin
    
	dff_reset_proc: process (clock,reset, En, D3)
		begin
            if(En='1') then
                if(reset='1')then 
                Q <= (others=>'0'); 
                elsif (clock'event and (clock='1')) then
                Q <= D3; 
                end if ;
      
            end if;
   end process;
end behav;