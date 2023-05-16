library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity alu2 is
port (ALU2_A, ALU2_B: in std_logic_vector(15 downto 0); 
ALU2_C: out std_logic_vector(15 downto 0));
end entity;

architecture alu2_beh of alu2 is
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
        return sum;       
        end add;

--------------------------------------------------------------------------------------------------------------------------------------
signal x:  std_logic_vector(15 downto 0):="0000000000000000";
begin

alu_proc: process( ALU2_A, ALU2_B, x )


begin 

  
		 x <= add(ALU2_A, ALU2_B);
		 ALU2_C<= x(15 downto 0);


end process; 
end alu2_beh;    