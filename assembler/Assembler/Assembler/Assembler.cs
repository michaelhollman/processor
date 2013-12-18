using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Assembler
{
    public class Assembler
    {
        public string[] AssemblyCode { get; set; }

        public Assembler(string[] assemblyCode)
        {
            AssemblyCode = assemblyCode;
        }

        public string[] GetMachineCode()
        {
            var labels = new List<Label>();
            var commands = new List<Command>();

            // First pass.  Parse out labels and commands
            for (var i = 0; i < AssemblyCode.Count(); i++)
            {
                // Pull out the line of assembly
                var line = AssemblyCode[i];

                // Take care of the label if it exists
                if (line.Contains(':'))
                {
                    var name = line.Substring(0, line.IndexOf(':'));
                    labels.Add(new Label { Name = name, Index = i });

                    // Remove the label from the line
                    line = line.Substring(line.IndexOf(':') + 1); 
                }

                // Tokenize the line.  First will be the instruction
                var tokens = line.Split(new char[] { ' ', '\t', ',' }, StringSplitOptions.RemoveEmptyEntries);
                commands.Add(new Command { Tokens = tokens, Index = i });
            }

            // Second pass.  Convert each command to machine code
            var binaryCommands = new List<string>();
            foreach (var command in commands)
            {
                var instruction = OperationCodes.Instructions[command.Tokens[0]];
                
                var machineCode = "";
                switch (instruction.InstructionType)
                {
                    case InstructionType.NoOp:
                        machineCode = GetNoOp(command);
                        break;
                    case InstructionType.R:
                        machineCode = GetRType(command);
                        break;
                    case InstructionType.I:
                        machineCode = GetIType(command, labels);
                        break;
                    case InstructionType.J:
                        machineCode = GetJType(command, labels);
                        break;
                }

                binaryCommands.Add(String.Format("\t{0}\t:\t{1};", command.Index, machineCode));
            }

            // Add header
            var header = new string[] 
            {
                "DEPTH = 256;",
                "WIDTH = 16;",
                "ADDRESS_RADIX = DEC;",
                "DATA_RADIX = BIN;",
                "",
                "CONTENT",
                "\tBEGIN",
                "\t[0..255]\t:\t0000000000000000;"
            };

            // Add footer
            var footer = new string[] 
            {
                "END;"
            };

            // Return header + results of second pass
            return Enumerable.Concat(Enumerable.Concat(header, binaryCommands), footer).ToArray();
        }

        private string GetNoOp(Command command)
        {
            // Use: Add $0 to $0 and store to $0 as our noop
            var noopCommand = new Command
            {
                Index = command.Index,
                Tokens = new string[] { "add", "$0", "$0", "$0" }
            };
            return GetRType(noopCommand);
        }

        private string GetRType(Command command)
        {
            var instruction = OperationCodes.Instructions[command.Tokens[0]];

            if (instruction.Instruction == "jr")
            {
                return ""; // TODO: implement
            }
            
            if (command.Tokens.Length != 4)
            {
                throw new Exception("RType instuctions must have the command and 3 arguments");
            }

            var rd = ParseRegisterIndex(command.Tokens[1]);
            var rs = ParseRegisterIndex(command.Tokens[2]);
            var rt = ParseRegisterIndex(command.Tokens[3]);

            return String.Format("{0}{1}{2}{3}{4}",
                 instruction.OpCode,
                 DecToBinary(rd, 3),
                 DecToBinary(rs, 3),
                 DecToBinary(rt, 3),
                 instruction.ALUCode);
        }

        private string GetIType(Command command, List<Label> labels)
        {
            var instruction = OperationCodes.Instructions[command.Tokens[0]];
            var code = instruction.Instruction;
            
            var rd = ParseRegisterIndex(command.Tokens[1]);
            var rs = 0;
            var immediate = 0;

            if (code == "beq" || code == "bne")
            {
                // Format: beq $rd, $rs, label
                rs = ParseRegisterIndex(command.Tokens[2]);

                var label = labels.FirstOrDefault(l => l.Name == command.Tokens[3]);
                if (label == null)
                {
                    throw new Exception("Cannot find label");
                }
                immediate = label.Index;
            }
            else if (code == "lw" || code == "sw")
            {
                // Format: lw $rd, offset($rs)
                var offsetAndRegister = command.Tokens[2].Split(new char[] { '(', ')' }, StringSplitOptions.RemoveEmptyEntries);
                immediate = ParseOffset(offsetAndRegister[0]);
                rs = ParseRegisterIndex(offsetAndRegister[1]);
            }
            else
            {
                rs = ParseRegisterIndex(command.Tokens[2]);
                immediate = ParseImmediate(command.Tokens[3]);
            }

            return String.Format("{0}{1}{2}{3}",
                 instruction.OpCode,
                 DecToBinary(rd, 3),
                 DecToBinary(rs, 3),
                 DecToBinary(immediate, 6));
        }

        private string GetJType(Command command, List<Label> labels)
        {
            var instruction = OperationCodes.Instructions[command.Tokens[0]];

            var immediate = 0;

            var isLabel = true;
            try
            {
                immediate = ParseImmediate(command.Tokens[1]);
                isLabel = false;
            }
            catch (Exception e) { } // Do nothing; we have the flag

            if (isLabel)
            {
                var label = labels.FirstOrDefault(l => l.Name == command.Tokens[1]);
                if (label == null)
                {
                    throw new Exception("Cannot find label");
                }
                immediate = label.Index;
            }

            return String.Format("{0}{1}{2}",
                instruction.OpCode,
                DecToBinary(0, 6),
                DecToBinary(immediate, 6));
        }

        private int ParseRegisterIndex(string value)
        {
            if (Regex.IsMatch(value, @"^\$\d+$")) // $X
            {
                var s = value.Substring(1);
                var num =  int.Parse(s);
                if (num > 7 || num < 0) {
                    throw new Exception("Please enter a register index from 0 to 7");
                }
                return num;
            }
            else
            {
                throw new Exception("Register is an invalid format.  Please enter it as $X, where X is an integer from 0 to 7.");
            }
        }

        private int ParseImmediate(string value)
        {
            if (Regex.IsMatch(value, @"^\d+$")) // X
            {
                return int.Parse(value);
            }
            else
            {
                throw new Exception("Immediate value is in an invalid format");
            }
        }

        private int ParseOffset(string value)
        {
            if (Regex.IsMatch(value, @"^\d+$"))
            {
                var num = int.Parse(value);
                var registerWidth = 8;
                return num * registerWidth;
            }
            else
            {
                throw new Exception("Cannot parse offset.");
            }
        }

        private string DecToBinary(int dec, int length)
        {
            return DecToBinary(dec).PadLeft(length, '0');
        }

        private string DecToBinary(int dec)
        {
            return Convert.ToString(dec, 2);
        }

    }
}
