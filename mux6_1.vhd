library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity mux6_1 is
port(A,B,C,D,E,F : in std_logic_vector (15 downto 0);
S: in std_logic_vector (2 downto 0);
Z: out std_logic_vector (15 downto 0));
end mux6_1;
 
architecture Behavioral of mux6_1 is
 
begin
 
p1: process (A,B,C,D,E,F,S) 
begin
			if (S ="000") then
			   Z <= A;
			elsif (S ="001") then
			   Z <= B;
			elsif (S ="010") then
			   Z <= C;
			elsif (S ="011") then
			   Z <= D;
			elsif (S ="100") then
			   Z <= E;
			elsif (S ="101") then
			   Z <= F;
			else
			   Z <= F;
			end if;
end process p1;
 
end Behavioral;
