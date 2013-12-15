-- Arithmetic Logic Unit
-- Author: Ryan Erdmann
-- Date: 12/15/2013

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is

	port(
		inputOne, inputTwo : in std_logic_vector(7 downto 0);
		aluCode : in std_logic_vector(2 downto 0);
		output : out std_logic_vector(7 downto 0);
		zero : out bit;
		overflow : out bit;
		carry : out bit
	);

end ALU;

-- ALU Codes
-- 000 and
-- 001 or
-- 010 add
-- 011 sub
-- 100 xor
-- 101 slt
-- 110 shift-left-logical
-- 111 shift-right-logical
