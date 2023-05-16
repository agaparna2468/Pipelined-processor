library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.Gates.all;

entity datapath is

port (clk, reset: in std_logic ; finalout: out std_logic_vector(55 downto 0) );

end entity datapath;

architecture bhv of datapath is

component inst_decoder_id is
    port(inst: in std_logic_vector(15 downto 0); mem_data_wr, mem_data_rd, RF_wr, SE9_en, SE6_en, Ones_en, Az9, C_en, Z_en, Mux1, Mux2, PC_en: out std_logic; ALU1_INST: out std_logic_vector(1 downto 0));
end component inst_decoder_id;

component oneshift is
		port (inp :in std_logic_vector(15 downto 0); OneS: in std_logic; output: out std_logic_vector(15 downto 0));
end component;

component SignE9 is 
	port (input1: in std_logic_vector(8 downto 0); se9: in std_logic; output: out std_logic_vector(15 downto 0));
end component;

component SignE6 is 
	port (input1: in std_logic_vector(5 downto 0); se6: in std_logic; output: out std_logic_vector(15 downto 0));
end component;

component Memory_data is
    port(clock, mem_rd, mem_wr: in std_logic; mem_add,mem_data: in std_logic_vector(15 downto 0);  mem_out: out std_logic_vector(15 downto 0) );
end component;

component Memory_inst is
    port(clock, mem_rd, mem_wr: in std_logic; mem_add,mem_data: in std_logic_vector(15 downto 0);  mem_out: out std_logic_vector(15 downto 0) );
end component;

component alu1 is
	port (ALU1_A, ALU1_B: in std_logic_vector(15 downto 0); ALU1_INST: in std_logic_vector(1 downto 0); ALU1_C: out std_logic_vector(15 downto 0); carry, zero:out std_logic);
end component;

component ff_16 is 
		port(En,clock,reset:in std_logic; D1: in std_logic_vector(15 downto 0); Q:out std_logic_vector(15 downto 0));
end component ff_16;
	
component regfile is
port(clk, reset,rg_wr: in std_logic; RF_A3, RF_A1, RF_A2: in std_logic_vector(2 downto 0);RF_D3: in std_logic_vector(15 downto 0); RF_D1, RF_D2: out std_logic_vector(15 downto 0));
end component;

component ff_1 is 
		port(D1, En,clock,reset:in std_logic; Q:out std_logic);
end component ff_1;

component PC_signalcontrol is 
		port(D1: in std_logic_vector(2 downto 0); En:in std_logic; Q: out std_logic_vector(2 downto 0));
end component PC_signalcontrol;

component alu is
port (ALU_A, ALU_B: in std_logic_vector(15 downto 0); ALU_INST: in std_logic_vector(1 downto 0); 
ALU_C: out std_logic_vector(15 downto 0); carry, zero:out std_logic);
end component;

component Addzeroes9 is 
	port(input1: in std_logic_vector(8 downto 0); az: in std_logic; output: out std_logic_vector(15 downto 0));
end component; 

component alu2 is
	port (ALU2_A, ALU2_B: in std_logic_vector(15 downto 0); ALU2_C: out std_logic_vector(15 downto 0));
end component;

component alu3 is
port (ALU3_A, ALU3_B: in std_logic_vector(15 downto 0); carry, zero:out std_logic; ALU3_C: out std_logic_vector(15 downto 0));
end component;

component pipeline1 is 
		port(En,clock,reset:in std_logic; D2: in std_logic_vector(31 downto 0); Q:out std_logic_vector(31 downto 0));
end component pipeline1;

component pipeline2 is 
		port(En,clock,reset:in std_logic; D2: in std_logic_vector(45 downto 0); Q:out std_logic_vector(45 downto 0));
end component pipeline2;
	
component pipeline3 is 
		port(En,clock,reset:in std_logic; D3: in std_logic_vector(77 downto 0); Q:out std_logic_vector(77 downto 0));
end component pipeline3;

component pipeline4 is 
		port(En,clock,reset:in std_logic; D4: in std_logic_vector(89 downto 0); Q:out std_logic_vector(89 downto 0));
end component pipeline4;
	
component pipeline5 is 
		port(En,clock,reset:in std_logic; D5: in std_logic_vector(55 downto 0); Q:out std_logic_vector(55 downto 0));
end component pipeline5;
	
component psw is
port(clk, reset,carry_en, zero_en: in std_logic; carry_wr, zero_wr: in std_logic; carry_rd, zero_rd: out std_logic);
end component;

component mux2_1 is
port(A,B : in std_logic_vector (15 downto 0); S: in STD_LOGIC; Z: out std_logic_vector (15 downto 0));
end component mux2_1;

component mux2_1_3i is
port(A,B : in std_logic_vector (2 downto 0); S: in STD_LOGIC; Z: out std_logic_vector (2 downto 0));
end component mux2_1_3i;

component mux4_1 is
port(A,B,C,D : in std_logic_vector (15 downto 0); S: in std_logic_vector (1 downto 0); Z: out std_logic_vector (15 downto 0));
end component mux4_1;

component mux4_1_3i is
port(A,B,C,D : in std_logic_vector (2 downto 0); S: in std_logic_vector (1 downto 0); Z: out std_logic_vector (2 downto 0));
end component mux4_1_3i;

component mux2_1_i is
port(A,B : in std_logic; S: in STD_LOGIC; Z: out std_logic);
end component mux2_1_i;

component mux6_1 is
port(A,B,C,D,E,F : in std_logic_vector (15 downto 0); S: in std_logic_vector (2 downto 0); Z: out std_logic_vector (15 downto 0));
end component mux6_1;

component mux5_1 is
port(A,B,C,D,E : in std_logic_vector (15 downto 0); S: in std_logic_vector (2 downto 0); Z: out std_logic_vector (15 downto 0));
end component mux5_1;

component stage4_dec is
    port(inst: in std_logic_vector(15 downto 0); PC_En, current_carry, current_zero,prev_carry: in std_logic; Mux3, Mux5, Mux6, Mux11: out std_logic; Mux4, Mux9: out std_logic_vector(2 downto 0);PC_Mux:out std_logic_vector(2 downto 0); Mux10: out std_logic_vector(1 downto 0));
end component stage4_dec;

component stage5_dec is 
	port(inst: in std_logic_vector(15 downto 0); Mux12: out std_logic);
end component stage5_dec;

component check_zero is
port (A: in std_logic_vector(15 downto 0); zero:out std_logic);
end component check_zero;

component mux4_1_i is
port(A,B,C,D : in std_logic; S: in std_logic_vector (1 downto 0); Z: out std_logic);
end component mux4_1_i;
	
component check_number_ones is 
	port(instruc: in std_logic_vector(15 downto 0); output: out std_logic_vector(3 downto 0));
end component check_number_ones;

component priority_enco is 
	port(inst: in std_logic_vector(7 downto 0); output: out std_logic_vector(2 downto 0));
end component;

component priority_enco_modifier is 
	port(A: in std_logic_vector(7 downto 0); output: out std_logic_vector(7 downto 0));
end component;

component ADDzeroes3 is 
	port(input1: in std_logic_vector(3 downto 0); output: out std_logic_vector(5 downto 0));
end component ADDzeroes3;

signal count: integer:= 0; 
signal PC_out: std_logic_vector(15 downto 0):= "0000000000101000";
signal pp1inp: std_logic_vector(31 downto 0);
signal PC_intermediate: std_logic_vector(15 downto 0):="0000000000101000";
signal inst1: std_logic_vector(15 downto 0);
signal pp1: std_logic_vector(31 downto 0);

signal PC_intermediate2: std_logic_vector(15 downto 0):="0000000000101000" ;


signal pp2inp: std_logic_vector(45 downto 0);
signal pp2: std_logic_vector(45 downto 0);

signal mem_data_wr, mem_data_rd, RF_wr, SE9_en, SE6_en, Ones_en, Az9, C_en, Z_en, Mux1, Mux2, PC_en: std_logic;
signal ALU1_INST: std_logic_vector(1 downto 0);

signal A1, A2: std_logic_vector(2 downto 0);
signal temp_D1, temp_D2, D1, D2: std_logic_vector(15 downto 0);

signal prev_carry, prev_zero, c, z: std_logic:='0';
signal pp3inp: std_logic_vector(77 downto 0);
signal pp3: std_logic_vector(77 downto 0);

signal ALU1_A, ALU1_B, ALU1_C, ALU3_A, ALU3_B, ALU3_C: std_logic_vector(15 downto 0);
signal current_alu1_carry, current_alu1_zero, current_alu3_carry, current_alu3_zero, current_carry, current_zero: std_logic;
signal se9_out, se6_out, Ones_out, Ones_in, az_out: std_logic_vector(15 downto 0);
signal t,s: std_logic;
signal x,y: std_logic;
signal switch: std_logic;
signal temp_D3: std_logic_vector(15 downto 0);
signal S3, S4: std_logic_vector(1 downto 0);
signal En1: std_logic;

signal Mux3, Mux5, Mux6, Mux11: std_logic;
signal PC_Mux, PC_MuxU: std_logic_vector(2 downto 0):= "100";
signal Mux9, Mux4: std_logic_vector(2 downto 0);
signal pp4inp: std_logic_vector(89 downto 0);
signal pp4: std_logic_vector(89 downto 0);

signal mem_dataout: std_logic_vector(15 downto 0);
signal D3: std_logic_vector(15 downto 0);
signal A3: std_logic_vector(2 downto 0);
signal Mux12: std_logic;
signal Mux10: std_logic_vector(1 downto 0);
signal pp5inp:		 std_logic_vector(55 downto 0);
signal pp5: std_logic_vector(55 downto 0);

signal throw: std_logic;
signal stall: std_logic;
signal S5: std_logic;
signal En3, Enpp2, Enpp1: std_logic;
signal S6: std_logic_vector(1 downto 0);
signal mem_zero: std_logic;

signal LM, SM: std_logic_vector(1 downto 0);
signal check_no: std_logic_vector(3 downto 0);
signal lm_sm_count: std_logic_vector(5 downto 0);
signal stall_for_LM: std_logic;
signal inst_to_dec: std_logic_vector(15 downto 0);
signal Add_dummy: std_logic_vector(2 downto 0);
signal LM_SM_dummy: std_logic_vector(7 downto 0);
signal stall_for_sM: std_logic;

begin

		--stage1 Instruction Fetch
	
		count <= count +1 when (clk'event and (clk='1'))
			else count;
			
		
		En3 <= '1' when (count=0)
					else '0' when (stall='1')  
					else '0' when (stall_for_LM='1')
					else '0' when (stall_for_sM='1')
					else '1';
		
		Enpp2 <= '1' when (count=0)
					else '0' when (stall='1') 
					else '1';
		
		Enpp1 <= '1' when (count=0)
					else '0' when (stall='1') 
						else '1';
		
		PC_reg: ff_16 port map(En=> En3, clock=>clk, reset=> reset, D1=> PC_intermediate, Q=> PC_out);		--PC has to update in all cycles
		
		alu_pc: alu2 port map(ALU2_A => PC_out, ALU2_B=> "0000000000000010",  ALU2_C=>PC_intermediate2 );		--has current PC as PC_inp which is added with 2 and then when new cycle begins PC ff is updated by PC+2 but mem reads PC_inp as PC changed after rising edge 			
		
		mem_inst: Memory_inst port map(clock=> clk, mem_rd => '1' , mem_wr=>'0',  mem_add => PC_out ,mem_data=>(others=>'0'),  mem_out=>inst1);  --inst1 has current inst
	 
		pp1inp(31 downto 16) <= PC_out ;
		
		pp1inp(15 downto 0) <= pp1(15 downto 8) & LM_SM_dummy when (stall_for_LM='1' and throw='0')
										else pp1(15 downto 8) & LM_SM_dummy when (stall_for_sM='1' and throw='0')
										else inst1 when (throw='0')
										else "1110000000000000";
		
		pipel1: pipeline1 port map (En=> Enpp1, clock=> clk, reset=> reset, D2=> pp1inp,  Q => pp1);
	
		--stage2 Instruction Decoder
		
		check_num: check_number_ones port map (instruc=> pp1(15 downto 0), output=>check_no);
		
		LM <= "11" when (pp1(15 downto 12)="0110" and check_no/="0000" and check_no/="0001")
						else "10" when (pp1(15 downto 12)="0110" and (check_no="0001" or check_no="0000"))
						else "00";
						
		SM <= "11" when (pp1(15 downto 12)="0111" and check_no/="0000" and check_no/="0001")
						else "10" when (pp1(15 downto 12)="0111" and (check_no="0001" or check_no="0000"))
						else "00";
						
		stall_for_LM<='1' when (LM="11")
							else '0';
							
		stall_for_SM<='1' when (SM="11")
							else '0';
		
		enc: priority_enco port map(inst=> pp1(7 downto 0), output => Add_dummy);
		modi: priority_enco_modifier port map(A=> pp1(7 downto 0), output => LM_SM_dummy);

		AZ3: ADDzeroes3 port map(input1=> check_no, output=> lm_sm_count);
		
		inst_to_dec<= "0100" & Add_dummy & pp1(11 downto 9) & lm_sm_count when (LM/="00")
							else "0101" & Add_dummy & pp1(11 downto 9) & lm_sm_count when (SM/="00")
							else pp1(15 downto 0);
							
		inst_decoder: inst_decoder_id port map(inst => inst_to_dec, mem_data_wr => mem_data_wr, mem_data_rd => mem_data_rd, RF_wr => RF_wr, SE9_en => SE9_en, SE6_en => SE6_en, Ones_en => Ones_en, Az9 => Az9, C_en => C_en, Z_en => Z_en, Mux1 => Mux1, Mux2 => Mux2, PC_en => PC_en, ALU1_INST => ALU1_INST);

		pp2inp(45 downto 42) <=   Mux1 & Mux2 & ALU1_INST;
		pp2inp(38 downto 35) <=  SE9_en & SE6_en & Ones_en & Az9;
		
		pp2inp(15 downto 0) <=  inst_to_dec;
		
		pp2inp(31 downto 16) <=   pp1(31 downto 16);
		
		pp2inp(41 downto 39)<="000" when (throw='1')
										else mem_data_wr & mem_data_rd & RF_wr;
		
		pp2inp(34 downto 32)<= "000" when (throw='1')
										else C_en & Z_en  & PC_en;
										
		pipel2: pipeline2 port map (En=> Enpp2,clock => clk,reset=> reset,  D2=> pp2inp, Q=> pp2);

    	--stage3 Register Read
		
		Mux1_component: mux2_1_3i port map (A=> pp2(11 downto 9) ,B => pp2(8 downto 6), S=> pp2(45) , Z=>A1);

		Mux2_component: mux2_1_3i port map (A=> pp2(11 downto 9) ,B => pp2(8 downto 6), S=> pp2(44) , Z=>A2);

		register_file: regfile port map (clk => clk, reset=> reset, rg_wr => pp5(36), RF_A3 => pp5(39 downto 37), RF_A1 => A1, RF_A2=> A2, RF_D3 => pp5(55 downto 40),  RF_D1 => temp_D1, RF_D2 => temp_D2);
		
		pp3inp(77 downto 42) <= D1 & D2 & prev_carry & prev_zero & pp2(43 downto 42);
		
		pp3inp(41 downto 39)<="000" when (pp2(15 downto 12)="0001" and ((pp2(1 downto 0)="10" and prev_carry='0') or (pp2(1 downto 0)="01" and prev_zero='0'))) 
											 else "000" when (throw='1' or stall='1')
											 else pp2(41 downto 39);
				--pp3inp(41 downto 39)<="000";
		pp3inp(34 downto 32)<="000" when (pp2(15 downto 12)="0001" and ((pp2(1 downto 0)="10" and prev_carry='0') or (pp2(1 downto 0)="01" and prev_zero='0'))) 
											 else "000" when (throw='1' or stall='1')
											 else pp2(34 downto 32);
											 
		
		--else
				--pp3inp(41 downto 39)<=pp2(41 downto 39);
				--pp3inp(34 downto 32)<=pp2(34 downto 32);
		--end if;
			
		pp3inp(38 downto 35)<= pp2(38 downto 35);
		pp3inp(31 downto 0)<= pp2(31 downto 0);
		
		pipel3: pipeline3 port map (En=> '1',clock => clk,reset=> reset,  D3=> pp3inp, Q=> pp3);
		
		--prev carry and zero is not current carry and zero of next stage until next stage can modify carry and zero
		--if next stage can modify carry and zero then prev carry n zero are modified
		
		
		--stage4 Execute
		
		Execute_dec: stage4_dec port map(inst=> pp3(15 downto 0),PC_En=> pp3(32),current_carry=> current_carry, current_zero => current_zero, prev_carry=> pp3(45), Mux3=> Mux3, Mux5=> Mux5, Mux6=> Mux6, Mux11=> Mux11,Mux4 => Mux4, Mux9=> Mux9, PC_Mux=> PC_Mux, Mux10=> Mux10);
		
		Mux3_component: mux2_1 port map (A=> pp3(77 downto 62) ,B => pp3(31 downto 16), S=> Mux3, Z=>ALU1_A);

		Mux4_component: mux6_1 port map (A=> se9_out ,B => pp3(61 downto 46), C=> "0000000000000010", D=> se6_out, E=>  Ones_out, F=> (others=>'0'), S=> Mux4 , Z=>ALU1_B);
		
		ALU1_component: alu1 port map(ALU1_A=> ALU1_A, ALU1_B=> ALU1_B, ALU1_INST=> pp3(43 downto 42) , ALU1_C=> ALU1_C, carry => current_alu1_carry, zero => current_alu1_zero);
		
		Mux5_component: mux2_1 port map (A=> ALU1_C ,B => Ones_out, S=> Mux5 , Z=>ALU3_A);
		
		Mux6_component: mux2_1 port map (A=> "0000000000000001" ,B => pp3(31 downto 16), S=> Mux6 , Z=>ALU3_B);
		
		ALU3_component: alu3 port map(ALU3_A=> ALU3_A, ALU3_B => ALU3_B, carry=> current_alu3_carry, zero=> current_alu3_zero, ALU3_C=> ALU3_C);
		
		current_carry<= current_alu3_carry when((pp3(15 downto 12)="0001" and pp3(1 downto 0)="11")  and pp3(45)='1')
													  else current_alu1_carry;
													  
		current_zero<= current_alu3_zero when((pp3(15 downto 12)="0001" and pp3(1 downto 0)="11")  and pp3(44)='1')
													  else current_alu1_zero;
			 --current_carry<= current_alu3_carry;
			 --current_zero<= current_alu3_zero;
		--else
			 --current_carry<= current_alu1_carry;
			 --current_zero<= current_alu1_zero;
		--end if;
		
		addzero_component: Addzeroes9 port map(input1=> pp3(8 downto 0), az=> pp3(35) ,output=> az_out);
		
		se9_component: SignE9 port map( input1=> pp3(8 downto 0), se9=> pp3(38), output=> se9_out); 
		
		se6_component: SignE6 port map(input1=> pp3(5 downto 0), se6=> pp3(37), output=> se6_out);
		
		Mux11_component: mux2_1 port map (A=> se9_out ,B => se6_out, S=> Mux11 , Z=>Ones_in);
		
		oneshift_component: oneshift port map(inp => Ones_in, OneS=> pp3(36), output=> Ones_out);
		
		Mux9_component: mux6_1 port map (A=> az_out ,B => ALU1_C, C=> se9_out , D=> pp3(31 downto 16), E=> ALU3_C, F=> "0000000000000000", S=> Mux9 , Z=>temp_D3);
		
		--throw 3 instructions
		En1<= '0' when (count=0) else '1';
		
		
		PC_Muxcomponent: PC_signalcontrol port map(D1=> PC_Mux,En=> En1, Q => PC_MuxU);

		
		PCMux_component: mux5_1 port map(A => ALU1_C,B => ALU3_C, C=> pp3(61 downto 46), D=>PC_intermediate2,E => "0000000000101000" ,S=> PC_MuxU, Z=> PC_intermediate);
		
		throw<= '1' when (PC_MuxU="000" or PC_MuxU="001" or PC_MuxU="010")
			else '0';
			
--		PC_intermediate<= PC_intermediate2 when (pp3(32)='0')
--		else PC_intermediate2 when (((pp3(15 downto 12)="1000" or pp3(15 downto 12)="1001" or pp3(15 downto 12)="1011")) and (switch='0'))
--			else branched_PC;

		S5<= '0' when (pp3(34)='1')						--carry forward from Execute
		else '1';															--normal RR
		
		
		S6<= "00" when (pp3(33)='1')						--zero forward from Execute
		else "01" when   (pp4(32)='1')										--zero forward from Mem for load
		else "11";															--normal RR
		
		
		
		Mux_15: mux2_1_i port map (A=> current_carry ,B => prev_carry,  S=> S5 , Z=> prev_carry);
		
		Mux_16: mux4_1_i port map (A=> current_zero ,B=> mem_zero, C=>'0', D => prev_zero,  S=> S6 , Z=> prev_zero);
			
		Mux10_component: mux4_1_3i port map(A=> pp3(5 downto 3),B=> pp3(8 downto 6),C=> pp3(11 downto 9),D =>(others=>'0') , S=> Mux10, Z=>A3);
	
		stall<= '1' when (pp3(15 downto 12)="0100" and pp3(39)='1' and ((A3 = A2) or (A3 = A1)))
					else '1' when (pp3(15 downto 12)="0100" and pp2(15 downto 12)= "0001" and pp2(1 downto 0)="01")
					else '1' when (pp3(15 downto 12)="0100" and pp2(15 downto 12)= "0010" and pp2(1 downto 0)="01")
					else '0';
		
		pp4inp <=   A3 & current_carry & current_zero & ALU1_C & temp_D3 & pp3(61 downto 46) & pp3(41 downto 39) & pp3(34 downto 33) & pp3(31 downto 0);
		
		pipel4: pipeline4 port map (En=>'1',clock => clk,reset=> reset, D4=> pp4inp, Q=>pp4);
	
		--stage5 Memory access
		
		Mem_stage_dec: stage5_dec port map(inst=> pp4(15 downto 0), Mux12=> Mux12);
	 
		mem_data: Memory_data port map(clock => clk, mem_rd => pp4(35), mem_wr=> pp4(36) ,mem_add=> pp4(84 downto 69),mem_data=> pp4(52 downto 37),  mem_out=> mem_dataout );
		
		check_zero_comp: check_zero port map (A => mem_dataout, zero => mem_zero);


		Mux12_component: mux2_1 port map (A=>  mem_dataout ,B => pp4(68 downto 53), S=> Mux12 , Z=>D3);
		
--		S3<='1' when ((pp4(89 downto 87)=A1) and  pp4(34)='1')
--		else '0';
--		
--		S4<='1' when ((pp4(89 downto 87)=A2) and  pp4(34)='1')
--		else '0';
--		
--		Mux_solving_dataforward1: mux2_1 port map (A=> temp_D1 ,B => temp_D3, S=> S3 , Z=>D1);
--		
--		Mux_solving_dataforward2: mux2_1 port map (A=> temp_D2 ,B => temp_D3, S=> S4 , Z=>D2);

		pp5inp<= D3 & pp4(89 downto 87) & pp4(34) & pp4(86 downto 85) & pp4(33 downto 32) & pp4(31 downto 0);
		--RF_WR, current carry, zero, carry en zero en
		
		S3<="00" when ((A3=A1) and  pp3(39)='1')  						--data forward from Execute
		else "11" when ((pp4(89 downto 87)=A1) and  pp4(34)='1')		--data forward from Mem Access
		else "10" when ((pp5(39 downto 37)=A1) and  pp5(36)='1')		--data forward from Write Back
		else "01";																--normal RR
		
		
		S4<="00" when ((A3=A2) and  pp3(39)='1')
		else "11" when ((pp4(89 downto 87)=A2) and  pp4(34)='1')
		else "10" when ((pp5(39 downto 37)=A2) and  pp5(36)='1')
		else "01";
		
		
		Mux_solving_dataforward1: mux4_1 port map (A=> temp_D3 ,B => temp_D1, C=> pp5(55 downto 40), D=> D3, S=> S3 , Z=>D1);
		
		Mux_solving_dataforward2: mux4_1 port map (A=> temp_D3 ,B => temp_D2, C=> pp5(55 downto 40), D=>D3, S=> S4 , Z=>D2);
		
		pipel5: pipeline5 port map (En=>'1',clock => clk,reset=> reset, D5=> pp5inp, Q=>pp5);
		
		--stage6 Write Back
		
	
		psw_component: psw port map(clk=> clk, reset => reset ,carry_en => pp5(33), zero_en=> pp5(32),carry_wr=> pp5(35), zero_wr=> pp5(34), carry_rd=> c, zero_rd=> z);
		
		
		--check output
		finalout<= pp5(36) & pp5(33 downto 32) & pp5(35 downto 34) & pp5(39 downto 37) & pp5(55 downto 40) & pp5(31 downto 0);
		--RF_WR,carry en, zero en, current carry, zero, A3, D3, PC, inst
end bhv;
