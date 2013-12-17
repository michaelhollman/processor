using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
            return null;
        }

        private string GetIType(Command command)
        {
            return null;
        }

        private string GetJType(Command command)
        {
            return null;
        }

    }
}
