library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity mux2_1_i is
port(A,B : in std_logic;
S: in STD_LOGIC;
Z: out std_logic);
end mux2_1_i;
 
architecture Behavioral of mux2_1_i is
 
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
