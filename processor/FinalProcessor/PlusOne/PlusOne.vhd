library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- +1'er for PC
-- michaelhollman

entity PlusOne is
	port(
		input:	in	std_logic_vector(7 downto 0);
		output:	out	std_logic_vector(7 downto 0)
	);
end PlusOne;

architecture dataflow of PlusOne is
begin
	process(input)
	begin
		output <= std_logic_vector(unsigned(input) + 1);
	end process;
end dataflow;