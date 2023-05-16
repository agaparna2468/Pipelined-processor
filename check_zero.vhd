library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity check_zero is
port (A: in std_logic_vector(15 downto 0); 
zero:out std_logic);
end entity;

architecture beh of check_zero is
begin

proc: process( A )


begin 

  
		 if(A= "0000000000000000") then
			zero<='1';
		 else
			zero<='0';
		 end if;

end process; 
end beh;    