library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(1 downto 0); -- # fill input bits to your design.
       	output_vector: out std_logic_vector(55 downto 0));-- # fill output bits from your design.
end entity;

architecture DutWrap of DUT is
   component datapath is

	port (clk, reset: in std_logic; finalout: out std_logic_vector(55 downto 0));

	end component datapath;
	
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the tracefile!
   flag_instance: datapath
			port map (
			
					-- order of inputs clock rst
					
					clk=>input_vector(1),
					reset=>input_vector(0),
				
					
					finalout=> output_vector(55 downto 0));
					
end DutWrap;