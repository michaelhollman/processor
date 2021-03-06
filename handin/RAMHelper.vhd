library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RAMHelper is
	port(
		clk:		in	std_logic;
		we:			in	bit;
		address:	in 	std_logic_vector(7 downto 0);
		data:		in 	std_logic_vector(7 downto 0);
		
		button_1:	in	bit;
		button_2:	in	bit;
		dipSwitch:	in	std_logic_vector(7 downto 0);

		digit_l:	out	std_logic_vector(3 downto 0);
		digit_r:	out	std_logic_vector(3 downto 0);
		decimal_l:	out bit;
		decimal_r:	out bit;
		
		output:		out std_logic_vector(7 downto 0);
		override:	out bit
	);
end RAMHelper;

architecture dataflow of RAMHelper is
begin
	process(clk)
	begin
		if (clk'event and clk='1') then
			-- writing values; aka display values
			if (we = '1') then
				if (address = "00000000") then
					digit_l <= data(7 downto 4);
					digit_r <= data(3 downto 0);
				elsif (address = "00000001") then
					decimal_l <= to_bit(data(0));
				elsif (address = "00000010") then
					decimal_r <= to_bit(data(0));
				end if;
				
			-- read values; aka pass along button/dipswitch values
			else
				if (address = "00000000") then
					output <= dipSwitch;
					override <= '1';
				elsif (address = "00000001") then
					if (button_1 = '1') then
						output <= "00000001";
						override <= '1';
					else
						output <= "00000000";
						override <= '1';
					end if;
				elsif (address = "00000010") then
					if (button_2 = '1') then
						output <= "00000001";
						override <= '1';
					else
						output <= "00000000";
						override <= '1';
					end if;
				else
					override <= '0';
				end if;
			end if;
		end if;
	end process;
end dataflow;