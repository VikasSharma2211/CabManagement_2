using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Testing for commiting and checking");
            Console.WriteLine("Second time commit in program");
            Console.WriteLine("3rd time commit in program");
            Console.WriteLine("4th time commit in program");
            Console.WriteLine("Changes Tuesday 11:45 AM");
            Console.WriteLine("Changes Tuesday 11:52 AM");
            Console.WriteLine("Changes Tuesday 2:28 PM");
            Console.WriteLine("Changes Tuesday 3:33 PM");
            Console.WriteLine("Changes Tuesday 11:32 am with varun");
            Console.WriteLine("Changes Tuesday 12:20 pm with varun");

            Console.WriteLine("Changes Thursday 11:30 AM with Vikas");
            Console.WriteLine("Changes Thursday second change at 11:40 AM with Vikas");
            Console.WriteLine("Changes Thursday second change at 12:21 pm with Yogesh");
            Console.WriteLine("Changes Thursday second change at 12:44 pm with Yogesh");
            Console.WriteLine("Changes Thursday second change at 10:45 AM with Robin");
            Console.WriteLine("Changes Sunday First change at 4:50 PM with Vikas");
            Console.WriteLine("Changes Monday First change at 9:40 AM with Vikas");
            Console.WriteLine("Changes Monday First change at 10:00 AM with Vikas");

            Console.WriteLine("Changes Monday Second change at 4:35 PM with Vikas");
            SumLib.Sum s1 = new SumLib.Sum();
            MinusLib.Minus m1 = new MinusLib.Minus();
            Console.WriteLine("Sum of two value is :" + s1.Add(10, 34));
            Console.WriteLine("Sum of two value is :" + m1.Subtract(23,20));
            Console.WriteLine("Changes Thursday Second change at 5:55 PM with Vikas");
            Console.WriteLine("Changes Friday First change at 4:00 PM with KWJ");
            Console.WriteLine("Changes Friday second change at 5:00 PM with Avishar");
            Console.WriteLine("Changes Monday first change at 10:00 AM with Vikas");
            Console.WriteLine("Changes Tuesday first change at 2:30:00 PM with Vikas");
            Console.ReadLine();
        }
    }
}
