-- honestly not quite sure what this is doing,
-- I just know that sometimes we need to use the immediate value when we do branchy things
-- michaelhollman

library IEEE;
use IEEE.std_logic_1164.all;

entity ALUController is
	port(
		aluCode:	in std_logic_vector(2 downto 0);
		aluOp:		in std_logic_vector(2 downto 0);
		output:		out std_logic_vector(2 downto 0)
	);
end ALUController;

architecture dataflow of ALUController is
begin
	process(aluOp)
	begin
		if (aluOp = "000") then
			output <= aluCode;
		else
			output <= aluOp;
		end if;
	end process;
end dataflow;