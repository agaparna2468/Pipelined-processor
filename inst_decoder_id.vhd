library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst_decoder_id is
    port(inst: in std_logic_vector(15 downto 0); 
	 mem_data_wr, mem_data_rd, RF_wr, SE9_en, SE6_en, Ones_en, Az9, C_en, Z_en, Mux1, Mux2, PC_en: out std_logic;
	 ALU1_INST: out std_logic_vector(1 downto 0));
end entity inst_decoder_id;

architecture id of inst_decoder_id is
    signal nolatch: std_logic;
begin
    id_dec: process(inst)
    
	 begin
			if(inst(15 downto 12)="0001") then
					mem_data_wr		<='0';
					mem_data_rd		<='0';
					RF_wr				<='1';
					SE9_en			<='0';
					SE6_en			<='0';
					Ones_en			<='0';
					Az9				<='0';
					C_en				<='1';
					Z_en				<='1';
					Mux1				<='0';
					Mux2				<='1';
					PC_en				<='0';
					if(inst(2)='1') then
							ALU1_INST<="10";
					else 
							ALU1_INST<="00";
					end if;
					
			elsif(inst(15 downto 12)="0000") then
					mem_data_wr		<='0';
					mem_data_rd		<='0';
					RF_wr				<='1';
					SE9_en			<='0';
					SE6_en			<='1';
					Ones_en			<='0';
					Az9				<='0';
					C_en				<='1';
					Z_en				<='1';
					Mux1				<='0';
					Mux2				<='1';
					PC_en				<='0';
					ALU1_INST		<="00";
					
			elsif(inst(15 downto 12)="0010") then
					mem_data_wr		<='0';
					mem_data_rd		<='0';
					RF_wr				<='1';
					SE9_en			<='0';
					SE6_en			<='0';
					Ones_en			<='0';
					Az9				<='0';
					C_en				<='0';
					Z_en				<='1';
					
					Mux2				<='1';
					PC_en				<='0';
					if(inst(2)='1') then
							ALU1_INST<="10";
							Mux1		<='1';
					else 
							ALU1_INST<="01";
							Mux1		<='0';
					end if;
					
			 elsif(inst(15 downto 12)="0011") then
			 
					mem_data_wr	<='0';
					mem_data_rd	<='0';
					RF_wr			<='1';
					SE9_en		<='0';
					SE6_en		<='0';
					Ones_en		<='0';
					Az9			<='1';
					C_en			<='0';
					Z_en			<='0';
					Mux1			<='0';
					Mux2			<='0';
					PC_en			<='0';
					ALU1_INST	<="11";	
					
			 elsif(inst(15 downto 12)="0100") then
					mem_data_wr	<='0';
					mem_data_rd	<='1';
					RF_wr			<='1';
					SE9_en		<='0';
					SE6_en		<='1';
					Ones_en		<='0';
					Az9			<='0';
					C_en			<='0';
					Z_en			<='1';
					Mux1			<='1';
					Mux2			<='0';
					PC_en			<='0';
					ALU1_INST	<="00";	
					
			elsif(inst(15 downto 12)="0101") then
					mem_data_wr	<='1';
					mem_data_rd	<='0';
					RF_wr			<='0';
					SE9_en		<='0';
					SE6_en		<='1';
					Ones_en		<='0';
					Az9			<='0';
					C_en			<='0';
					Z_en			<='0';
					Mux1			<='1';
					Mux2			<='0';
					PC_en			<='0';
					ALU1_INST	<="00";	
					
			 elsif(inst(15 downto 12)="1000" or inst(15 downto 12)="1001" or inst(15 downto 12)="1011") then
					mem_data_wr	<='0';
					mem_data_rd	<='0';
					RF_wr			<='0';
					SE9_en		<='0';
					SE6_en		<='1';
					Ones_en		<='1';
					Az9			<='0';
					C_en			<='0';
					Z_en			<='0';
					Mux1			<='0';
					Mux2			<='1';
					PC_en			<='1';
					ALU1_INST	<="10";
			
			elsif(inst(15 downto 12)="1100") then
					mem_data_wr	<='0';
					mem_data_rd	<='0';
					RF_wr			<='1';
					SE9_en		<='1';
					SE6_en		<='0';
					Ones_en		<='1';
					Az9			<='0';
					C_en			<='0';
					Z_en			<='0';
					Mux1			<='0';
					Mux2			<='0';
					PC_en			<='1';
					ALU1_INST	<="00";	
					
			elsif(inst(15 downto 12)="1101") then
					mem_data_wr	<='0';
					mem_data_rd	<='0';
					RF_wr			<='1';
					SE9_en		<='0';
					SE6_en		<='0';
					Ones_en		<='0';
					Az9			<='0';
					C_en			<='0';
					Z_en			<='0';
					Mux1			<='0';
					Mux2			<='1';
					PC_en			<='1';
					ALU1_INST	<="00";	
					
			elsif(inst(15 downto 12)="1111") then
					mem_data_wr	<='0';
					mem_data_rd	<='0';
					RF_wr			<='0';
					SE9_en		<='1';
					SE6_en		<='0';
					Ones_en		<='1';
					Az9			<='0';
					C_en			<='0';
					Z_en			<='0';
					Mux1			<='0';
					Mux2			<='0';
					PC_en			<='1';
					ALU1_INST	<="00";	
					
			else
					nolatch<='1';
					mem_data_wr	<='0';
					mem_data_rd	<='0';
					RF_wr			<='0';
					SE9_en		<='0';
					SE6_en		<='0';
					Ones_en		<='0';
					Az9			<='0';
					C_en			<='0';
					Z_en			<='0';
					Mux1			<='0';
					Mux2			<='0';
					PC_en			<='0';
					ALU1_INST	<="11";
			end if;
			
					
    end process;
end id;