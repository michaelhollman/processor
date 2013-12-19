library IEEE;
use IEEE.std_logic_1164.all;

-- program counter
-- michaelhollman

entity PC is 
	port(
		clk:	in	std_logic;
		reset:	in	std_logic;
		input:	in	std_logic_vector(7 downto 0);
		output:	out	std_logic_vector(7 downto 0)
	);
end PC;

architecture dataflow of PC is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if (reset = '1') then
				output <= "00000000";
			else
				output <= input;
			end if;
		end if;
	end process;
end dataflow;