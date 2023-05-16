library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity mux2_1_3i is
port(A,B : in std_logic_vector (2 downto 0); S: in STD_LOGIC; Z: out std_logic_vector (2 downto 0));
end mux2_1_3i;
 
architecture Behavioral of mux2_1_3i is
 
begin
 
process (A,B,S) is
begin
	if (S ='0') then
	Z <= A;
	else
	Z <= B;
	end if;
end process;
 
end Behavioral;