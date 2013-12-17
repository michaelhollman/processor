-- adapted from provided clock0Hz.vhd
-- michaelhollman

entity Clock is
	port ( 
		reset: 		in	bit;
		clock_sys:	in	bit;
		clock0:	out	bit;
		clock1:	out bit;
		clock2:	out bit;
		clock3: out bit;
		clock4: out bit
	);
end Clock;

architecture dataflow of Clock is
	begin
	process (reset, clock_sys)
		variable cycle: integer range 0 to 12587;
		variable outclock: integer range 0 to 4;
		
		begin
			if (reset = '1') then
				cycle := 0;
				outclock := 0;
			elsif (clock_sys'event and clock_sys = '1') then
				-- change this number to change total clock speed
				if (cycle = 12000) then
					if (outclock = 0) then
						clock0 <= '1';
						clock1 <= '0';
						clock2 <= '0';
						clock3 <= '0';
						clock4 <= '0';
					elsif (outclock = 1) then
						clock0 <= '0';
						clock1 <= '1';
						clock2 <= '0';
						clock3 <= '0';
						clock4 <= '0';
					elsif (outclock = 2) then
						clock0 <= '0';
						clock1 <= '0';
						clock2 <= '1';
						clock3 <= '0';
						clock4 <= '0';
					elsif (outclock = 3) then
						clock0 <= '0';
						clock1 <= '0';
						clock2 <= '0';
						clock3 <= '1';
						clock4 <= '0';
					elsif (outclock = 4) then
						clock0 <= '0';
						clock1 <= '0';
						clock2 <= '0';
						clock3 <= '0';
						clock4 <= '1';
					end if;
					outclock := outclock + 1;
				else
					cycle := cycle + 1;
				end if;
			end if;
	end process;
end dataflow;