library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDzeroes3 is 
	port(
		input1: in std_logic_vector(3 downto 0); output: out std_logic_vector(5 downto 0));
end ADDzeroes3;

architecture bhv of ADDzeroes3 is

begin
process(input1)
variable num: integer;
begin
		
		num:= to_integer(unsigned(input1));
		
		num:=num-1;
		case num is
                when 0=>
                        output<="000000";
                when 1=>
                        output<="000001";  
                when 2=>
                        output<="000010";
                when 3=>
                        output<="000011";
                when 4=>
                        output<="000100";
                when 5 =>
                        output<="000101";
                when 6=>
                        output<="000110";
                when 7=>
                        output<="000111"; 
                when others=>
                        output<="001000";
                end case;
					 
		
		
--		else
--			output(5 downto 0)<=(others=>'0');
--	end if;

end process;
end bhv;