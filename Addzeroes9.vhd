library ieee;
use ieee.std_logic_1164.all;

entity Addzeroes9 is 
	port(
		input1: in std_logic_vector(8 downto 0); az: in std_logic; 
        output: out std_logic_vector(15 downto 0));
end entity;

architecture Addze of Addzeroes9 is

begin 

process(az, input1)
begin
   if (az= '1') then
		for i in 9 to 15 loop
			output(i)<='0';
		end loop;
		output(8 downto 0)<=input1;
		else
			output(15 downto 0)<=(others=>'0');
	end if;
end process;	
 
end Addze;