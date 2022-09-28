using System;
using Example.Solutiuon2.Models;

namespace Example.Solution2.UnitTests.Models
{
    public class ProductTests
    {
        [Fact]
        public void Assert_Product_Model_Has_Id_Propert_Type_Of_String()
        {
            // arrange
            var id = "abc-123";

            //act

            Product product = new Product()
            {
                Id = id
            };

            //assert

            Assert.True(id == product.Id);

        }
    }
}

