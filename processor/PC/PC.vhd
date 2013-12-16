library IEEE;
use IEEE.std_logic_1164.all;

-- program counter
-- michaelhollman

entity PC is 
	port(
		clk:	in	std_logic;
		input:	in	std_logic_vector(7 downto 0);
		output:	out	std_logic_vector(7 downto 0)
	);
end PC;

architecture dataflow of PC is
begin
	process(clk)
	begin
		if RISING_EDGE(clk) then
			output <= input;
		end if;
	end process;
end dataflow;