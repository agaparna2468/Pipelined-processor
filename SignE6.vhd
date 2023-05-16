library ieee;
use ieee.std_logic_1164.all;

entity SignE6 is 
	port(
		input1: in std_logic_vector(5 downto 0); se6: in std_logic
        ;output: out std_logic_vector(15 downto 0));
end SignE6;

architecture se_6 of SignE6 is

begin
process(se6, input1)
begin
    if (se6= '1') then
		for i in 6 to 15 loop
		   output(i)<=input1(5);
		end loop;
		output(5 downto 0)<=input1;
		else
			output(15 downto 0)<=(others=>'0');
	end if;
end process;
end se_6;