library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--00 IS add, 01 is nand, 10 is sub
entity alu1 is
port (ALU1_A, ALU1_B: in std_logic_vector(15 downto 0); 
ALU1_INST: in std_logic_vector(1 downto 0); 
ALU1_C: out std_logic_vector(15 downto 0); carry, zero:out std_logic);
end entity;

architecture alu1_beh of alu1 is
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
        function nandbit(A: in std_logic_vector(15 downto 0);
        B: in std_logic_vector(15 downto 0))
        return std_logic_vector is
        variable nandr : std_logic_vector(15 downto 0);
        begin
        L1 : for i in 0 to 15 loop
        nandr(i) := A(i) NAND B(i) ;
        end loop L1;
        return nandr;       
        end nandbit;
--------------------------------------------------------------------------------------------------------------------------------------
        function sub(A: in std_logic_vector(15 downto 0);
        B: in std_logic_vector(15 downto 0))
        return std_logic_vector is
        variable diff : std_logic_vector(15 downto 0):= (others=>'0');
        variable carry : std_logic_vector(15 downto 0):= (others=>'0');
        begin
        L1: for i in 0 to 15 loop
                if i=0 then
                    diff(i)  := A(i) xor B(i);
                    carry(i) := (not(A(i)) and B(i));
                else
                    diff(i)  := (not A(i) and not B(i) and carry(i-1)) or (A(i) and not B(i) and not carry(i-1)) or (not A(i) and B(i) and not carry(i-1)) or (A(i) and B(i) and carry(i-1));
                    carry(i) := ((not A(i)) and B(i)) or (not A(i) and carry(i-1)) or ((B(i)) and carry(i-1));
        end if;
        end loop L1;
        return carry(15) & diff;
        end sub;
--------------------------------------------------------------------------------------------------------------------------------------
signal x:  std_logic_vector(16 downto 0):="00000000000000000";
begin

alu_proc: process(ALU1_INST, ALU1_A, ALU1_B, x )


begin 

    if (ALU1_INST="00") then
          x <= add(ALU1_A, ALU1_B);
          ALU1_C<= x(15 downto 0);
          carry<=x(16);
          if(x(15 downto 0) ="0000000000000000") then
               zero<= '1';
          else 
               zero<='0';
          end if;

          
    elsif(ALU1_INST="01") then
        ALU1_C<=nandbit(ALU1_A, ALU1_B);
        if(nandbit(ALU1_A, ALU1_B) ="0000000000000000") then
               zero<= '1';
          else 
               zero<='0';
        end if;
        carry<='0';
		  x<="00000000000000000";
    
    elsif(ALU1_INST="10") then
        x<=sub(ALU1_A, ALU1_B);
        ALU1_C<= x(15 downto 0);
          carry<=x(16);
        if(x(15 downto 0)="0000000000000000") then
               zero<= '1';
          else 
               zero<='0';
        end if;
		  

    else 
    ALU1_C<= "0000000000000000";
    carry<= '0';
    zero<= '0';
		x<="00000000000000000";

    end if;
end process; 
end alu1_beh;    

       
