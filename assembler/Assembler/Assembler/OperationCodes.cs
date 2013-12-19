using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    public class OperationCodes
    {
        public static Dictionary<string, OperationCode> Instructions { get; set; }
        static OperationCodes()
        {
            Instructions = new Dictionary<string, OperationCode>();

            // These MUST match up with the values in the Controller and the ALU
            Instructions.Add("and", new OperationCode("and", InstructionType.R, "0000", "000"));
            Instructions.Add("or", new OperationCode("or", InstructionType.R, "0000", "001"));
            Instructions.Add("xor", new OperationCode("xor", InstructionType.R, "0000", "101"));
            Instructions.Add("sll", new OperationCode("sll", InstructionType.R, "0000", "011"));
            Instructions.Add("srl", new OperationCode("srl", InstructionType.R, "0000", "111"));
            Instructions.Add("add", new OperationCode("add", InstructionType.R, "0000", "010"));
            Instructions.Add("sub", new OperationCode("sub", InstructionType.R, "0000", "110"));
            Instructions.Add("slt", new OperationCode("slt", InstructionType.R, "0000", "100"));

            Instructions.Add("addiu", new OperationCode("addiu", InstructionType.I, "0001"));
            Instructions.Add("subiu", new OperationCode("subiu", InstructionType.I, "0010"));
            Instructions.Add("addi", new OperationCode("addi", InstructionType.I, "0011"));
            Instructions.Add("subi", new OperationCode("subi", InstructionType.I, "0100"));
            Instructions.Add("beq", new OperationCode("beq", InstructionType.I, "1000"));
            Instructions.Add("bne", new OperationCode("bne", InstructionType.I, "1001"));
            Instructions.Add("lw", new OperationCode("lw", InstructionType.I, "1010"));
            Instructions.Add("sw", new OperationCode("sw", InstructionType.I, "1011"));

            Instructions.Add("j", new OperationCode("j", InstructionType.J, "0101"));
            Instructions.Add("jr", new OperationCode("jr", InstructionType.R, "0110"));
            //Instructions.Add("jal", new OperationCode("jal", InstructionType.J, "0111"));

            Instructions.Add("noop", new OperationCode("noop", InstructionType.NoOp, "0000"));
        }
    }

    public class OperationCode 
    {
        public string Instruction { get; set; }
        public InstructionType InstructionType { get; set; }
        public string OpCode { get; set; }
        public string ALUCode { get; set; }

        public OperationCode(string instruction, InstructionType type, string opCode)
        {
            Instruction = instruction;
            InstructionType = type;
            OpCode = opCode;
        }

        public OperationCode(string instruction, InstructionType type, string opCode, string aluCode) : this(instruction, type, opCode)
        {
            ALUCode = aluCode;
        }
    }
}
