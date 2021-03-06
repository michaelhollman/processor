library IEEE;
use IEEE.std_logic_1164.all;

-- janky 8 register reg-file. Doesn't *actually* use registers, per se, but usees 8 signal values
-- michaelhollman

entity RegFile is
	port(
		clk_r, clk_w:	in	std_logic;
		rs, rt, rd:		in 	std_logic_vector(2 downto 0);
		RegWrite:		in	bit;
		r7_overflow:	in 	std_logic;
		WriteData:		in	std_logic_vector(7 downto 0);
		out1, out2:		out std_logic_vector(7 downto 0)
	);
end RegFile;

architecture processRegisters of RegFile is

-- use 8 "static variables" for registers
signal r0, r1, r2, r3, r4, r5, r6, r7 : std_logic_vector(7 downto 0) := "00000000";
	
begin
	process(clk_r)
	begin
		if clk_r'event and clk_r='1' then
			if rs="000" then
				out1 <= "00000000";
			elsif rs="001" then
				out1 <= r1;
			elsif rs="010" then
				out1 <= r2;
			elsif rs="011" then
				out1 <= r3;
			elsif rs="100" then
				out1 <= r4;
			elsif rs="101" then
				out1 <= r5;
			elsif rs="110" then
				out1 <= r6;
			elsif rs="111" then
				out1 <= r7;
			end if;
			
			if rt="000" then
				out2 <= "00000000";
			elsif rt="001" then
				out2 <= r1;
			elsif rt="010" then
				out2 <= r2;
			elsif rt="011" then
				out2 <= r3;
			elsif rt="100" then
				out2 <= r4;
			elsif rt="101" then
				out2 <= r5;
			elsif rt="110" then
				out2 <= r6;
			elsif rt="111" then
				out2 <= r7;
			end if;
		end if;
	end process;
	
	process (clk_w)
	begin
		if clk_w'event and clk_w='1' then
			r7 <= "0000000" & r7_overflow;
			if RegWrite='1' then
				case rd is
					when "000" => r0 <= "00000000";
					when "001" => r1 <= WriteData;
					when "010" => r2 <= WriteData;
					when "011" => r3 <= WriteData;
					when "100" => r4 <= WriteData;
					when "101" => r5 <= WriteData;
					when "110" => r6 <= WriteData;
					when "111" => r7 <= WriteData;
				end case;
			end if;
		end if;
	end process;
end processRegisters;