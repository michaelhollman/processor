library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SevenSegmentDisplay is
	port(
		input : in std_logic_vector(3 downto 0);
		output: out std_logic_vector(6 downto 0)
		--a, b, c, d, e, f, g : out bit
	);
end SevenSegmentDisplay;

architecture arc of SevenSegmentDisplay is
signal a,b,c,d,e,f,g: std_logic;
begin
	process(input)
	begin
		case input is
			when "0000" => 
				--0
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '0';
			when "0001" =>
				a <= '0';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '0';
				f <= '0';
				g <= '0';				
			when "0010" => 
				a <= '1';
				b <= '1';
				c <= '0';
				d <= '1';
				e <= '1';
				f <= '0';
				g <= '1';
			when "0011" =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '1';
				e <= '0';
				f <= '0';
				g <= '1';
			when "0100" =>
				a <= '0';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '0';
				f <= '1';
				g <= '1';
			when "0101" =>
				a <= '1';
				b <= '0';
				c <= '1';
				d <= '1';
				e <= '0';
				f <= '1';
				g <= '1';
			when "0110" =>
				a <= '1';
				b <= '0';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '1';
			when "0111" =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '0';
				f <= '0';
				g <= '0';
			when "1000" =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '1';
			when "1001" =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '0';
				f <= '1';
				g <= '1';
			when "1010" =>
				--A
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '1';
				f <= '1';
				g <= '1';
			when "1011" =>
				--B
				a <= '0';
				b <= '0';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '1';
			when "1100" =>
				--C
				a <= '1';
				b <= '0';
				c <= '0';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '0';
			when "1101" =>
				--D
				a <= '0';
				b <= '1';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '0';
				g <= '1';
			when "1110" =>
				--E
				a <= '1';
				b <= '0';
				c <= '0';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '1';
			when "1111" =>
				--F
				a <= '1';
				b <= '0';
				c <= '0';
				d <= '0';
				e <= '1';
				f <= '1';
				g <= '1';
			when others =>
				a <= '0';
				b <= '0';
				c <= '0';
				d <= '0';
				e <= '0';
				f <= '0';
				g <= '1';
		end case;	
	output <= a & b & c & d & e & f & g;	
	end process;
end arc;