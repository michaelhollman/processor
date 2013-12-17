library ieee;
use ieee.std_logic_1164.all;

entity Controller is
	port(
		opCode : in std_logic_vector(3 downto 0);
		RegDst : out bit;
		Branch : out bit;
		MemRead : out bit;
		MemtoReg : out bit;
		MemWrite : out bit;
		ALUSrc : out bit;
		RegWrite : out bit;
		Jump : out bit;
		JumpReg : out bit;
		ALUOp : out std_logic_vector(2 downto 0)
	);
end Controller;

architecture arc of Controller is 
begin

	process(opCode) is
	begin
		case opCode is
			when "0000" =>
				-- R-Type instructions (sent to the ALU)
				-- and, or, xor, sll, srl, add, sub, slt
				RegDst <= '1';
				Branch <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				RegWrite <= '1';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "000";
			when "0001" =>
				-- addiu
				RegDst <= '0';
				Branch <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '1';
				RegWrite <= '1';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "010";
			when "0010" =>
				-- subiu
				RegDst <= '0';
				Branch <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '1';
				RegWrite <= '1';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "011";
			when "0011" =>
				-- addi
				RegDst <= '0';
				Branch <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '1';
				RegWrite <= '1';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "010";
			when "0100" =>
				-- subi
				RegDst <= '0';
				Branch <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '1';
				RegWrite <= '1';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "011";
			when "0101" =>
				-- j
				RegDst <= '0';
				Branch <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				RegWrite <= '0';
				Jump <= '1';
				JumpReg <= '0';
				ALUOp <= "000";
			when "0110" =>
				-- jr
				RegDst <= '0';
				Branch <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				RegWrite <= '0';
				Jump <= '0';
				JumpReg <= '1';
				ALUOp <= "000";
			when "0111" =>
				-- jal
				-- TODO: Figure this one out
			when "1000" =>
				-- beq
				RegDst <= '0';
				Branch <= '1';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				RegWrite <= '0';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "011";
			when "1001" =>
				-- bne
				RegDst <= '0';
				Branch <= '1';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '0';
				ALUSrc <= '0';
				RegWrite <= '0';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "011";
			when "1010" =>
				-- lw
				RegDst <= '0';
				Branch <= '0';
				MemRead <= '1';
				MemtoReg <= '1';
				MemWrite <= '0';
				ALUSrc <= '1';
				RegWrite <= '1';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "010";
			when "1011" =>
				-- sw		
				RegDst <= '0';
				Branch <= '0';
				MemRead <= '0';
				MemtoReg <= '0';
				MemWrite <= '1';
				ALUSrc <= '1';
				RegWrite <= '0';
				Jump <= '0';
				JumpReg <= '0';
				ALUOp <= "010";
			when others =>
				-- Do nothing
		end case;
	end process;

end architecture;