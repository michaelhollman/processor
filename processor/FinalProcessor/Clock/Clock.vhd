-- adapted from provided Clock1Hz.vhd
-- michaelhollman

entity Clock is
	port ( 
		reset: 		in	bit;
		clock_sys:	in	bit;
		clock_pc:	out	bit;
		clock_ir:	out bit;
		clock_wb:	out bit
	);
end Clock;

architecture dataflow of Clock is
	begin
	process (reset, clock_sys)
		variable cycle: integer range 0 to 12587;
		variable outclock: integer range 0 to 2;
		
		begin
			if (reset = '1') then
				cycle := 0;
				outclock := 0;
			elsif (clock_sys'event and clock_sys = '1') then
				-- change this number to change total clock speed
				if (cycle = 12000) then
					if (outclock = 0) then
						clock_pc <= '1';
						clock_ir <= '0';
						clock_wb <= '0';
					elsif (outclock = 1) then
						clock_pc <= '0';
						clock_ir <= '1';
						clock_wb <= '0';
					elsif (outclock = 2) then
						clock_pc <= '0';
						clock_ir <= '0';
						clock_wb <= '1';
					end if;
					outclock := outclock + 1;
				else
					cycle := cycle + 1;
				end if;
			end if;
	end process;
end dataflow;