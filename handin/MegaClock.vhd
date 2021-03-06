-- adapted from provided clk_0Hz.vhd
-- michaelhollman

entity MegaClock is
	port ( 
		reset: 		in	bit;
		clk_board:	in	bit;
		clk_0:	out	bit;
		clk_1:	out bit;
		clk_2:	out bit;
		clk_3: out bit;
		clk_4: out bit
	);
end MegaClock;

architecture dataflow of MegaClock is
	begin
	process (reset, clk_board)
		variable clk_sys: integer range 0 to 12587;
		variable clk_out: integer range 0 to 4;
		
		begin
			if (reset = '1') then
				clk_sys := 0;
				clk_out := 0;
			elsif (clk_board'event and clk_board = '1') then
				-- change this number to change total clock speed
				if (clk_sys = 12000) then
					if (clk_out = 0) then
						clk_0 <= '1';
						clk_1 <= '0';
						clk_2 <= '0';
						clk_3 <= '0';
						clk_4 <= '0';
						clk_out := 1;
					elsif (clk_out = 1) then
						clk_0 <= '0';
						clk_1 <= '1';
						clk_2 <= '0';
						clk_3 <= '0';
						clk_4 <= '0';
						clk_out := 2;
					elsif (clk_out = 2) then
						clk_0 <= '0';
						clk_1 <= '0';
						clk_2 <= '1';
						clk_3 <= '0';
						clk_4 <= '0';
						clk_out := 3;
					elsif (clk_out = 3) then
						clk_0 <= '0';
						clk_1 <= '0';
						clk_2 <= '0';
						clk_3 <= '1';
						clk_4 <= '0';
						clk_out := 4;
					elsif (clk_out = 4) then
						clk_0 <= '0';
						clk_1 <= '0';
						clk_2 <= '0';
						clk_3 <= '0';
						clk_4 <= '1';
						clk_out := 0;
					end if;
				else
					clk_sys := clk_sys + 1;
				end if;
			end if;
	end process;
end dataflow;