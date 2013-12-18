using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    class Program
    {
        static void Main(string[] args)
        {
            var inputPath = "C:/Repos/processor/docs/SampleAssemblyProgram.s";
            var lines = File.ReadAllLines(inputPath);
            var assembler = new Assembler(lines);
            var mif = assembler.GetMachineCode();
            var outputPath = "C:/Users/Ryan/Desktop/program.mif";
            File.WriteAllLines(outputPath, mif);

            Console.WriteLine("Press any key to exit...");
            Console.ReadLine();
        }
    }
}
