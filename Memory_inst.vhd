library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory_inst is
    port(clock, mem_rd, mem_wr: in std_logic; mem_add,mem_data: in std_logic_vector(15 downto 0);  mem_out: out std_logic_vector(15 downto 0) );
end entity;

architecture mem of Memory_inst is
    
    type mem_array is array(0 to 90) of std_logic_vector(15 downto 0);
	 signal outp: std_logic_vector(15 downto 0):="0000000000000000";
    signal RdWr: mem_array:= (
            0=>"0001000001010000",    --r0+r1 stored in r2 ada
            2=>"0001010101011010",    --r2+r5 stored in r3 adc 
				4=>"0001000001011011",    --r0+r1 stored in r3 awc
            6=>"0001011101010001",    --r3+r5 stored in r2 adz
            8=>"0001000001010100",    --r0+ complement r1 stored in r2 aca 
				10=>"0001000101010110",    --r0+ complement r5 stored in r2 acc
				12=>"0001000101010101",    --r0+ complement r5 stored in r2 acz
				14=>"0001000001011111",    --r0+ complement r1 stored in r3 acw
				16=>"0000000001000010",    --r0+2 stored in r1 adi
				18=>"0010000001010000",    --r0 nand r1 stored in r2 ndu
            20=>"0010000101010010",    --r0 nand r5 stored in r2 ndc 
            22=>"0010000101010001",    --r0 nand r5 stored in r2 ndz
            24=>"0010000001010100",    --r0 nand complement r1 stored in r2 ncu
            26=>"1101000010000000",    --(jlr)store PC+1 in R0 and branch to add in R2 
				28=>"1111000000000011",    -- (jri) branch to ro+3*2
            30=>"0011001000000110",     --6 in r1 lli (Load 0000000000000110in r1)
            32=>"0100001010001000",     --Load (lw)from address given by r2+8 in r1
            34=>"0101010100000111",     --Store(sw) in address given by r4+7 data of r2 
				36=>"0111011010100101",    --SM to corresponding address in r3,using r0,r2,5,7
				38=>"0001010001001000",    --r2+r1 stored in r1 ada
            40=>"0110011010100101",    --LM from corresponding address in r3,updating r0,r2,5,7
				42=>"0001000001010000",    --r0+r1 stored in r2 ada
				44=>"0001000001010000",    --r0+r1 stored in r2 ada
				
				
				--6=>"0001000001010000",    --r0+r1 stored in r2 ada
				--6=>"0010000101010001",    --r0 nand r5 stored in r2 ndz
				 
            
            
				--36=>"0111011010100101",    --SM to corresponding address in r3,using r0,r2,5,7
           --40=>"1000001010000101",    --beq if value in R1=R2  and branch to add PC+ 5*2 
				--40=>"1001001010000101",    --blt if value in R1<R2  and branch to add PC+ 5*2 
				--40=>"1011001010000101",    --ble if value in R1<=R2  and branch to add PC+ 5*2
				46=>"0001000001010000",    --r0+r1 stored in r2 ada
            --40=>"1101000010000000",    --(jlr)store PC+2 in R0 and branch to add in R2 
				--10=>"0001000001010000",    --r0+r1 stored in r2 ada
				--40=>"1100001000000101",    --(JAL)store PC+2 in R1 and branch to add PC+2*5  
				--40=>"0101010100000111",     --Store(sw) in address given by r4+7 data of r2 
				--40=>"1111000000000011",    -- (jri) branch to ro+3*2
				48=>"0100001010001000",     --Load (lw)from address given by r2+8 in r1
				50=>"0001000001010000",    --r0+r1 stored in r2 ada
				52=>"0001000001010000",    --r0+r1 stored in r2 ada
				54=>"0001000001010000",    --r0+r1 stored in r2 ada
				56=>"0001000001011011",    --r0+r1 stored in r3 awc
				58=>"0001000001011011",    --r0+r1 stored in r3 awc
				60=>"0010000101010110",    --r0 nand complement r5 stored in r2 ncc 
            62=>"0010000101010101",    --r0 nand complement r5 stored in r2 ncz
            64=>"0001000001010000",    --r0+r1 stored in r2 ada
            66=>"0001010101011010",    --r2+r5 stored in r3 adc 
            68=>"0001011101010001",    --r3+r5 stored in r2 adz
            
				70=>"0001000001010100",    --r0+ complement r1 stored in r2 aca 
            72=>"0001000101010110",    --r0+ complement r5 stored in r2 acc 
            74=>"0001000101010101",    --r0+ complement r5 stored in r2 acz
				76=>"0010000101010110",    --r0 nand complement r5 stored in r2 ncc 
				78=>"0010000001010000",    --r0 nand r1 stored in r2 ndu
            80=>"0010000101010010",    --r0 nand r5 stored in r2 ndc 
            82=>"0010000101010001",    --r0 nand r5 stored in r2 ndz
            84=>"0010000001010100",    --r0 nand complement r1 stored in r2 ncu
              others=>(others=>'0')
            );
begin
    mem_prc: process(clock, mem_add, mem_rd, mem_wr, RdWr,outp)
    
	 begin
			outp<="0000000000000000";
        if (clock'event and clock='0') then
            if(mem_wr='1') then
                RdWr(to_integer(unsigned(mem_add)))<=mem_data;
            end if;
        end if;
        if(mem_rd='1') then
            if(unsigned(mem_add)<=90) then
                outp<=RdWr(to_integer(unsigned(mem_add)));
            else
                outp<= "1110000000000000";
				end if;
        end if;
        mem_out<=outp;
    end process;
end mem;