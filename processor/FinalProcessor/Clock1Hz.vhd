ENTITY Clock1Hz IS
     PORT ( 
		reset: 	IN BIT;
		clk:	IN BIT;
		clock:	OUT BIT
        );
END Clock1Hz;

ARCHITECTURE a OF Clock1Hz IS
	SIGNAL clockTmp: BIT;
BEGIN
PROCESS (reset, clk)
    VARIABLE cnt : INTEGER RANGE 0 TO 12587;
BEGIN
    IF (reset = '1') THEN
        clockTmp <= '0';
        cnt := 0;
	ELSIF (clk'EVENT AND clk = '1') THEN
		IF (cnt = 12587) THEN
           	cnt := 0;
           	clockTmp <= NOT clockTmp;
        ELSE
   			cnt := cnt + 1;
	    END IF;
	END IF;
END PROCESS;

clock <= clockTmp;	
END a;

