library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SevenSegmentDisplay is
	port(
		input : in std_logic_vector(7 downto 0);
		a, b, c, d, e, f, g : out bit
	);
end SevenSegmentDisplay;

architecture arc of SevenSegmentDisplay is
begin
	process(input)
	begin
		case to_integer(unsigned(input)) is
			when 0 => 
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '0';
			when 1 =>
				a <= '0';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '0';
				f <= '0';
				g <= '0';				
			when 2 => 
				a <= '1';
				b <= '1';
				c <= '0';
				d <= '1';
				e <= '1';
				f <= '0';
				g <= '1';
			when 3 =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '1';
				e <= '0';
				f <= '0';
				g <= '1';
			when 4 =>
				a <= '0';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '0';
				f <= '1';
				g <= '1';
			when 5 =>
				a <= '1';
				b <= '0';
				c <= '1';
				d <= '1';
				e <= '0';
				f <= '1';
				g <= '1';
			when 6 =>
				a <= '1';
				b <= '0';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '1';
			when 7 =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '0';
				f <= '0';
				g <= '0';
			when 8 =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '1';
			when 9 =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '0';
				f <= '1';
				g <= '1';
			when 10 =>
				a <= '1';
				b <= '1';
				c <= '1';
				d <= '0';
				e <= '1';
				f <= '1';
				g <= '1';
			when 11 =>
				a <= '0';
				b <= '0';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '1';
			when 12 =>
				a <= '1';
				b <= '0';
				c <= '0';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '0';
			when 13 =>
				a <= '0';
				b <= '1';
				c <= '1';
				d <= '1';
				e <= '1';
				f <= '0';
				g <= '1';
			when 14 =>
				a <= '1';
				b <= '0';
				c <= '0';
				d <= '1';
				e <= '1';
				f <= '1';
				g <= '1';
			when 15 =>
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
				g <= '0';
		end case;		
	end process;
end arc;