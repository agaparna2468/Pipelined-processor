library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stage5_dec is
    port(inst: in std_logic_vector(15 downto 0); 
	 Mux12: out std_logic);
end entity stage5_dec;

architecture dec of stage5_dec is
    signal nolatch: std_logic;
begin
    fivedec: process(inst)
    
	 begin
			if(inst(15 downto 12)="0001") then
					Mux12			<='1';
					
					
			elsif(inst(15 downto 12)="0000") then
					
					Mux12			<='1';
					
					
			elsif(inst(15 downto 12)="0010") then
					Mux12			<='1';
					
					
			 elsif(inst(15 downto 12)="0011") then
					Mux12			<='1';
					
					
			 elsif(inst(15 downto 12)="0100") then
					Mux12			<='0';
					
					
			elsif(inst(15 downto 12)="0101") then
					Mux12			<='1';
					
					
			 elsif(inst(15 downto 12)="1000" or inst(15 downto 12)="1001" or inst(15 downto 12)="1011") then
					Mux12			<='1';
					
			
			elsif(inst(15 downto 12)="1100") then
					Mux12			<='1';
					
					
			elsif(inst(15 downto 12)="1101") then
					Mux12			<='1';
						
					
			elsif(inst(15 downto 12)="1111") then
					Mux12			<='1';
					
					
			else
					Mux12			<='1';
					
					
			end if;
			
					
    end process;
end dec;