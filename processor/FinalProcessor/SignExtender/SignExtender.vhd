library IEEE;
use IEEE.std_logic_1164.all;

entity SignExtender is
	port(
		input:	in	std_logic_vector(5 downto 0);
		output:	out	std_logic_vector(7 downto 0)
	);
end SignExtender;

architecture dataflow of SignExtender is
begin
	process(input)
	begin
		output <= "00" & input;
	end process;
end dataflow;