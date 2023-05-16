library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity mux2_1 is
port(A,B : in std_logic_vector (15 downto 0);
S: in STD_LOGIC;
Z: out std_logic_vector (15 downto 0));
end mux2_1;
 
architecture Behavioral of mux2_1 is
 
begin
 
p1: process (A,B,S) 
begin
			if (S ='0') then
			   Z <= A;
			else
			   Z <= B;
			end if;
end process p1;
 
end Behavioral;
