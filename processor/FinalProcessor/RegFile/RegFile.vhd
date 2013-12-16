library IEEE;
use IEEE.std_logic_1164.all;

-- janky 8 register reg-file. Doesn't *actually* use registers, per se, but usees 8 signal values
-- michaelhollman

entity RegFile is
	port(
		clk_r, clk_w:	in	std_logic;
		RS, RT, RD:		in 	std_logic_vector(2 downto 0);
		RegWrite:		in	bit;
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
			if RS="000" then
				out1 <= "00000000";
			elsif RS="001" then
				out1 <= r1;
			elsif RS="010" then
				out1 <= r2;
			elsif RS="011" then
				out1 <= r3;
			elsif RS="100" then
				out1 <= r4;
			elsif RS="101" then
				out1 <= r5;
			elsif RS="110" then
				out1 <= r6;
			elsif RS="111" then
				out1 <= r7;
			end if;
			
			if RT="000" then
				out2 <= "00000000";
			elsif RT="001" then
				out2 <= r1;
			elsif RT="010" then
				out2 <= r2;
			elsif RT="011" then
				out2 <= r3;
			elsif RT="100" then
				out2 <= r4;
			elsif RT="101" then
				out2 <= r5;
			elsif RT="110" then
				out2 <= r6;
			elsif RT="111" then
				out2 <= r7;
			end if;
		end if;
	end process;
	
	process (clk_w)
	begin
		if clk_w'event and clk_w='1' then
			if RegWrite='1' then
				case RD is
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