using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Assembler
{
    public class Label
    {
        public int Index { get; set; }
        public string Name { get; set; }
    }

    public class Command
    {
        public int Index { get; set; }
        public string[] Tokens { get; set; }
    }
}
