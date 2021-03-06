-- Arithmetic Logic Unit
-- Author: Ryan Erdmann
-- Date: 12/15/2013

-- Supports the following operations: and, or, xor, add, sub, sl, sll, srl

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
	port(
		inputOne, inputTwo : in std_logic_vector(7 downto 0);
		aluCode : in std_logic_vector(2 downto 0);
		output : out std_logic_vector(7 downto 0);
		zero, overflow : out bit
	);
end ALU;

-- ALU Codes
-- 000 and 
-- 001 or 
-- 010 add
-- 011 sll
-- 100 slt
-- 101 xor
-- 110 sub
-- 111 srl

architecture architectureALU of ALU is
begin
	process(aluCode)
		variable extendedOne, extendedTwo, overflowSum : std_logic_vector(15 downto 0);
	begin
		if aluCode = "000" then
			-- and
			output <= inputOne and inputTwo;
		elsif aluCode = "001" then
			-- or
			output <= inputOne or inputTwo;
		elsif aluCode = "010" then
			-- add
			extendedOne := "00000000" & inputOne;
			extendedTwo := "00000000" & inputTwo;
			overflowSum := std_logic_vector(unsigned(extendedOne) + unsigned(extendedTwo));
			
			if (to_integer(unsigned(overflowSum(15 downto 8))) = 0) then
				overflow <= '0';
			else
				overflow <= '1';
			end if;				
			
			output <= std_logic_vector(unsigned(inputOne) + unsigned(inputTwo));
		elsif aluCode = "011" then
			-- sll
			output <= std_logic_vector(unsigned(inputOne) sll to_integer(unsigned(inputTwo)));
		elsif aluCode = "100" then
			-- slt
			if (inputOne < inputTwo) then
				output <= "00000001";
			else
				output <= "00000000";
			end if;
		elsif aluCode = "101" then
			-- xor
			output <= inputOne xor inputTwo;		
		elsif aluCode = "110" then
			-- sub
			output <= std_logic_vector(signed(inputOne) - signed(inputTwo));
			if (to_integer(signed(inputOne) - signed(inputTwo)) = 0) then
				zero <= '1';
			else 
				zero <= '0';
			end if;
		elsif aluCode = "111" then
			-- srl
			output <= std_logic_vector(unsigned(inputOne) srl to_integer(unsigned(inputTwo)));
		end if;
	end process;
end architectureALU;