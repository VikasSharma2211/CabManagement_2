using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NUnit.Framework;
using Assert = NUnit.Framework.Assert;

namespace UnitTestProjectTestApp
{
    [TestFixture]
    public class UnitTest1
    {
        [TestCase]
        public void TestMethod1()
        {

            MinusLib.Minus m1 = new MinusLib.Minus();
            Assert.AreEqual(1.0,m1.Subtract(4,1),"It means Minus is not working as expected");            
        }
    }
}
