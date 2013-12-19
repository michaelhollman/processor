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
            var basePath = Directory.GetCurrentDirectory();

            Console.Write("Enter file to compile: ");
            var fileName = Console.ReadLine();
            if (fileName.EndsWith(".s")) fileName = fileName.Substring(0, fileName.Length - 2);

            try
            {
                var inputPath = String.Format("{0}\\{1}.s", basePath, fileName);
                var lines = File.ReadAllLines(inputPath);
                Console.WriteLine("Assembly file read from {0}", inputPath);

                var assembler = new Assembler(lines);
                var mif = assembler.GetMachineCode();

                if (assembler.Success)
                {
                    var outputPath = String.Format("{0}\\{1}.mif", basePath, fileName);
                    File.WriteAllLines(outputPath, mif);
                    Console.WriteLine("MIF file saved to {0}", outputPath);
                }
                else
                {
                    Console.WriteLine("Due to errors, the program was not assembled");
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Sorry, it looks like there was an error. {0}", e.Message);
            }

            Console.WriteLine("Press any key to exit...");
            Console.Read();
        }
    }
}
