library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
port(clk, reset,rg_wr: in std_logic; 
    RF_A3, RF_A1, RF_A2: in std_logic_vector(2 downto 0);RF_D3: in std_logic_vector(15 downto 0); RF_D1, RF_D2: out std_logic_vector(15 downto 0));
end entity;


architecture bhv of regfile is
--signal R0,R1:std_logic_vector(15 downto 0);
signal R0,R3,R4,R1,R6,R7: std_logic_vector(15 downto 0):="0000000000000010";
signal R2,R5: std_logic_vector(15 downto 0):="0000000000001110";
signal nolatch: std_logic;
begin
pr: process(clk, RF_A3, RF_A1 , RF_A2, RF_D3, rg_wr, R0 ,R1 ,R2 ,R3 ,R4 ,R5 ,R6 ,R7 )
begin
if(clk'event and clk='1') then
    if(rg_wr='1') then   
                case RF_A3 is
                when "000"=>
                        R0<=RF_D3;
                when "001"=>
                        R1<=RF_D3;  
                when "010"=>
                        R2<=RF_D3;
                when "011"=>
                        R3<=RF_D3;
                when "100"=>
                        R4<=RF_D3;
                when "101"=>
                        R5<=RF_D3;
                when "110"=>
                        R6<=RF_D3;
                when "111"=>
                        R7<=RF_D3;  
                when others=>
                        nolatch<='0'; 
                end case;
     else 
       nolatch<='0';
     end if;
end if;
    case RF_A1 is 
        when "000"=>
                RF_D1<=R0;
        when "001"=>
                RF_D1<=R1;  
        when "010"=>
                RF_D1<=R2;
        when "011"=>
                RF_D1<=R3;
        when "100"=>
                RF_D1<=R4;
        when "101"=>
                RF_D1<=R5;
        when "110"=>
                RF_D1<=R6;
        when "111"=>
                RF_D1<=R7;  
        when others=>
                nolatch<='0';    
    end case;

    case RF_A2 is 
        when "000"=>
                RF_D2<=R0;
        when "001"=>
                RF_D2<=R1;  
        when "010"=>
                RF_D2<=R2;
        when "011"=>
                RF_D2<=R3;
        when "100"=>
                RF_D2<=R4;
        when "101"=>
                RF_D2<=R5;
        when "110"=>
                RF_D2<=R6;
        when "111"=>
                RF_D2<=R7;  
        when others=>
              nolatch<='0';   
    end case;
	 end process;

end bhv;