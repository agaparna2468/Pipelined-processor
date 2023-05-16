library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity psw is
port(clk, reset,carry_en, zero_en: in std_logic; 
    carry_wr, zero_wr: in std_logic; carry_rd, zero_rd: out std_logic);
end entity;


architecture bhv of psw is

signal carry, zero: std_logic:='0';

signal nolatch: std_logic;
begin
pr: process(clk, reset,carry_en, zero_en,carry_wr, zero_wr, carry, zero )
begin
if(clk'event and clk='1') then
    if(carry_en='1') then   
                carry<=carry_wr;
    else 
       nolatch<='0';
    end if;
	 if(zero_en='1') then   
                zero<=zero_wr;
    else 
       nolatch<='0';
    end if;
end if;
carry_rd<=carry;
zero_rd<=zero;
end process;

end bhv;