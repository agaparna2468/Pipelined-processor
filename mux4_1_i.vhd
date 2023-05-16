library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity mux4_1_i is
port(A,B,C,D : in std_logic;
S: in std_logic_vector (1 downto 0);
Z: out std_logic);
end mux4_1_i;
 
architecture Behavioral of mux4_1_i is
 
begin
 
p1: process (A,B,C,D,S) 
begin
			if (S ="00") then
			   Z <= A;
			elsif (S ="01") then
			   Z <= B;
			elsif (S ="10") then
			   Z <= C;
			else
			   Z <= D;
			
			end if;
end process p1;
 
end Behavioral;
