library ieee;
use ieee.std_logic_1164.all;

entity SignE9 is 
	port(
		input1: in std_logic_vector(8 downto 0); se9: in std_logic;
        output: out std_logic_vector(15 downto 0));
end entity;

architecture se_9 of SignE9 is

begin 

process(se9, input1)
begin
   if (se9= '1') then
		for i in 9 to 15 loop
			output(i)<=input1(8);
		end loop;
		output(8 downto 0)<=input1;
		else
			output(15 downto 0)<=(others=>'0');
	end if;
end process;	
 
end se_9;