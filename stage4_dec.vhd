library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stage4_dec is
    port(inst: in std_logic_vector(15 downto 0);PC_En, current_carry, current_zero, prev_carry: in std_logic;
	 Mux3, Mux5, Mux6, Mux11: out std_logic;
	 Mux4, Mux9: out std_logic_vector(2 downto 0);
	 PC_Mux:out std_logic_vector(2 downto 0);
	 Mux10: out std_logic_vector(1 downto 0));
end entity stage4_dec;

architecture dec of stage4_dec is
    signal nolatch: std_logic;
begin
    fourdec: process(inst, prev_carry, PC_En, current_carry, current_zero)
    
	 begin
			if(inst(15 downto 12)="0001" and inst(1 downto 0)/="11") then
					Mux3		<='0';
					Mux4  	<="001";
					Mux5		<='0';
					Mux6		<='0';
					Mux9		<="001";
					Mux11		<='0';
					PC_Mux  	<="011";
					Mux10			<="00";
					--need to disable write signals for adc, adz , acc, acz if prev carry/zero =0
					
			elsif(inst(15 downto 12)="0001" and inst(1 downto 0)="11") then
					Mux3		<='0';
					Mux4  	<="001";
					if(prev_carry/='1') then
							Mux5	<='0';
							Mux6	<='0';
							Mux9	<="001";
							Mux11	<='0';
					else 
							Mux5	<='0';
							Mux6	<='0';
							Mux9	<="100";
							Mux11	<='0';
					end if;
					
					PC_Mux  <="011";
					Mux10			<="00";
					
			elsif(inst(15 downto 12)="0000") then
					Mux3		<='0';
					Mux4  	<="011";
					Mux5		<='0';
					Mux6		<='0';
					Mux9		<="001";
					Mux11		<='0';
					PC_Mux  	<="011";
					Mux10			<="01";
					
			elsif(inst(15 downto 12)="0010") then
					Mux3		<='0';
					Mux4  	<="001";
					Mux5		<='0';
					Mux6		<='0';
					Mux9		<="001";
					Mux11		<='0';
					PC_Mux  	<="011";
					Mux10			<="00";
					
			 elsif(inst(15 downto 12)="0011") then
					Mux3		<='0';
					Mux4  	<="000";
					Mux5		<='0';
					Mux6		<='0';
					Mux9		<="000";
					Mux11		<='0';
					PC_Mux  	<="011";
					Mux10			<="10";
					
			 elsif(inst(15 downto 12)="0100") then
					Mux3	<='0';
					Mux4  <="011";
					Mux5	<='0';
					Mux6	<='0';
					Mux9	<="101";
					Mux11	<='0';
					PC_Mux  	<="011";
					Mux10			<="10";
					
			elsif(inst(15 downto 12)="0101") then
					Mux3	<='0';
					Mux4  <="011";
					Mux5	<='0';
					Mux6	<='0';
					Mux9	<="000";
					Mux11	<='0';
					PC_Mux  	<="011";
					Mux10			<="11";
					
			 elsif(inst(15 downto 12)="1000" or inst(15 downto 12)="1001" or inst(15 downto 12)="1011") then
					Mux3	<='0';
					Mux4  <="001";
					Mux5	<='1';
					Mux6	<='1';
					Mux9	<="000";
					Mux11	<='1';
--					x <= '1' when (pp3(15 downto 12)="1000" or pp3(15 downto 12)="1011")
--		else '0';
--		
--		y <= '1' when (pp3(15 downto 12)="1001" or pp3(15 downto 12)="1011")
--		else '0';
--		
--		AND1: AND_2 port map(A=> x, B=> current_zero, Y=> t);
--		
--		AND2: AND_2 port map(A=> y, B=> current_carry, Y=> s)
					if(PC_En='1') then
						if((inst(15 downto 12)="1000" or inst(15 downto 12)="1011") and current_zero='1') then 
								PC_Mux  	<="001";
						elsif ((inst(15 downto 12)="1001" or inst(15 downto 12)="1011") and current_carry='1') then --RA-RB<0 when C=1
								PC_Mux  	<="001";
						else
								PC_Mux  	<="011";
						end if;
					else
							PC_Mux  	<="011";
					end if;
					Mux10			<="11";
			
			elsif(inst(15 downto 12)="1100") then
					Mux3	<='1';
					Mux4  <="001";
					Mux5	<='1';
					Mux6	<='1';
					Mux9	<="001";
					Mux11	<='0';
					if(PC_En='1') then
						PC_Mux  	<="001";
					else
						PC_Mux  	<="011";
					end if;
					Mux10			<="10";
					
			elsif(inst(15 downto 12)="1101") then
					Mux3	<='1';
					Mux4  <="010";
					Mux5	<='0';
					Mux6	<='0';
					Mux9	<="001";
					Mux11	<='0';
					if(PC_En='1') then
						PC_Mux  	<="010";
					else
						PC_Mux  	<="011";
					end if;
					
					Mux10			<="10";
					
			elsif(inst(15 downto 12)="1111") then
					Mux3	<='0';
					Mux4  <="100";
					Mux5	<='0';
					Mux6	<='0';
					Mux9	<="101";
					Mux11	<='0';
					if(PC_En='1') then
						PC_Mux  	<="000";
					else
						PC_Mux  	<="011";
					end if;
					
					Mux10			<="11";
					
			else
					nolatch<='1';
					Mux3	<='0';
					Mux4  <="000";
					Mux5	<='0';
					Mux6	<='0';
					Mux9	<="101";
					Mux11	<='0';
					PC_Mux  	<="011";
					Mux10			<="11";
					
			end if;
			
					
    end process;
end dec;