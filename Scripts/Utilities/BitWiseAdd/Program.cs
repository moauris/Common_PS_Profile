using System;

namespace BitWiseAdd
{
    /// <summary>
    /// Performs Bitwise Add Operation in Verbose Mode.
    /// </summary>
    class Program
    {
        static void Main(string[] args)
        {
            int a = Convert.ToInt32(args[0]);
            int b = Convert.ToInt32(args[1]);
            Console.WriteLine($"Performing Calculation");
            Console.WriteLine($"============= DECIMAL =============");
            Console.WriteLine($"   {a.ToString().PadLeft(10, '0')}");
            Console.WriteLine($"+  {b.ToString().PadLeft(10, '0')}");
            Console.WriteLine($"{new string((char)0x2500, 14)}");
            int ans = a + b;
            Console.WriteLine($"   {ans.ToString().PadLeft(10, '0')}");

            Console.WriteLine(new string('\n', 3));
            Console.WriteLine($"============= BINARY =============");
            Console.WriteLine($"   {Convert.ToString(a, 2).PadLeft(32, '0')}");
            Console.WriteLine($"+  {Convert.ToString(b, 2).PadLeft(32, '0')}");
            Console.WriteLine($"{new string((char)0x2500, 36)}");
            Console.WriteLine($"   {Convert.ToString(ans, 2).PadLeft(32, '0')}");
        }
    }
}
