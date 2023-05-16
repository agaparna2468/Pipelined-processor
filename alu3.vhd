library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity alu3 is
port (ALU3_A, ALU3_B: in std_logic_vector(15 downto 0); 
carry, zero:out std_logic; ALU3_C: out std_logic_vector(15 downto 0));
end entity;

architecture alu3_beh of alu3 is
        function add(A: in std_logic_vector(15 downto 0);
        B: in std_logic_vector(15 downto 0))
        return std_logic_vector is
        variable sum : std_logic_vector(15 downto 0);
        variable carry : std_logic_vector(15 downto 0);
        begin
        L1 : for i in 0 to 15 loop
                    if i = 0 then 
                        sum(i) := ((A(i) xor B(i)) xor '0');
                            carry(i) := (A(i) and B(i));
                            
                    else 
                        sum(i) := A(i) xor B(i) xor carry(i-1);
                        carry(i) := (A(i) and B(i)) or  (carry(i-1) and ( A(i) or B(i) ));
                    end if;
                    end loop L1;
        return carry(15) & sum;       
        end add;

--------------------------------------------------------------------------------------------------------------------------------------
signal x:  std_logic_vector(16 downto 0):="00000000000000000";
begin

alu_proc: process( ALU3_A, ALU3_B, x )


begin 

  
		 x <= add(ALU3_A, ALU3_B);
		 ALU3_C<= x(15 downto 0);
		 carry<=x(16);
		 if(x= "00000000000000000") then
			zero<='1';
		 else
			zero<='0';
		 end if;

end process; 
end alu3_beh;    