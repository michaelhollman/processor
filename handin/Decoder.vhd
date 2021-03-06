library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decoder is 
	port(
		instruction : in std_logic_vector(15 downto 0);
		opCode : out std_logic_vector(3 downto 0);
		aluCode : out std_logic_vector(2 downto 0);
		rs, rt, rd : out std_logic_vector(2 downto 0);
		immediate: out std_logic_vector(5 downto 0)
	);
end Decoder;
		
architecture arc of Decoder is
begin
	process (instruction)
	begin
		opCode <= instruction(15 downto 12);
		aluCode <= instruction (2 downto 0);
		rd <= instruction(11 downto 9);
		rs <= instruction(8 downto 6);
		rt <= instruction(5 downto 3);
		immediate <= instruction(5 downto 0);
	end process;
end arc;