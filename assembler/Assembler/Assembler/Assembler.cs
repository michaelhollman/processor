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
                    case InstructionType.R:
                        machineCode = GetRType(command);
                        break;
                    case InstructionType.I:
                        machineCode = GetIType(command);
                        break;
                    case InstructionType.J:
                        machineCode = GetJType(command);
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
                "\t[0..255]\t:\t000000000000000000000000000000000000;"
            };

            // Return header + results of second pass
            return Enumerable.Concat(header, binaryCommands).ToArray();
        }

        private string GetRType(Command command)
        {
            if (command.Tokens.Length != 4)
            {
                throw new Exception("RType instuctions must have the command and 3 arguments");
            }

            var instruction = OperationCodes.Instructions[command.Tokens[0]];
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

        private string GetIType(Command command)
        {
            return null;
        }

        private string GetJType(Command command)
        {
            return null;
        }

        private int ParseRegisterIndex(string value)
        {
            // Pattern: $X
            if (Regex.IsMatch(value, @"\d+$"))
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

        private string DecToBinary(int dec, int length)
        {
            return DecToBinary(dec).PadLeft(length, '0');
        }

        private string DecToBinary(int dec)
        {
            return Convert.ToString(dec, 2);
        }

        private int ParseValue(string value)
        {
            // Cases
            // X($Y)
            // $Y
            // Z

            if (Regex.IsMatch(value, @"\d+\(\$\d+\)$"))
            {
                var s1 = value.Substring(0, value.IndexOf('('));
                var s2 = value.Substring(value.IndexOf('$') + 1);
                s2 = s2.Substring(0, s2.Length - 1);

                var num1 = int.Parse(s1);
                var num2 = int.Parse(s2);

                var registerWidth = 8;

                return num1 * registerWidth; // TODO: check this

            }
            else if (Regex.IsMatch(value, @"\$\d+$"))
            {
                var s = value.Substring(1);
                var num = int.Parse(s);
                return num;
            }
            else if (Regex.IsMatch(value, @"\d+$"))
            {
                var num = int.Parse(value);
                return num;
            }
            else
            {
                // Error
            }

            return 1;
        }

    }
}
