library ieee;
use ieee.std_logic_1164.all;

entity oneshift is

port (inp :in std_logic_vector(15 downto 0); OneS: in std_logic;
output: out std_logic_vector(15 downto 0));

end entity;

architecture bhv of oneshift is

signal A: std_logic_vector(14 downto 0);
signal B: std_logic;
signal nolatch: std_logic;

begin

process(OneS, inp, A, B)
begin
    if (OneS= '1') then
			A<= inp(14 downto 0);
			B<= '0';
			output<= A & B;
	else
				A<="000000000000000";
				B<= '0';
				 output<=inp;
	end if;
end process;
end bhv;

