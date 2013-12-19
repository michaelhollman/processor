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
            Console.WriteLine("Enter base repository directory:  ex: C:/git");
            var basePath = "c:/repos"; // Console.ReadLine();
            Console.WriteLine("Enter file to compile:");
            var program = Console.ReadLine();

            var inputPath = String.Format("{0}/processor/processor/FinalProcessor/{1}.s", basePath, program);
            var lines = File.ReadAllLines(inputPath);
            Console.WriteLine("Assembly file read from {0}", inputPath);
            var assembler = new Assembler(lines);
            var mif = assembler.GetMachineCode();
            var outputPath = String.Format("{0}/processor/processor/FinalProcessor/{1}.mif", basePath, program);
            File.WriteAllLines(outputPath, mif);
            Console.WriteLine("MIF file saved to {0}", outputPath);

            Console.WriteLine("Press any key to exit...");
            Console.ReadLine();
        }
    }
}
