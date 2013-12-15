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
		zero, overflow, carry : out bit
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
	begin
		if aluCode = "000" then
			-- and
			output <= std_logic_vector(inputOne and inputTwo);
			zero <= '0';
			overflow <= '0';
			carry <= '0';
		elsif aluCode = "001" then
			-- or
		elsif aluCode = "010" then
			-- add
		elsif aluCode = "011" then
			-- sll
		elsif aluCode = "100" then
			-- slt
		elsif aluCode = "101" then
			-- xor
		elsif aluCode = "110" then
			-- sub
		elsif aluCode = "111" then
			-- srl
		end if;
	end process;
end architectureALU;